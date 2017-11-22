//
//  BaseSwipeVC.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/10/21.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BaseVC.h"
/** 仿新闻类app，多视图控制器切换，
 * 需要继承BaseSwipeVC 基类，不可直接使用
 */
@interface BaseSwipeVC : BaseVC

/** 当前索引 */
@property (nonatomic, assign, readonly) NSInteger currentIndex;

/** 更新索引，默认从0开始,否则调用该方法 */
- (void)updateFirstIndex:(NSInteger)index;

/** 是否显示标题下划线 */
@property (nonatomic, assign) BOOL isShowTitleLine;
/** 下划线颜色 */
@property (nonatomic, strong) UIColor *titleLineColor;

/** 默认字体颜色 */
@property (nonatomic, strong) UIColor *normalTitleColor;
/** 选中字体颜色 */
@property (nonatomic, strong) UIColor *selectTitleColor;

/** 由子类提供 */
- (NSArray *)swipeViewControllers;
- (NSArray *)swipeViewTitles;

/** 自定义SwipeView高度，宽度为视图宽度不能修改 */
- (CGFloat)swipeViewHeight;

@end
