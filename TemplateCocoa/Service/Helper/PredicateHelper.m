//
//  PredicateHelper.m
//  new_supply
//
//  Created by turkeyaa on 15/8/14.
//  Copyright (c) 2015年 turkeyaa. All rights reserved.
//

#import "PredicateHelper.h"

@implementation PredicateHelper


+ (instancetype)shareInstance {
    static PredicateHelper *_instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[PredicateHelper alloc] init];
    });
    return _instance;
}

/*
 * 查询某一个对象
 * objs: 查询的对象数组
 * key: 对象属性
 * value: 要查找的值
 */
- (id)predicateObjs:(NSArray *)objs key:(NSString *)key value:(NSString *)value {
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"%K == %@", key, value];
    NSArray *result = [objs filteredArrayUsingPredicate:predicate];
    if (result && result.count) {
        return [result firstObject];
    }
    return nil;
}
/*
 * 查询多个数据，一般是模糊查询
 * key: 对象属性
 * value: 要查找的值
 * flag: 是否精确查找
 */
- (NSArray *)predicateObjs:(NSArray *)objs key:(NSString *)key value:(NSString *)value flag:(BOOL)flag {

    NSPredicate *predicate = nil;
    if (flag) {
//        predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS[cd] '%@'",key,value];
        predicate = [NSPredicate predicateWithFormat:@"%K CONTAINS[cd] %@",key,value];

    }
    else {
        predicate = [NSPredicate predicateWithFormat: @"%K == %@", key, value];
    }
    
    NSArray *result = [objs filteredArrayUsingPredicate:predicate];
    return result;
}
@end
