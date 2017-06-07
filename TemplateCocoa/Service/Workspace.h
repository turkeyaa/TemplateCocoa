//
//  Workspace.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;           // 用户信息
@class AppPreference;       // 缓存信息、配置信息(NSUserDefault方式)
@class NetworkMonitor;      // 网络状态
@class BaseRestApi;         // 接口

/** Workspace 类
 * 设计为单例类，缓存用户信息、配置信息、网络状态，访问更加方便、快捷
 */

@interface Workspace : NSObject

+ (instancetype)getInstance;

// 用户数据
+ (UserModel *)currentUser;
+ (void)setCurrentUser:(UserModel *)userInfo;

// 登录 or 退出
- (void)onLogIn:(BaseRestApi *)api;
- (void)onLogOut;


// app配置
@property (nonatomic, readonly) AppPreference* appPreference;
// 网络监控
@property (nonatomic, readonly) NetworkMonitor *networkMonitor;


@end
