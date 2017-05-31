//
//  NSArray+Swizzling.m
//  Template
//
//  Created by yuwenhua on 2016/10/24.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "NSArray+Swizzling.h"

#import <objc/runtime.h>

@implementation NSArray (Swizzling)

+ (void)load {
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(swizzling_objectAtIndex:));
    method_exchangeImplementations(fromMethod, toMethod);
}

- (id)swizzling_objectAtIndex:(NSUInteger)index {
    
    if (self.count-1 < index) {
        // 数据越界，异常处理
        @try {
            return [self swizzling_objectAtIndex:index];
        } @catch (NSException *exception) {
            // 打印崩溃信息
            NSLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            NSLog(@"%@", [exception callStackSymbols]);
            return nil;
        } @finally {
            
        }
    }
    else {
        return [self swizzling_objectAtIndex:index];
    }
}

@end
