//
//  LoginNotify.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/7.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "LoginNotify.h"

static  NSString * kNotifyLogout           = @"kNotifyLogout";
static  NSString * kNotifyLogin            = @"kNotifyLogin";

@interface LoginNotify ()

@property NSNotificationCenter* center;

@end

@implementation LoginNotify


+ (instancetype)sharedInstance {
    static LoginNotify *_instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[LoginNotify alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _center = [NSNotificationCenter defaultCenter];
    }
    return self;
}

#pragma mark - login
- (void)addLoginObserver:(id)target selector:(SEL)selector {
    [_center addObserver:target selector:selector name:kNotifyLogin object:nil];
}
- (void)removeLoginObserver:(id)target {
    [_center removeObserver:target name:kNotifyLogin object:nil];
}
- (void)postLoginNotify {
    [_center postNotificationName:kNotifyLogin object:nil];
}

#pragma mark - louout
- (void)addLogoutObserver:(id)target selector:(SEL)selector {
    [_center addObserver:target selector:selector name:kNotifyLogout object:nil];
}
- (void)removeLogoutObserver:(id)target {
    [_center removeObserver:target name:kNotifyLogout object:nil];
}
- (void)postLogoutNotify {
    [_center postNotificationName:kNotifyLogout object:nil];
}



@end
