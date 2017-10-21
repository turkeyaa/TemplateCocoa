//
//  TCell_Image.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/10/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "TCell_Image.h"

static CGFloat kMsgViewHeight = 8.0;

@interface TCell_Image ()

@property (nonatomic, strong) UIImageView *cIconView;
@property (nonatomic, strong) UILabel *cTitleLabel;
@property (nonatomic, strong) UILabel *cValueLabel;
@property (nonatomic, strong) UIView *cMsgView;

@end

@implementation TCell_Image

+ (CGFloat)classCellHeight {
    return 50.0;
}

- (void)setupSubViews {
    [super setupSubViews];
    
    [self addSubview:self.cIconView];
    [self addSubview:self.cTitleLabel];
    [self addSubview:self.cValueLabel];
    [self addSubview:self.cMsgView];
    
    [self setupLayout];
}

- (UIImageView *)cIconView {
    if (!_cIconView) {
        _cIconView = ({
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            imgView;
        });
    }
    return _cIconView;
}
- (UILabel *)cTitleLabel {
    if (!_cTitleLabel) {
        _cTitleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = [UIColor whiteColor];
            label.font = FONT(15);
            label.textAlignment = NSTextAlignmentCenter;
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
            label.font = FONT(15);
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = RGB(66, 66, 66);
            label;
        });
    }
    return _cValueLabel;
}

- (UIView *)cMsgView {
    if (!_cMsgView) {
        _cMsgView = ({
            UIView *view = [[UIView alloc] init];
            view.hidden = YES;
            view.layer.cornerRadius = kMsgViewHeight/2;
            view.clipsToBounds = YES;
            view.backgroundColor = [UIColor redColor];
            view;
        });
    }
    return _cMsgView;
}

- (void)setupLayout {
    [_cIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.offset(10);
        make.bottom.offset(-10);
        make.width.equalTo(_cIconView.mas_height);
    }];
    [_cTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_cIconView.mas_right).offset(10);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
    [_cMsgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_cTitleLabel.mas_right).offset(5);
        make.top.mas_equalTo(_cTitleLabel.mas_top).offset(5);
        make.width.height.offset(kMsgViewHeight);
    }];
    [_cValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-30);
        make.top.offset(10);
        make.bottom.offset(-10);
    }];
}

#pragma mark - update
- (void)setIcon:(UIImage *)icon {
    _icon = icon;
    _cIconView.image = icon;
}
- (void)setTitle:(NSString *)title {
    _title = title;
    _cTitleLabel.text = title;
}
- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _cTitleLabel.textColor = titleColor;
}
- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    self.contentView.backgroundColor = bgColor;
}
- (void)setValue:(NSString *)value {
    _value = value;
    _cValueLabel.text = value;
}
- (void)setValueColor:(UIColor *)valueColor {
    _valueColor = valueColor;
    _cValueLabel.textColor = valueColor;
}

- (void)setHasMsg:(BOOL)hasMsg {
    _hasMsg = hasMsg;
    _cMsgView.hidden = !hasMsg;
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
