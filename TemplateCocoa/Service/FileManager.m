//
//  FileManager.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/7.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "FileManager.h"

/*
 // 获取程序Documents目录路径
 NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
 NSString *documentsDirectory = [paths objectAtIndex:0];
 
 // 获取程序app文件所在目录路径
 NSHomeDirectory();
 
 // 获取程序tmp目录路径
 NSTemporaryDirectory();
 
 // 获取程序应用包路径
 [[NSBundle mainBundle] resourcePath];
 或
 [[NSBundle mainBundle] pathForResource: @"info" ofType: @"txt"];
 */

@implementation FileManager

//获取文件路径，创建所在目录
+ (void)createDir:(NSString*)filepath {
    filepath = filepath.stringByDeletingLastPathComponent;
    if (![[NSFileManager defaultManager] fileExistsAtPath:filepath])
        [[NSFileManager defaultManager] createDirectoryAtPath:filepath withIntermediateDirectories:YES attributes:nil error:nil];
}

///<>/Documents/config.plist
//程序设置信息
+ (NSString*)remotePreferenceFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString* filepath = [NSString stringWithFormat:@"%@/config.plist", [paths objectAtIndex:0]];
    
    [self createDir:filepath];
    
    return filepath;
}

///<>/Documents/Crash/crashLog.txt
// 错误日志
+ (NSString *)crashFile {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString* filepath = [NSString stringWithFormat:@"%@/Crash/crashLog.txt", [paths objectAtIndex:0]];
    
    [self createDir:filepath];
    
    return filepath;
}

///<>/Library/Caches/mobile.sqlite
// 程序数据库文件
+ (NSString *)fmdbFileWithMobile:(NSString *)mobile {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    NSString* filepath = [NSString stringWithFormat:@"%@/Caches/%@.sqlite", [paths objectAtIndex:0],mobile];
    
    [FileManager createDir:filepath];
    
    return filepath;
}

///<>/Documents/app.sqlite
// 数据库文件
+ (NSString *)fmdbFile {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* filepath = [NSString stringWithFormat:@"%@/app.sqlite", [paths objectAtIndex:0]];
    [FileManager createDir:filepath];
    return filepath;
}

///<>/Library/Preferences/Icons/phoneNumber.png
// 用户头像信息（自己头像，朋友头像）
+ (NSString *)userImageFileWithMobile:(NSString *)mobile {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *filePath = [NSString stringWithFormat:@"%@/Preferences/Icons/%@.png",paths[0],mobile];
    [FileManager createDir:filePath];
    return filePath;
}

///<>/Library/Preferences/<Phonenumber>/user.plist
// 程序设置信息
+ (NSString*)userPreferenceFile:(NSString*)phoneNumber
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    
    NSString* filepath = [NSString stringWithFormat:@"%@/Preferences/%@/user.plist", [paths objectAtIndex:0], phoneNumber];
    
    [FileManager createDir:filepath];
    
    return filepath;
}



@end
