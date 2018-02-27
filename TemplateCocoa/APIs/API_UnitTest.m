//
//  API_UnitTest.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "API_UnitTest.h"

#import "Login_Post.h"
#import "Foods_Get.h"
#import "Activity_Get.h"
#import "Main_Get.h"

@implementation API_UnitTest

+ (void)test {
    /*
    [GCDUtil runInGlobalQueue:^{
        NSLog(@"线程开始:%@",[NSThread currentThread]);
        Foods_Get *foodApi = [[Foods_Get alloc] init];
        [foodApi call];
        NSLog(@"1 -> 数量：%lu",(unsigned long)foodApi.dataSource.count);
        Activity_Get *activityApi = [[Activity_Get alloc] init];
        [activityApi call];
        NSLog(@"2 -> 数量：%lu",(unsigned long)activityApi.dataSource.count);
        Main_Get *mainApi = [[Main_Get alloc] init];
        [mainApi call];
        NSLog(@"3 -> 数量:%lu",(unsigned long)mainApi.dataSource.count);
        
    }];
    
    [GCDUtil runInGlobalQueue:^{
        Foods_Get *foodApi = [[Foods_Get alloc] init];
        [foodApi call];
        NSLog(@"4 -> 数量:%lu -> 线程:%@",(unsigned long)foodApi.dataSource.count,[NSThread currentThread]);
    }];
    [GCDUtil runInGlobalQueue:^{
        Foods_Get *foodApi = [[Foods_Get alloc] init];
        [foodApi call];
        NSLog(@"5 -> 数量:%lu -> 线程:%@",(unsigned long)foodApi.dataSource.count,[NSThread currentThread]);
    }];
    [GCDUtil runInGlobalQueue:^{
        Foods_Get *foodApi = [[Foods_Get alloc] init];
        [foodApi call];
        NSLog(@"6 -> 数量：%lu -> 线程:%@",(unsigned long)foodApi.dataSource.count,[NSThread currentThread]);
    }];
     */
    
    /*
    [GCDUtil runInGlobalQueue:^{
        Foods_Get *foodApi = [[Foods_Get alloc] init];
        [foodApi callWithAsync:^(id data) {
            NSLog(@"7 -> 数量:%lu -> 线程:%@",(unsigned long)foodApi.dataSource.count,[NSThread currentThread]);
        }];
        NSLog(@"8 -> 数量:%lu -> 线程:%@",(unsigned long)foodApi.dataSource.count,[NSThread currentThread]);
        
        Foods_Get *foodApi2 = [[Foods_Get alloc] init];
        [foodApi2 callWithAsync:^(id data) {
            NSLog(@"9 -> 数量:%lu -> 线程:%@",(unsigned long)foodApi2.dataSource.count,[NSThread currentThread]);
        }];
        
    }];
     */
    
//    [GCDUtil runInGlobalQueue:^{
//
//        int(^blockOne)(int count) = ^(int count) {
//            for (int index=0; index<count; index++) {
//                NSLog(@"1----%d",index);
//            }
//            NSLog(@"1=========>%@",[NSThread currentThread]);
//            return 1;
//        };
//        int(^blockTwo)(int count) = ^(int count) {
//            for (int index=0; index<count; index++) {
//                NSLog(@"1++++%d",index);
//            }
//            NSLog(@"2=========>%@",[NSThread currentThread]);
//            return 2;
//        };
//        NSInteger rs1 = blockOne(200);
//        NSInteger rs2 = blockTwo(200);
//    }];
}



+ (void)logFailure:(NSString *)apiName {
    DLog(@"[API Failure] -- %@",apiName);
}

@end
