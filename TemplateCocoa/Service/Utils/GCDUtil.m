//
//  GCDUtil.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/1/19.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "GCDUtil.h"

@implementation GCDUtil

// 并发队列
+ (void)runInGlobalQueue:(void (^)())queue {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), queue);
}

// 主队列
+ (void)runInMainQueue:(void (^)())queue {
    dispatch_async(dispatch_get_main_queue(), queue);
}

// 延迟调用
+ (void)runAfterSecs:(float)secs block:(void (^)())queue {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, secs * NSEC_PER_SEC), dispatch_get_main_queue(), queue);
}

// 自定义串行队列
+(void)runSerialQueueParallel:(void (^)())queue charIden:(const char *)identifier {
    dispatch_async(dispatch_queue_create(identifier, DISPATCH_QUEUE_SERIAL), queue);
}

@end
