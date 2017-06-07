//
//  PredicateHelper.h
//  new_supply
//
//  Created by turkeyaa on 15/8/14.
//  Copyright (c) 2015年 turkeyaa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PredicateHelper : NSObject

+ (instancetype)shareInstance;

/*
 * 查询某一个对象
 * objs: 查询的对象数组
 * key: 对象属性
 * value: 要查找的值
 */
- (id)predicateObjs:(NSArray *)objs key:(NSString *)key value:(NSString *)value;
/*
 * 查询多个数据，一般是模糊查询
 * key: 对象属性
 * value: 要查找的值
 * flag: 是否精确查找
 */
- (NSArray *)predicateObjs:(NSArray *)objs key:(NSString *)key value:(NSString *)value flag:(BOOL)flag;

@end
