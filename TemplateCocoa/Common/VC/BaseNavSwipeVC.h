//
//  BaseNavSwipeVC.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/10/21.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BaseVC.h"

/** 导航栏上添加多视图控制器切换视图，只支持2~3个视图控制器切换(需要更多使用BaseSwipeVC类)
 * 需要继承 BaseNavSwipeVC 基类，不可直接使用
 */
@interface BaseNavSwipeVC : BaseVC

/** 当前索引 */
@property (nonatomic, assign, readonly) NSInteger currentIndex;

/** 更新索引，默认从0开始,否则调用该方法 */
- (void)updateFirstIndex:(NSInteger)index;

/** 由子类提供 */
- (NSArray *)swipeViewControllers;
- (NSArray *)swipeViewTitles;


@end
