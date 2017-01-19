//
//  DSTabbarView.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/1/17.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSTabbarView.h"

@interface DSTabbarView ()

{
    NSUInteger _lastIndex;
}

@end

@implementation DSTabbarView


- (void)setupViews {
    
    self.backgroundColor = [UIColor whiteColor];
    
    if (_items) {
        for (DSTabItemView *itemView in _items) {
            [itemView removeFromSuperview];
        }
    }
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSUInteger num = [self.dataSource numberOfItemsInTabbar:self];
    
    CGFloat item_width = ceil(num > 5 ? self.frame.size.width / 5: self.frame.size.width / num);
    CGFloat item_height = self.frame.size.height;
    
    for (NSUInteger nn=0; nn<num; nn++) {
        DSTabItemModel *itemModel = [self.dataSource tabbar:self itemModelAtIndex:nn];
        
        DSTabItemView *itemView = [[DSTabItemView alloc] initWithModel:itemModel];
        itemView.frame = CGRectMake(item_width * nn, 0, item_width, item_height);
        itemView.tag = 100+nn;
        if (nn==0) {
            itemView.selected = YES;
        }
        [self addSubview:itemView];
        
        [array addObject:itemView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
        [itemView addGestureRecognizer:tap];
    }
    
    _lastIndex = 0;
    
    _items = array;
}

- (void)tapEvent:(UITapGestureRecognizer *)gesture {
    NSInteger index = gesture.view.tag-100;
    if (self.delegate && [self.delegate respondsToSelector:@selector(tabbar:clickAtIndex:)]) {
        [self.delegate tabbar:self clickAtIndex:index];
        
        DSTabItemView *itemView = _items[_lastIndex];
        itemView.selected = NO;
        
        itemView = _items[index];
        itemView.selected = YES;
        
        _lastIndex = index;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
