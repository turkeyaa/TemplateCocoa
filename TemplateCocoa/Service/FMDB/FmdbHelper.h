//
//  FmdbHelper.h
//  ESP
//
//  Created by turkeyaa on 15/11/24.
//  Copyright © 2015年 ds All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * 支持自动化 创建 SQL 语句 (客户端类型全部为NSString)
 */

@interface FmdbHelper : NSObject


+ (FmdbHelper *)shareInstance;

// 打开数据库
- (BOOL)openDB;

/*
 * 插入数据 (如果不存在 该表，会自动创建表)
 * tableName: 对应 Model 类名
 * json: 需要储存到 SQLite 的数据
 */
- (BOOL)insertTableByClassName:(NSString *)tableName json:(id)json;

/*
 * 请求数据, 本地所有数据
 * tableName: 对应 Model 类名
 * 返回数据为字典类型
 */
- (NSArray *)queryDbByClassName:(NSString *)tableName;

/*
 * 请求数据, 本地所有数据 - 推荐方法
 * tableName: 对应 Model 类名
 * sortFlag: 排序, 根据实际字段修改
 * 返回数据为 Model 类型
 */
- (NSArray *)queryObjDbByClassName:(NSString *)tableName;
- (NSArray *)queryObjDbByClassName:(NSString *)tableName sortFlag:(BOOL)flag;

/*
 * 查找指定数据
 * tableName: 对应 Model 类名
 * key: 关键字，表示查找所有数据
 */
- (NSArray *)queryObjDbByClassName:(NSString *)tableName key:(NSString *)keyword;
/*
 * 查找指定数据
 * tableName: 对应 Model 类名
 * _id: 关键字，表示查找所有数据
 */
- (NSArray *)queryObjDbByClassName:(NSString *)tableName _id:(NSString *)_id;

/**
 * 删除所有数据
 * tableName: 对应 Model 类名
 */
- (BOOL)deleteAllDataByClassName:(NSString *)tableName;

// 关闭数据库
- (void)closeDb;

@end
