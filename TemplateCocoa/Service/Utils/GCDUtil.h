//
//  GCDUtil.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/1/19.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDUtil : NSObject

// 并发队列
+ (void)runInGlobalQueue:(void (^)())queue;

// 主队列
+ (void)runInMainQueue:(void (^)())queue;

// 延迟调用
+ (void)runAfterSecs:(float)secs block:(void (^)())queue;

// 自定义串行队列
+(void)runSerialQueueParallel:(void (^)())queue charIden:(const char *)identifier;

@end
