//
//  BSTCellNotify.h
//  HealthCloud
//
//  Created by yuwenhua on 2017/10/31.
//  Copyright © 2017年 www.bsoft.com. All rights reserved.
//

#import "BaseTCell.h"


@interface TCell_Notify : BaseTCell

/** 标题 */
@property (nonatomic, strong) NSString *title;
/** 标题颜色 */
@property (nonatomic, strong) UIColor *titleColor;
/** 是否开启，类似于飞行模式，开启or关闭 */
@property (nonatomic, assign) BOOL isNotifyOpened;

/** 绑定事件 */
- (void)addSwitchTarget:(id)target selector:(SEL)selector;

@end
