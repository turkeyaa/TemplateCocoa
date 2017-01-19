//
//  URLHelper.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/1/19.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "URLHelper.h"

#define AppStatus_Product 1     // 正式环境
#define AppStatus_Develop 2     // 开发环境
#define AppStatus_Test    3     // 测试环境

// 设置发布版本
#define APP_STATUS        2


@implementation URLHelper

- (NSString *)baseURL {
    
#if APP_STATUS == AppStatus_Product
    return @"http://www.curefun.com";       // 线上环境
    
#elif APP_STATUS == AppStatus_Develop
    return @"http://192.168.0.122";     // 开发环境
    
#else
    return @"http://192.168.0.112";     // 测试环境
    
#endif
}

#pragma mark - 图片路径
- (NSString *)imageURl {
    return [NSString stringWithFormat:@"%@/resource/",[self baseURL]];
}

+ (instancetype)getInstance {
    static URLHelper *_instance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[URLHelper alloc] init];
    });
    return _instance;
}

- (NSString *)restApiURL:(NSString *)relativeURL {
    return [NSString stringWithFormat:@"%@/%@",[self baseURL],relativeURL];
}

@end
