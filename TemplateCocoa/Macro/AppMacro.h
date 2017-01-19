//
//  AppMacro.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

#define is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define IOS6_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >=6.0?YES:NO)
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0?YES:NO)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0?YES:NO)


#endif /* AppMacro_h */
