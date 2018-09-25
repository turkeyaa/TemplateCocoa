//
//  UIHelper.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/8.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "UIHelper.h"

@implementation UIHelper

+ (instancetype)getInstance {
    
    static UIHelper *_instance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[UIHelper alloc] init];
    });
    
    return _instance;
}

- (void)showLoading:(NSString*)message {}

- (void)showLoading {}

- (void)hideLoading {}

@end
