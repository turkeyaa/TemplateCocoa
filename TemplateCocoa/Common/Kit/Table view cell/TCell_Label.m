//
//  BSTCellLabel.m
//  HealthCloud
//
//  Created by yuwenhua on 2017/10/31.
//  Copyright © 2017年 www.bsoft.com. All rights reserved.
//

#import "TCell_Label.h"

@interface TCell_Label ()

@property (nonatomic, strong) UILabel *cTitleLabel;
@property (nonatomic, strong) UILabel *cValueLabel;

@end

@implementation TCell_Label

+ (CGFloat)classCellHeight {
    return 50.0;
}

- (void)setupSubViews {
    [super setupSubViews];
    
    [self addSubview:self.cTitleLabel];
    [self addSubview:self.cValueLabel];
    
    [self setupLayout];
}

- (UILabel *)cTitleLabel {
    if (!_cTitleLabel) {
        _cTitleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentLeft;
            label.font = FONT(15);
            label.textColor = RGB(33, 33, 33);
            label;
        });
    }
    return _cTitleLabel;
}
- (UILabel *)cValueLabel {
    if (!_cValueLabel) {
        _cValueLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = FONT(16);
            label.textColor = RGB(33, 33, 33);
            label;
        });
    }
    return _cValueLabel;
}

- (void)setupLayout {
    [_cTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50);
        make.top.offset(10);
        make.bottom.offset(-10);
        make.width.offset(50);
    }];
    [_cValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(80);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _cTitleLabel.text = title;
}
- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _cTitleLabel.textColor = titleColor;
}
- (void)setValue:(NSString *)value {
    _value = value;
    _cValueLabel.text = value;
}
- (void)setValueColor:(UIColor *)valueColor {
    _valueColor = valueColor;
    _cValueLabel.textColor = valueColor;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
