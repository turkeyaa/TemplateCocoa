//
//  CollectionCell.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/8.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CollectionCell.h"

@interface CollectionCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *specificsLabel;

@end

@implementation CollectionCell

+ (CGFloat)classCellHeight {
    return 100.0;
}

- (void)setupSubViews {
    [self addSubview:self.iconView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.specificsLabel];
    
    [self setupLayout];
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = ({
            UIImageView *view = [[UIImageView alloc] init];
            view;
        });
    }
    return _iconView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = FONT_H_B(15);
            label.textColor = RGB(33, 33, 33);
            label.numberOfLines = 2;
            label;
        });
    }
    return _nameLabel;
}
- (UILabel *)specificsLabel {
    if (!_specificsLabel) {
        _specificsLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = FONT_H_B(15);
            label.textColor = RGB(66, 66, 66);
            label;
        });
    }
    return _specificsLabel;
}

- (void)setupLayout {
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.top.offset(5);
        make.bottom.offset(-5);
        make.width.mas_equalTo(self.iconView.mas_height);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.left.mas_equalTo(self.iconView.mas_right).offset(5);
        make.right.offset(-10);
        make.height.offset(50);
    }];
    [_specificsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.iconView.mas_right).offset(5);
        make.right.offset(-10);
        make.height.offset(30);
    }];
}

- (void)setFoodInfo:(FoodInfo *)foodInfo {
    _foodInfo = foodInfo;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:_foodInfo.img] placeholderImage:[UIImage imageNamed:@"avator.png"]];
    _nameLabel.text = _foodInfo.name;
    _specificsLabel.text = _foodInfo.specifics;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
