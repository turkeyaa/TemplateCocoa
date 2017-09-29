//
//  BaseNavView.h
//  Template
//
//  Created by yuwenhua on 16/6/30.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "BaseView.h"

/*
 * 自定义导航栏视图
 */

@interface BaseNavView : UIView

@property (nonatomic, strong) UIImage *leftIcon;
@property (nonatomic, strong) UIImage *rightIcon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIImage *bgImage;


- (void)addLeftTarget:(id)target selector:(SEL)selector;
- (void)addRightTarget:(id)target selector:(SEL)selector;

@end
