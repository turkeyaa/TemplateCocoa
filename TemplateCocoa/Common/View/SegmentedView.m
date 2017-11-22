//
//  SegmentedView.m
//  Refrence
//
//  Created by mac on 15/8/15.
//  Copyright (c) 2015年 ds. All rights reserved.
//

#import "SegmentedView.h"


@interface SegmentedView ()

{
    NSInteger _selectedIndex;
    NSMutableArray *_redViewArray;
}

@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) UIView *lineView;


@end

@implementation SegmentedView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.lineView];
        _selectedIndex = 0;
    }
    return self;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = ({
            UIView *view = [[UIView alloc] init];

            view.frame = CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1);
            view.tag = 10.0;
            view.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
            view;
        });
    }
    return _lineView;
}

- (UIImageView *)bgImage {
    if (!_bgImage) {
        
        if (self.isMyDiscuss == YES) {
            
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, self.frame.size.height - 2)];
            lab.font = FONT_TEXT_SMALL;
            lab.text = @"我就是我";
            [lab sizeToFit];
            CGFloat wid = lab.frame.size.width;
            _bgImage = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width/_btnTitles.count - wid) / 2, self.frame.size.height-2, wid, 2)];
//            _bgImage.backgroundColor = Color_SegmentSelectTitle;
            _bgImage.backgroundColor = [UIColor blueColor];
        }else{
            _bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-2, self.frame.size.width/_btnTitles.count, 2)];
//            _bgImage.backgroundColor = Color_SegmentSelectTitle;
            _bgImage.backgroundColor = [UIColor redColor];
        }
        
        
    }
    return _bgImage;
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    
    if ([self.delegate respondsToSelector:@selector(clickSegmentedViewWithIndex:)]) {
        [self.delegate clickSegmentedViewWithIndex:index];
    }
    // TODO 更新 button 选中状态
    
    UIButton *btn = (UIButton *)[self viewWithTag:index + 100];;
    [self clickBtn:btn];
}

- (void)setShowRedView:(NSInteger)showRedView {
    _showRedView = showRedView;
    UIView *view = (UIView *)[self viewWithTag:200 + showRedView];
    view.hidden = NO;
}

- (void)setBtnTitles:(NSArray *)btnTitles {
    _btnTitles = btnTitles;
    
    [self addSubview:self.bgImage];
    [self updateView];
}

- (UIButton *)createButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.adjustsImageWhenHighlighted = NO;
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:RGB(0x00, 0x96, 0xf2) forState:UIControlStateSelected];
    [btn setTitleColor:RGB(0x66, 0x66, 0x66) forState:UIControlStateNormal];
    [btn.titleLabel setFont:FONT_TEXT_SMALL];
    return btn;
}

- (void)updateView {
    CGRect aframe = self.frame;
    
    CGFloat width = aframe.size.width/_btnTitles.count;
    CGFloat height = aframe.size.height;
    _redViewArray = [NSMutableArray array];
    
    for (int nn=0; nn<_btnTitles.count; nn++) {
        UIButton *btn = [self createButton];
        btn.tag = nn + 100;
        if (nn == 0) {
            btn.selected = YES;
        }
        [btn setFrame:CGRectMake(width*nn, 0, width, height)];
        [btn setTitle:_btnTitles[nn] forState:UIControlStateNormal];
        
        if (self.isMyDiscuss == YES) {
            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, self.frame.size.height - 2)];
            lab.font = FONT_TEXT_SMALL;
            lab.text = @"我就是我";
            [lab sizeToFit];
            CGFloat wid = lab.frame.size.width;
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake((nn * 2 + 1) * (DEVICE_WIDTH - wid * 3) / 6 + nn * wid + wid + 2, 10, 6, 6)];
            view.backgroundColor = [UIColor redColor];
            view.layer.cornerRadius = 3;
            view.layer.masksToBounds = YES;
            view.tag = 200 + nn;
            view.hidden = YES;
            [self addSubview:view];
            [_redViewArray addObject:view];
        }
        
        [self addSubview:btn];
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 0.3, self.frame.size.width, 0.3)];
    view.backgroundColor = RGB(0xdd, 0xdd, 0xdd);
    [self addSubview:view];
}

#pragma mark -
- (void)clickBtn:(UIButton *)sender {
    
//    if ([sender isKindOfClass:[UIView class]]) {
//        return;
//    }
    if ([sender isEqual:_lineView]) {
        return;
    }
    if (sender.selected) {
        return;
    }
    
    sender.selected = !sender.selected;
    
    [self updateBtnBg];
    
    _selectedIndex = sender.tag - 100;
    
    [self updateLineFrame:_selectedIndex];
    
    if ([self.delegate respondsToSelector:@selector(clickSegmentedViewWithIndex:)]) {
        [self.delegate clickSegmentedViewWithIndex:_selectedIndex];
    }
}

- (void)updateBtnBg {
    UIButton *btn = (UIButton *)[self viewWithTag:_selectedIndex + 100];
    btn.selected = NO;
}

- (void)updateLineFrame:(NSInteger)index {
    if (self.isMyDiscuss == YES) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, self.frame.size.height - 2)];
        lab.font = FONT_TEXT_SMALL;
        lab.text = @"我就是我";
        [lab sizeToFit];
        CGFloat wid = lab.frame.size.width;
        [UIView animateWithDuration:0.3 animations:^{
            self.bgImage.frame = CGRectMake((index * 2 + 1) * (DEVICE_WIDTH - wid * 3) / 6 + index * wid, self.frame.size.height-2, wid, 2);
        }];
        UIView *view = (UIView *)[self viewWithTag:index + 200];
        view.hidden = YES;
        
        /*
        if (index == 1) {
            [Workspace currentUser].if_related = NO;
        }else if (index == 2) {
            [Workspace currentUser].if_focus = NO;
        }
        */
        
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.bgImage.frame = CGRectMake(index * (self.frame.size.width/_btnTitles.count), self.frame.size.height-2, self.frame.size.width/_btnTitles.count, 2);
        }];
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
