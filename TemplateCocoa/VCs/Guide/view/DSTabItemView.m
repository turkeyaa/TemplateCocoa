//
//  DSTabItemView.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/1/17.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSTabItemView.h"

/*
 * height 49
 */

@interface DSTabItemView ()

{
    DSTabItemModel *_model;
}

@property (nonatomic, strong) UIView *dsContentView;
@property (nonatomic, strong) UILabel *dsTitleLabel;
@property (nonatomic, strong) UIImageView *dsIconView;



@end

@implementation DSTabItemView

- (id)initWithModel:(DSTabItemModel *)model {
    if (self = [super init]) {
        _model = model;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.dsContentView];
    [self addSubview:self.dsIconView];
    [self addSubview:self.dsTitleLabel];
    
    [self p_updateUI];
    
    [self p_setupLayout];
}

- (void)p_updateUI {
    _dsTitleLabel.text = _model.title;
    _dsIconView.image = [UIImage imageNamed:_model.selectedImageName];
}

- (UIView *)dsContentView {
    if (!_dsContentView) {
        _dsContentView = ({
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor lightGrayColor];
            view;
        });
    }
    return _dsContentView;
}
- (UILabel *)dsTitleLabel {
    if (!_dsTitleLabel) {
        _dsTitleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = FONT_TEXT_SMALL2;
            label;
        });
    }
    return _dsTitleLabel;
}
- (UIImageView *)dsIconView {
    if (!_dsIconView) {
        _dsIconView = ({
            UIImageView *view = [[UIImageView alloc] init];
            view.contentMode = UIViewContentModeScaleAspectFit;
            view;
        });
    }
    return _dsIconView;
}

- (void)p_setupLayout {
    [_dsContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.offset(0);
    }];
    [_dsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(0);
        make.height.offset(20);
    }];
    [_dsIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(25);
        make.centerX.mas_equalTo(self.mas_centerX).offset(0);
        make.bottom.offset(-5);
    }];
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    
    if (selected) {
        _dsTitleLabel.textColor = [UIColor redColor];
    }
    else {
        _dsTitleLabel.textColor = [UIColor whiteColor];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
