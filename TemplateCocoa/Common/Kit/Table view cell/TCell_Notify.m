//
//  BSTCellNotify.m
//  HealthCloud
//
//  Created by yuwenhua on 2017/10/31.
//  Copyright © 2017年 www.bsoft.com. All rights reserved.
//

#import "TCell_Notify.h"

@interface TCell_Notify ()

@property (nonatomic, strong) UILabel *cTitleLabel;
@property (nonatomic, strong) UISwitch *cSwitch;

@end

@implementation TCell_Notify

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setupSubViews {
    [super setupSubViews];
    
    [self addSubview:self.cTitleLabel];
    [self addSubview:self.cSwitch];
    
    [self setupLayout];
}

- (UILabel *)cTitleLabel {
    if (!_cTitleLabel) {
        _cTitleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = _title;
            label.font = FONT(16);
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = RGB(33, 33, 33);
            label;
        });
    }
    return _cTitleLabel;
}
- (UISwitch *)cSwitch {
    if (!_cSwitch) {
        _cSwitch = ({
            UISwitch *view = [[UISwitch alloc] init];
            view.on = NO;
            view;
        });
    }
    return _cSwitch;
}

- (void)setupLayout {
    [super setupLayout];
    
    [_cTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(50);
        make.top.offset(10);
        make.bottom.offset(-15);
        make.width.offset(50);
    }];
    [_cSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(50);
        make.height.offset(30);
        make.right.offset(-20);
        make.centerY.mas_equalTo(self.mas_centerY);
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

- (void)setIsNotifyOpened:(BOOL)isNotifyOpened {
    _isNotifyOpened = isNotifyOpened;
    _cSwitch.on = isNotifyOpened;
}

#pragma mark - 绑定事件
- (void)addSwitchTarget:(id)target selector:(SEL)selector {
    [self.cSwitch addTarget:target action:selector forControlEvents:UIControlEventValueChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
