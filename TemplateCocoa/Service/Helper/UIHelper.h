//
//  UIHelper.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/8.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^Action)();

@interface UIHelper : NSObject

+ (instancetype)getInstance;

- (void)showLoading:(NSString*)message;

- (void)showLoading;

- (void)hideLoading;



@end
