//
//  LogOutView.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/7.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "LogOutView.h"

@interface LogOutView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LogOutView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = Color_Nav;
    
    [self addSubview:self.titleLabel];
    [self setupLayout];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
//            label.textColor = RGB(99, 99, 99);
            label.textColor = [UIColor whiteColor];
            label.font = FONT(20);
            label.text = @"暂未登录";
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
    }
    return _titleLabel;
}

- (void)setupLayout {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(20);
        make.top.offset(50);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
