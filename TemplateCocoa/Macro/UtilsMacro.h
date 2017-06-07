//
//  UtilsMacro.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h


#define SharedApp ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#define kHarpyCurrentVersion      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define UTF8(string) [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

#define RNLogBug NSLog

#define RNAssert(condition, desc, ...)              \
if (!condition) {                               \
RNLogBug((desc), ## __VA_ARGS__);               \
NSAssert((condition),(desc), ## __VA_ARGS__);   \
}

// block self
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;


// 图片拉伸
#define IM_STRETCH_IMAGE(image, edgeInsets) ([image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch])


#endif /* UtilsMacro_h */
