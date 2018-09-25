//
//  FoodCell.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/6.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "FoodCell.h"

@interface FoodCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *specificsLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *partnerPriceLabel;
@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic, strong) UIButton *removeBtn;
@property (nonatomic, strong) UILabel *numbersLabel;

@property (nonatomic, strong) UIButton *collectBtn;

@end

@implementation FoodCell

+ (CGFloat)classCellHeight {
    return 120.0;
}

- (void)setupSubViews {
    
    [self addSubview:self.iconView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.specificsLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.partnerPriceLabel];
    [self addSubview:self.addBtn];
    [self addSubview:self.collectBtn];
    
    [self addSubview:self.removeBtn];
    [self addSubview:self.numbersLabel];
    
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
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = FONT_H_B(15);
//            label.textColor = RGB(99, 99, 99);
            label.textColor = [UIColor redColor];
            label;
        });
    }
    return _priceLabel;
}
- (UILabel *)partnerPriceLabel {
    if (!_partnerPriceLabel) {
        _partnerPriceLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = FONT_H_B(15);
            label.textColor = RGB(99, 99, 99);
            label;
        });
    }
    return _partnerPriceLabel;
}
- (UILabel *)numbersLabel {
    if (!_numbersLabel) {
        _numbersLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = FONT_H_B(15);
            label.textColor = RGB(33, 33, 33);
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
    }
    return _numbersLabel;
}
- (UIButton *)collectBtn {
    if (!_collectBtn) {
        _collectBtn = ({
            UIButton *btn = [[UIButton alloc] init];
            
            [btn setImage:[UIImage imageNamed:@"l_collect"] forState:UIControlStateSelected];
            [btn setImage:[UIImage imageNamed:@"l_collectNot"] forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
            [btn addTarget:self action:@selector(collectEvent:) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
    }
    return _collectBtn;
}
- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = ({
            UIButton *btn = [[UIButton alloc] init];

            [btn setImage:[UIImage imageNamed:@"l_add"] forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
            [btn addTarget:self action:@selector(addEvent:) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
    }
    return _addBtn;
}
- (UIButton *)removeBtn {
    if (!_removeBtn) {
        _removeBtn = ({
            UIButton *btn = [[UIButton alloc] init];
            [btn setImage:[UIImage imageNamed:@"l_remove"] forState:UIControlStateNormal];
            [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 5, 10, 5)];
            [btn addTarget:self action:@selector(removeEvent:) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
    }
    return _removeBtn;
}

- (void)setupLayout {
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(5);
        make.top.offset(5);
        make.bottom.offset(-5);
        make.width.mas_equalTo(self.iconView.mas_height);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.mas_equalTo(self.iconView.mas_right).offset(5);
        make.right.offset(-20);
        make.height.offset(30);
    }];
    [_specificsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.iconView.mas_right).offset(5);
        make.right.offset(-20);
        make.height.offset(30);
    }];
    [_partnerPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.specificsLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.iconView.mas_right).offset(5);
        make.width.offset(50);
        make.height.offset(20);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.specificsLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.partnerPriceLabel.mas_right).offset(10);
        make.width.offset(50);
        make.height.offset(20);
    }];
    [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.offset(40);
        make.top.offset(5);
        make.right.offset(-10);
    }];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(30);
        make.right.offset(-10);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [_removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(30);
        make.right.offset(-60);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
    [_numbersLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(30);
        make.right.offset(-30);
        make.centerY.mas_equalTo(self.mas_centerY);
    }];
}

- (UIImage *)cartImage {
    return _iconView.image;
}

- (void)setFoodInfo:(FoodInfo *)foodInfo {
    _foodInfo = foodInfo;
    
    [self updateUI];
}

- (void)updateUI {
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:_foodInfo.img] placeholderImage:[UIImage imageNamed:@"avator.png"]];
    _nameLabel.text = _foodInfo.name;
    _specificsLabel.text = _foodInfo.specifics;
    _priceLabel.text = _foodInfo.price;
    _partnerPriceLabel.text = _foodInfo.partner_price;
    
    [self updateBuyUI];
    [self updateCollectUI];
}

- (void)updateCollectUI {
    _collectBtn.selected = _foodInfo.collected;
}

- (void)updateBuyUI {
    _numbersLabel.text = [NSString stringWithFormat:@"%ld",(long)_foodInfo.buy_numbers];
}

#pragma mark - Event
- (void)addEvent:(UIButton *)sender {
    if (_foodInfo.buy_numbers > _foodInfo.store_nums) {
        // 不能大于库存
    }
    else {
        _foodInfo.buy_numbers++;
        [self updateBuyUI];
        
        if (_clickAddBlock) {
            _clickAddBlock(_foodInfo.buy_numbers);
        }
    }
}

- (void)removeEvent:(UIButton *)sender {
    if (_foodInfo.buy_numbers <= 0) {
        // 不能小于0
    }
    else {
        _foodInfo.buy_numbers--;
        [self updateBuyUI];
        
        if (_clickReduceBlock) {
            _clickReduceBlock(_foodInfo.buy_numbers);
        }
    }
}
- (void)collectEvent:(UIButton *)sender {
    
    _foodInfo.collected = !_foodInfo.collected;
    [self updateCollectUI];
    
    if (_clickCollectBlock) {
        _clickCollectBlock(_foodInfo.collected);
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
