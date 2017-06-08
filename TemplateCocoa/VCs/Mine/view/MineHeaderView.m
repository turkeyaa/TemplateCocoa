//
//  MineHeaderView.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/7.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MineHeaderView.h"

@interface MineHeaderView ()

@property (nonatomic, strong) UIView *bgView;

@end

@implementation MineHeaderView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self p_setupUI];
    }
    return self;
}

- (void)p_setupUI {
    [self addSubview:self.bgView];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = ({
            UIView *view = [[UIView alloc] initWithFrame:self.bounds];
            view.backgroundColor = [UIColor blueColor];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
            [view addGestureRecognizer:tap];
            
            view;
        });
    }
    return _bgView;
}

- (void)tapEvent:(UIGestureRecognizer *)gesture {
    if (_clickItemBlock) {
        _clickItemBlock(1);
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
