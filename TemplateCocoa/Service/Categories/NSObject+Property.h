//
//  NSObject+Property.h
//   
//
//  Created on 12-12-15.
//
//
#import <objc/runtime.h>
#import <Foundation/Foundation.h>

@interface NSObject (Property)

// 自动化创建 sql 语句
- (NSString *)tableSql:(NSString *)tablename;
- (NSString *)insertSql:(NSString *)tablename;

// 属性列表
- (NSArray *)getPropertyList;

@end
