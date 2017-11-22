//
//  TabSwitchScroll.h
//  new_supply
//
//  Created by wfpb on 15/5/9.
//  Copyright (c) 2015年 bysunnet. All rights reserved.
//

#import "TabSwitchView.h"

@interface TabSwitchScroll : TabSwitchView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles;

@property (nonatomic, strong) UIColor* scrollLineColor;

- (void)setIndex:(NSInteger)index Animated:(BOOL)animated;

@end
