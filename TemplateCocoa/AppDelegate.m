//
//  AppDelegate.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "AppDelegate.h"

#import "UncaughtExceptionHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    // 1. 异常处理
    InstallUncaughtExceptionHandler();
    
    // 2. 测试异常
    if (NO) {
        
        NSArray *arr = @[@"One"];
        NSString *string = arr[1];
        NSLog(@"String = %@",string);
    }
    
    if (NO) {
        
        NSException *exception = [NSException exceptionWithName:@"Test" reason:@"This is a test" userInfo:@{@"name":@"yuwenhua"}];
        
//        @throw exception;
        
        @try {
            // 可能抛出的异常代码
            int b = 0;
            switch (b) {
                case 0:
                {
                    @throw exception;
                }
                    break;
                    
                default:
                    break;
            }
        } @catch (NSException *exception) {
            // 异常处理的代码
            NSLog(@"Name = %@",exception.name);
            NSLog(@"Reason = %@",exception.reason);
            NSLog(@"b==0 Exception!");
        } @finally {
            // 不论是否有异常总会被执行的代码，通常用于clean
            NSLog(@"Finally");
        }
    }
    
    
    self.tabbarVC = [[DSTabbarVC alloc] init];
    
    self.window.rootViewController = self.tabbarVC;
    
    [[UINavigationBar appearance] setBarTintColor:Color_Nav];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
