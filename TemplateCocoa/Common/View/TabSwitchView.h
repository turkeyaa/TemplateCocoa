//
//  TabSwitchView.h
//  new_supply
//
//  Created by wfpb on 15/5/9.
//  Copyright (c) 2015年 bysunnet. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseView.h"

@class TabSwitchView;

@protocol TabSwitchDelegate<NSObject>

- (void)tabSwitchView:(TabSwitchView*)tabSwitchView indexChanged:(NSInteger)index;

@end


@interface TabSwitchView : BaseView

@property (nonatomic, strong) UIFont* font;
@property (nonatomic, strong) UIColor* titleColor;
@property (nonatomic, strong) UIColor* selectedTitleColor;

@property (nonatomic, weak) id <TabSwitchDelegate> delegate;
@property (nonatomic, assign) NSInteger index;

@end
