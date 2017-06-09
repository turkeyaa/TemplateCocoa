//
//  DSTabbarVC.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DSTabbarView.h"

@interface DSTabbarVC : UITabBarController

@property (nonatomic, strong) DSTabbarView *dsTabbar;

/** 更新消息个数
 * tabIndex: 标签栏索引
 * badge: 当前的消息个数
 */
- (void)updateBadge:(NSInteger)tabIndex badge:(NSInteger)badge;

@end
