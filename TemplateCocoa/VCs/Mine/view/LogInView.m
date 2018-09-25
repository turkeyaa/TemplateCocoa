//
//  LogInView.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/7.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "LogInView.h"

@interface LogInView ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation LogInView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = Color_Nav;
    [self addSubview:self.iconView];
    [self addSubview:self.nameLabel];
    
    [self setupLayout];
}

- (void)setupLayout {
    
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(80);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(20);
        make.top.mas_equalTo(self.iconView.mas_bottom).offset(10);
    }];
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = ({
            UIImageView *view = [[UIImageView alloc] init];
            view.image = [UIImage imageNamed:@"auth"];
            view;
        });
    }
    return _iconView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = ({
            UILabel *label = [[UILabel alloc] init];
//            label.textColor = RGB(99, 99, 99);
            label.textColor = [UIColor whiteColor];
            label.font = FONT(15);
            label.text = @"turkey";
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
    }
    return _nameLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
