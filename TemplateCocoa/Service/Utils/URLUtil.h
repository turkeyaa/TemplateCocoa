//
//  URLUtil.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/1/19.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLUtil : NSObject


// base64 编码
+ (NSString *)base64Encode:(NSString *)string;
+ (NSString *)base64Decode:(NSString *)string;

// 中文编码
+ (NSString *)base64ChineseEncode:(NSString *)string;

@end
