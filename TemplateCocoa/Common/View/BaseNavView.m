//
//  BaseNavView.m
//  Template
//
//  Created by yuwenhua on 16/6/30.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "BaseNavView.h"

@interface BaseNavView ()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UILabel *titleLabel;


@end

@implementation BaseNavView

- (id)init {
    if (self = [super initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, NAV_HEIGHT+STATUS_HEIGHT)]) {
        
        [self _setupUI];
    }
    return self;
}

- (void)_setupUI {
    [self addSubview:self.bgImageView];
    [self addSubview:self.leftButton];
    [self addSubview:self.rightButton];
    [self addSubview:self.titleLabel];
    
    
    [self _setupLayout];
}

- (void)_setupLayout {
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(30);
        make.left.offset(10);
        make.bottom.offset(-10);
    }];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(30);
        make.right.offset(-10);
        make.bottom.offset(-10);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(200);
        make.height.offset(24);
        make.bottom.offset(-10);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
}


- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = ({
            UIImageView *view = [[UIImageView alloc] init];
            view;
        });
    }
    return _bgImageView;
}
- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn;
        });
    }
    return _leftButton;
}
- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn;
        });
    }
    return _rightButton;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = FONT_BOLD(17);
            label;
        });
    }
    return _titleLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = CGRectMake(0, 0, DEVICE_WIDTH, 64);
}

#pragma mark -
#pragma mark - 赋值
- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}
- (void)setLeftIcon:(UIImage *)leftIcon {
    _leftIcon = leftIcon;
//    [_leftButton setBackgroundImage:leftIcon forState:UIControlStateNormal];
    [_leftButton setImage:leftIcon forState:UIControlStateNormal];
    [_leftButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
}
- (void)setRightIcon:(UIImage *)rightIcon {
    _rightIcon = rightIcon;
    [_rightButton setBackgroundImage:rightIcon forState:UIControlStateNormal];
}
- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}
- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
}
- (void)setBgImage:(UIImage *)bgImage {
    _bgImage = bgImage;
    _bgImageView.image = bgImage;
}

#pragma mark - 事件
- (void)addLeftTarget:(id)target selector:(SEL)selector {
    [_leftButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}

- (void)addRightTarget:(id)target selector:(SEL)selector {
    [_rightButton addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
