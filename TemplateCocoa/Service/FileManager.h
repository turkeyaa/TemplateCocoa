//
//  FileManager.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/7.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

#pragma mark - 程序文件存储目录
///<>/Documents/
///<>/Library/Preferences/
///<>/Library/Caches/
///<>/tmp/


#pragma mark - 程序文件
//数据库文件：列表数据缓存（订单列表、商品列表）－暂未使用
//商品图片缓存（sdwebimage）
//商品语音
//头像缓存缓存（sdwebimage）
//程序信息：是否登录过、是否自动登录、自动登录用户名、自动登录密码


///<>/Documents/config.plist
//程序设置信息
+ (NSString*)remotePreferenceFile;

///<>/Documents/Crash/crashLog.txt
// 错误日志
+ (NSString *)crashFile;

///<>/Library/Caches/mobile.sqlite
// 用户数据库文件
+ (NSString *)fmdbFileWithMobile:(NSString *)mobile;

///<><Application_Home>/Documents/app.sqlite
// App数据库文件
+ (NSString *)fmdbFile;

///<>/Library/Preferences/Icons
// 用户头像信息（自己头像，朋友头像）
+ (NSString *)userImageFileWithMobile:(NSString *)mobile;

///<>/Library/Preferences/<Phonenumber>/user.plist
//程序设置信息
+ (NSString*)userPreferenceFile:(NSString*)phoneNumber;


@end
