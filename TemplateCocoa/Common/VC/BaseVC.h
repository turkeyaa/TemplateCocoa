//
//  BaseVC.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseNavView.h"

@interface BaseVC : UIViewController

/* 是否隐藏系统导航条 */
@property (nonatomic, assign) BOOL isHideNav;

/* 自定义导航栏 */
@property (nonatomic, strong) BaseNavView *baseNavView;   // 可以为空，系统会添加默认导航栏。
@property (nonatomic, assign) BOOL isSetCustomNav;

/* 导航左边标题 */
@property (nonatomic, strong) NSString *leftTitle;
/* 导航右边标题 */
@property (nonatomic, strong) NSString *rightTitle;

/* 导航左边图标 */
@property (nonatomic, strong) UIImage *leftImage;

/** 导航右边图标 */
@property (nonatomic, strong) UIImage *rightImage;

/* 左边导航按钮事件(如果存在) */
- (void)goBack;
/* 右边导航按钮事件(如果存在) */
- (void)goNext;


/* 子类重载该的方法 */
- (void)setupUI;
- (void)setupLayout;


#pragma mark - SVProgressHUD
/**
 *  显示加载HUD
 *  默认值为"正在加载"
 */
- (void)showLoadingHUD;
- (void)showGifLoadingHUD;
/**
 *  显示加载HUD
 *
 *  @param status 自定义提示语
 */
- (void)showLoadingHUD:(NSString *)status;
/**
 *  隐藏加载HUD
 */
- (void)hideLoadingHUD;


- (void)showInfoMessage:(NSString *)msg;
- (void)showSuccessMessage:(NSString *)msg;
- (void)showErrorMessage:(NSString *)msg;


#pragma mark - 空页面
/** 空页面提示:子类重载的方法,只有 isShowEmptyView=YES 时生效 */
@property (nonatomic, assign) BOOL isShowEmptyView;
- (UIImage *)baseEmptyImage;        // 可选
- (NSString *)baseEmptyTitle;       // 可选
- (NSString *)baseEmptySecondTitle; // 可选
- (CGRect)baseEmptyViewFrame;       // 可选
- (void)baseEmptyRefresh;       // 点击刷新事件,由子类实现逻辑


@end
