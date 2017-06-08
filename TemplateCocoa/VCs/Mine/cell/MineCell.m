//
//  MineCell.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/7.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MineCell.h"

@interface MineCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;

@end

@implementation MineCell

+ (CGFloat)classCellHeight {
    return 50.0;
}

- (void)setupSubViews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.valueLabel];
    
    [self setupLayout];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = RGB(66, 66, 66);
            label.font = FONT(15);
            label;
        });
    }
    return _titleLabel;
}
- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = RGB(99, 99, 99);
            label.font = FONT(15);
            label;
        });
    }
    return _valueLabel;
}

- (void)setupLayout {
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.left.offset(20);
        make.right.offset(-100);
    }];
    [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
        make.right.offset(-10);
        make.width.offset(80);
    }];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}
- (void)setValue:(NSString *)value {
    _value = value;
    _valueLabel.text = value;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
