//
//  BaseVC.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseVC : UIViewController

/* 是否隐藏导航条 */
@property (nonatomic, assign) BOOL isHideNav;

/* 导航左边标题 */
@property (nonatomic, strong) NSString *leftTitle;
/* 导航右边标题 */
@property (nonatomic, strong) NSString *rightTitle;

/* 导航左边图标 */
@property (nonatomic, strong) UIImage *leftImage;

/* 导航右边图标 */
@property (nonatomic, strong) UIImage *rightImage;

/* 左边导航按钮事件(如果存在) */
- (void)goBack;
/* 右边导航按钮事件(如果存在) */
- (void)goNext;

#pragma mark - SVProgressHUD
/**
 *  显示加载HUD
 *  默认值为"正在加载"
 */
- (void)showLoadingHUD;
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

@end
