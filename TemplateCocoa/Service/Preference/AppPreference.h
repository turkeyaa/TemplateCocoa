//
//  AppPreference.h
//  Refrence
//
//  Created by turkeyaa on 15/8/2.
//  Copyright (c) 2015年 turkeyaa. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * App 信息 （缓存到文件中）
 */

@interface AppPreference : NSObject

#pragma mark - 账户
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *password;

#pragma mark - 配置
@property (nonatomic, assign) BOOL isFirstOpen;
@property (nonatomic, assign) BOOL isLoginSuccess;
@property (nonatomic, assign) BOOL isFirstEnterExam;

@property (nonatomic, assign) BOOL isQuickRegister;   // 是否是快速注册

#pragma mark - DeviceToken
@property (nonatomic, copy) NSString *deviceToken;


@end
