//
//  TLQRootNavView.m
//  Template
//
//  Created by yuwenhua on 16/9/21.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "RootNavView.h"

@interface RootNavView ()


@end

@implementation RootNavView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)p_customUI {
    
}

- (void)setTitlesArray:(NSArray *)titlesArray {
    _titlesArray = titlesArray;
    
    [self p_updateUI];
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    
    UIButton *btn = [self viewWithTag:currentIndex+100];
    [self updateBtnSelect:btn];
    
    _currentIndex = currentIndex;
}

- (void)p_updateUI {
    
    CGFloat aWidth = self.frame.size.width/_titlesArray.count;
    CGFloat aHeight = self.frame.size.height;
    for (NSInteger nn=0; nn<_titlesArray.count; nn++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn setFrame:CGRectMake(aWidth*nn, 0, aWidth, aHeight)];
        [btn setTitle:_titlesArray[nn] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTag:100+nn];
        
        if (nn == 0) {
            [btn.titleLabel setFont:FONT_H_B(18)];
            btn.selected = YES;
        }
        else {
            [btn.titleLabel setFont:FONT(16)];
        }
        
        [self addSubview:btn];
    }
}

- (void)clickEvent:(UIButton *)sender {
    
    if (sender.selected) {
        return;
    }
    
    [self updateBtnSelect:sender];
    
    NSInteger index = sender.tag-100;
    if (_clickItemBlock) {
        _clickItemBlock(index);
    }
    
    _currentIndex = index;
}

- (void)updateBtnSelect:(UIButton *)sender {
    UIButton *btn = [self viewWithTag:_currentIndex+100];
    btn.selected = NO;
    [btn.titleLabel setFont:FONT(16)];
    
    [sender.titleLabel setFont:FONT_H_B(18)];
    sender.selected = YES;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
