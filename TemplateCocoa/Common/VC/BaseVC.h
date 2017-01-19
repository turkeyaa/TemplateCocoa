//
//  BaseVC.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseVC : UIViewController

@property (nonatomic, assign) BOOL isHideNav;

@property (nonatomic, strong) NSString *leftTitle;
@property (nonatomic, strong) NSString *rightTitle;

@property (nonatomic, strong) UIImage *leftImage;
@property (nonatomic, strong) UIImage *rightImage;

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

- (void)goBack;
- (void)goNext;

@end
