//
//  BSTitleIndexView.h
//  HealthCloud
//
//  Created by yuwenhua on 2017/10/31.
//  Copyright © 2017年 www.bsoft.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSTitleIndexView : UIView


/**
 初始化方法,自定义标题索引：仿新闻app,支持标题自适应长度

 @param frame 尺寸
 @param titles 标题数组
 @param titleColor 默认字体颜色
 @param selectTitleColor 选中字体颜色
 @return 视图对象
 */
- (id)initWithFrame:(CGRect)frame
             titles:(NSArray< NSString *> *)titles
         titleColor:(UIColor *)titleColor
   selectTitleColor:(UIColor *)selectTitleColor;

/** 当前索引 */
@property (nonatomic, assign) NSInteger currentIndex;

/** 标题下方是否添加下划线 */
@property (nonatomic, assign) BOOL isShowTitleLine;
@property (nonatomic, strong) UIColor *titleLineColor;

/** 回调 */
@property (nonatomic, copy) BlockItem clickItemBlock;

@end
