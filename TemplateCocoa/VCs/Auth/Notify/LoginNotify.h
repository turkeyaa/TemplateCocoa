//
//  LoginNotify.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/7.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginNotify : NSObject

+ (instancetype)sharedInstance;

#pragma mark - login
- (void)addLoginObserver:(id)target selector:(SEL)selector;
- (void)removeLoginObserver:(id)target;
- (void)postLoginNotify;

#pragma mark - louout
- (void)addLogoutObserver:(id)target selector:(SEL)selector;
- (void)removeLogoutObserver:(id)target;
- (void)postLogoutNotify;

@end
