//
//  Workspace.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "Workspace.h"

#import "UserModel.h"
#import "BaseRestApi.h"
#import "AppPreference.h"
#import "NetworkMonitor.h"

#import "Login_Post.h"

@interface Workspace ()

@property (nonatomic, strong) UserModel *userInfo;

@end

@implementation Workspace

+ (instancetype)getInstance {
    
    static Workspace *_instance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[Workspace alloc] init];
    });
    
    return _instance;
}

- (id)init {
    if (self = [super init]) {
        _appPreference = [[AppPreference alloc] init];
        _networkMonitor = [[NetworkMonitor alloc] init];
    }
    return self;
}

#pragma mark -
#pragma mark - UserModel
+ (UserModel *)currentUser {
    if ([Workspace getInstance].userInfo) {
        return [Workspace getInstance].userInfo;
    }
    return nil;
}
+ (void)setCurrentUser:(UserModel *)userInfo {
    [Workspace getInstance].userInfo = userInfo;
}


#pragma mark - 
#pragma mark - 登录 or 退出
- (void)onLogIn:(BaseRestApi *)api {
    // 1. 登录成功
    _appPreference.isLoginSuccess = YES;
    
    if ([api isKindOfClass:[Login_Post class]]) {
        
        // 2. 赋值
        Login_Post *loginApi = (Login_Post *)api;
        _userInfo = loginApi.userInfo;
        
        // 3. 更新配置(账号和密码)
        _appPreference.phone = _userInfo.phone;
        _appPreference.password = _userInfo.password;
        
        // TODO: 是否需要再次赋值？ 待验证
        // 4. 更新用户信息
//        [Workspace setCurrentUser:_userInfo];
    }
}
- (void)onLogOut {
    
    // 清空配置和缓存
    _appPreference.isQuickRegister = NO;
    _appPreference.isLoginSuccess = NO;
    
    _appPreference.phone = @"";
    _appPreference.password = @"";
    
    _userInfo = nil;
}


@end
