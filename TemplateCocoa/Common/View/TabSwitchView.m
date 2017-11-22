//
//  TabSwitchView.m
//  new_supply
//
//  Created by wfpb on 15/5/9.
//  Copyright (c) 2015年 bysunnet. All rights reserved.
//

#import "TabSwitchView.h"

@implementation TabSwitchView

- (void)setIndex:(NSInteger)index {
    _index = index;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabSwitchView:indexChanged:)]) {
        [self.delegate tabSwitchView:self indexChanged:index];
    }
}

@end
