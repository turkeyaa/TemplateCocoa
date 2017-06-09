//
//  CartCell.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/9.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CartCell.h"

@interface CartCell ()

@property (nonatomic, strong) UILabel *numberLabel;

@end

@implementation CartCell

- (void)setupSubViews {
    [super setupSubViews];
    
    [self addSubview:self.numberLabel];
    [self numberLayout];
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = FONT_H_B(15);
            label.textColor = RGB(33, 33, 33);
            label.numberOfLines = 2;
            label;
        });
    }
    return _numberLabel;
}

- (void)numberLayout {
    
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(50);
        make.height.offset(20);
        make.right.offset(-10);
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
    }];
}

- (void)setNumbers:(NSInteger)numbers {
    _numbers = numbers;
    
    _numberLabel.text = [NSString stringWithFormat:@"%ld个",(long)numbers];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
