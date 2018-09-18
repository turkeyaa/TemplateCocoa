//
//  MainCell.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/5/31.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MainCell.h"

#import <FlyImage/FlyImage.h>

@interface MainCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *spellLabel;

@end

@implementation MainCell

+ (CGFloat)classCellHeight {
    return 100.0;
}

- (void)setupSubViews {
    [self addSubview:self.nameLabel];
    [self addSubview:self.spellLabel];
    [self addSubview:self.iconView];
    
    [self setupLayout];
}

- (void)setupLayout {
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.left.offset(10);
        make.bottom.offset(-5);
        make.width.mas_equalTo(_iconView.mas_height);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.mas_equalTo(_iconView.mas_right).offset(10);
        make.right.offset(10);
        make.height.offset(30);
    }];
    [self.spellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(50);
        make.left.mas_equalTo(_iconView.mas_right).offset(10);
        make.right.offset(10);
        make.height.offset(30);
    }];
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = FONT(15);
            label.textColor = [UIColor blackColor];
            label;
        });
    }
    return _nameLabel;
}
- (UILabel *)spellLabel {
    if (!_spellLabel) {
        _spellLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = FONT(15);
            label.textColor = [UIColor lightGrayColor];
            label;
        });
    }
    return _spellLabel;
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

- (void)setMainInfo:(MainInfo *)mainInfo {
    _mainInfo = mainInfo;
    
    _nameLabel.text = mainInfo.name;
    _spellLabel.text = mainInfo.name_spell;
    
    NSString *avatar_url = mainInfo.avatar_url;
    NSLog(@"%@",mainInfo.avatar_url);
//    [_iconView setPlaceHolderImageName:@"avator.png" iconURL:[NSURL URLWithString:avatar_url]];
//    [_iconView sd_setImageWithURL:[NSURL URLWithString:avatar_url] placeholderImage:[UIImage imageNamed:@"avator.png"] options:SDWebImageRefreshCached];
//    [_iconView sd_setImageWithURL:[NSURL URLWithString:avatar_url] placeholderImage:[UIImage imageNamed:@"avator.png"]];
    
    [GCDUtil runInGlobalQueue:^{
        NSURL *url = [NSURL URLWithString:avatar_url];
        NSData *data=[NSData dataWithContentsOfURL:url];
        //将网络数据初始化为UIImage对象
        UIImage *image=[UIImage imageWithData:data];
        if (image != nil) {
            [GCDUtil runInMainQueue:^{
                self->_iconView.image = image;
            }];
        }
    }];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
