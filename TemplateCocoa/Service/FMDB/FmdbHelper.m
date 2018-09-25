//
//  FmdbHelper.m
//  ESP
//
//  Created by turkeyaa on 15/11/24.
//  Copyright © 2015年 ds All rights reserved.
//

#import "FmdbHelper.h"

#import <FMDB/FMDB.h>
#import "NSObject+Property.h"

#import "UserModel.h"
#import "FileManager.h"

#if FMDB_SQLITE_STANDALONE
#import <sqlite3/sqlite3.h>
#else
#import <sqlite3.h>
#endif

@interface FmdbHelper ()

{
    FMDatabase *_db;
    FMDatabaseQueue *_dbQueue;
}

@end

@implementation FmdbHelper

+ (FmdbHelper *)shareInstance {
    static FmdbHelper *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[FmdbHelper alloc] init];
    });
    return _instance;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

/*
 * 打开数据库,不存在则重新创建
 */
- (BOOL)openDB {
    
    if (!_db) {
//        NSString *mobile = [Workspace currentUser].phone;
        NSString *mobile = @"123456789";
        _db = [FMDatabase databaseWithPath:[FileManager fmdbFileWithMobile:mobile]];
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:[FileManager fmdbFileWithMobile:mobile]];
    }
    
    if (![_db open]) {
        DLog(@"不能打开数据库");
        return NO;
    }
    else {
//        [_db setKey:ESP_Encryption];
    }
    return YES;
}

#pragma mark -
#pragma mark - 创建表
/*
 * 是否存在表
 */
- (BOOL)createTableByClassName:(NSString *)tableName {
    
    NSString *sql = [self dsCreateSql:tableName];
    return [_db executeUpdate:sql];
}

- (NSString *)dsCreateSql:(NSString *)tableName {
    
    Class clazz = NSClassFromString(tableName);
    NSString *sql = [clazz tableSql:tableName];
    return sql;
}
- (NSString *)dsInsertSql:(NSString *)tableName {
    
    Class clazz = NSClassFromString(tableName);
    NSString *sql = [clazz insertSql:tableName];
    return sql;
}

-(NSArray *)fMSetColumnArray:(FMResultSet *)fmset{
    FMStatement *statement = fmset.statement;
    int columnCount = sqlite3_column_count(statement.statement);
    NSMutableArray *columnArray = [NSMutableArray array];
    
    for (int columnIdx = 0; columnIdx < columnCount; columnIdx++) {
        NSString *columnName = [NSString stringWithUTF8String:sqlite3_column_name(statement.statement, columnIdx)];
        [columnArray addObject:columnName];
    }
    return columnArray;
}

/*
 * 插入数据
 */
- (BOOL)insertTableByClassName:(NSString *)tableName json:(NSDictionary *)json {
    // 1 - 是否存在table
    if (![self createTableByClassName:tableName]) {
        DLog(@"创建表失败了");
        return NO;
    }
    
    // 2 - 插入 sql
    NSString *sql = [self insertSql:tableName];
    
    // 3 - 插入数据
    __block BOOL rs = NO;
    if (json && sql) {
        if ([json isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = (NSDictionary *)json;
            
            [_dbQueue inDeferredTransaction:^(FMDatabase *db, BOOL *rollback) {
                rs = [self->_db executeUpdate:sql withParameterDictionary:dict];
                if (!rs) {
                    *rollback = YES;
                }
            }];
        }
        else if ([json isKindOfClass:[NSArray class]]) {

            NSArray *arra = (NSArray *)json;
            
            [_dbQueue inDeferredTransaction:^(FMDatabase *db, BOOL *rollback) {
                
                for (NSDictionary *dict in arra) {
                    rs = [self->_db executeUpdate:sql withParameterDictionary:dict];
                    if (!rs) {
                        *rollback = YES;
                    }
                }
            }];
        }
        else {
            RNAssert(NO, @"不支持的数据类型");
        }
    }
    
    return rs;
}

/*
 * 请求数据
 * tableName: 对应 Model 类名
 */
- (NSArray *)queryDbByClassName:(NSString *)tableName {
    NSString *sql = [NSString stringWithFormat:@"select * from %@",tableName];
    return [self queryDbByClassName:tableName sql:sql];
}
- (NSArray *)queryDbByClassName:(NSString *)tableName sql:(NSString *)sql {
    FMResultSet *rs = [_db executeQuery:sql];
    
    NSArray *columnArray = [self fMSetColumnArray:rs];
    
    NSMutableArray *array = [NSMutableArray array];
    NSString *key = nil;
    while ([rs next]) {
        NSMutableDictionary *syncDict = [[NSMutableDictionary alloc] init];
        
        for (int i=0; i<columnArray.count; i++) {
            
            key = columnArray[i];
            NSString *value = [rs stringForColumn:key];
            
            [syncDict setObject:value forKey:key];
        }
        
        [array addObject:syncDict];
    }
    
    if (array && array.count) {
        return array;
    }
    return nil;
}

/*
 * 请求数据
 * tableName: 对应 Model 类名
 * 返回数据为 Model 类型
 */
- (NSArray *)queryObjDbByClassName:(NSString *)tableName {
    NSString *sql = [NSString stringWithFormat:@"select * from %@",tableName];
    
    return [self queryObjDbByClassName:tableName sql:sql];
}
- (NSArray *)queryObjDbByClassName:(NSString *)tableName sortFlag:(BOOL)flag {
    NSString *sql = [NSString stringWithFormat:@"select * from %@",tableName];
    
    if (flag) {
        sql = [sql stringByAppendingFormat:@" ORDER BY %@ DESC",@"date"];
    }
    
    return [self queryObjDbByClassName:tableName sql:sql];
}

- (NSArray *)queryObjDbByClassName:(NSString *)tableName sql:(NSString *)sql {
    FMResultSet *rs = [_db executeQuery:sql];
    
    NSArray *columnArray = [self fMSetColumnArray:rs];
    
    NSMutableArray *array = [NSMutableArray array];
    NSString *key = nil;
    while ([rs next]) {
        
        Class clazz = NSClassFromString(tableName);
        NSObject *obj = [[clazz alloc] init];
        
        if (obj == nil) {
            break;
        }
        
        for (int i=0; i<columnArray.count; i++) {
            
            key = columnArray[i];
            NSString *value = [rs stringForColumn:key];
            
            SEL selector = NSSelectorFromString(key);
            if ([obj respondsToSelector:selector]) {
                [obj setValue:value forKey:key];
            }
        }
        [array addObject:obj];
    }
    
    if (array && array.count) {
        return array;
    }
    return nil;
}

/*
 * 查找指定数据
 * tableName: 对应 Model 类名
 * key: 关键字，表示查找所有数据
 */
- (NSArray *)queryObjDbByClassName:(NSString *)tableName key:(NSString *)keyword {
    
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where name like '%%%@%%' ",tableName,keyword];
    
    FMResultSet *rs = [_db executeQuery:sql];
    
    NSArray *columnArray = [self fMSetColumnArray:rs];
    
    NSMutableArray *array = [NSMutableArray array];
    NSString *key = nil;
    while ([rs next]) {
        
        Class clazz = NSClassFromString(tableName);
        NSObject *obj = [[clazz alloc] init];
        
        if (obj == nil) {
            break;
        }
        
        for (int i=0; i<columnArray.count; i++) {
            
            key = columnArray[i];
            NSString *value = [rs stringForColumn:key];
            
            SEL selector = NSSelectorFromString(key);
            if ([obj respondsToSelector:selector]) {
                [obj setValue:value forKey:key];
            }
        }
        [array addObject:obj];
    }
    
    if (array && array.count) {
        return array;
    }
    return nil;
}

/*
 * 查找指定数据
 * tableName: 对应 Model 类名
 * _id: 关键字，表示查找所有数据
 */
- (NSArray *)queryObjDbByClassName:(NSString *)tableName _id:(NSString *)_id {
    
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where special_id = %@",tableName,_id];
    
    FMResultSet *rs = [_db executeQuery:sql];
    
    NSArray *columnArray = [self fMSetColumnArray:rs];
    
    NSMutableArray *array = [NSMutableArray array];
    NSString *key = nil;
    while ([rs next]) {
        
        Class clazz = NSClassFromString(tableName);
        NSObject *obj = [[clazz alloc] init];
        
        if (obj == nil) {
            break;
        }
        
        for (int i=0; i<columnArray.count; i++) {
            
            key = columnArray[i];
            NSString *value = [rs stringForColumn:key];
            
            SEL selector = NSSelectorFromString(key);
            if ([obj respondsToSelector:selector]) {
                [obj setValue:value forKey:key];
            }
        }
        [array addObject:obj];
    }
    
    if (array && array.count) {
        return array;
    }
    return nil;
}

/**
 * 删除所有数据
 * tableName: 对应 Model 类名
 */
- (BOOL)deleteAllDataByClassName:(NSString *)tableName {
    NSString *sql = [NSString stringWithFormat:@"DROP TABLE %@",tableName];
    BOOL rs = [_db executeUpdate:sql];
    
    return rs;
}

- (void)closeDb {
    [_db close];
    [_dbQueue close];
    _db = nil;
    _dbQueue = nil;
}


@end
