//
//  BSTitleIndexView.m
//  HealthCloud
//
//  Created by yuwenhua on 2017/10/31.
//  Copyright © 2017年 www.bsoft.com. All rights reserved.
//

#import "BSTitleIndexView.h"

@interface BSTitleIndexView ()

{
    NSArray *_titles;
    UIColor *_normalTitleColor;
    UIColor *_selectTitleColor;
    
    CGFloat _totalWidth;
}

/** 上一个索引 */
@property (nonatomic, assign) NSInteger lastIndex;

@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) UIView *titleLineView;

@end

@implementation BSTitleIndexView

- (id)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles titleColor:(UIColor *)titleColor selectTitleColor:(UIColor *)selectTitleColor {
    if (self = [super initWithFrame:frame]) {
        _titles = titles;
        _normalTitleColor = titleColor;
        _selectTitleColor = selectTitleColor;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.scrollerView];
    [self.scrollerView addSubview:self.titleLineView];
    
    _currentIndex = 0;
    _lastIndex = 0;
    
    if (_titles.count == 0) {
        NSAssert(NO, @"标题数组不能为空");
        return;
    }
    
    for (__strong UIView *deleteView in _scrollerView.subviews) {
        if ([deleteView isKindOfClass:[UIButton class]]) {
            [deleteView removeFromSuperview];
            deleteView = nil;
        }
    }
    
    CGFloat xPadding = 10.0;
    CGFloat btnWidth = 0.0;
    for (NSInteger nn=0; nn<_titles.count; nn++) {
        NSString *title = _titles[nn];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:_selectTitleColor forState:UIControlStateSelected];
        [btn setTitleColor:_normalTitleColor forState:UIControlStateNormal];
        [btn.titleLabel setFont:FONT(15)];
        [btn setTag:1000+nn];
        [btn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        // 计算宽度
        CGSize titleSize = [self textSize:title];
        
        
        if (nn==0) {
            [btn setSelected:YES];
            btnWidth = titleSize.width;
        }
        
        [btn setFrame:CGRectMake(xPadding, 0, titleSize.width+10, _scrollerView.frame.size.height-2)];
        
        [_scrollerView addSubview:btn];
        
        xPadding+=titleSize.width+10;
        xPadding+=20;
    }
    
    _totalWidth = xPadding;
    _scrollerView.contentSize = CGSizeMake(xPadding, self.frame.size.height);
    
    _titleLineView.frame = CGRectMake(10, self.frame.size.height-2, btnWidth, 2);
    
    [self updateUI];
}

- (UIScrollView *)scrollerView {
    if (!_scrollerView) {
        _scrollerView = ({
            UIScrollView *view = [[UIScrollView alloc] init];
            view.frame = self.bounds;
            view.showsHorizontalScrollIndicator = NO;
            view;
        });
    }
    return _scrollerView;
}
- (UIView *)titleLineView {
    if (!_titleLineView) {
        _titleLineView = ({
            UIView *view = [[UIView alloc] init];
            view.alpha = 0.0;
            view;
        });
    }
    return _titleLineView;
}

- (void)updateUI {
    [self updateIndexUI];
}

- (CGSize)textSize:(NSString *)title {
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName: FONT(15)}];
    return titleSize;
}

#pragma mark - 更新索引
- (void)updateIndexUI {
    
    if (_lastIndex != _currentIndex) {
        UIButton *lastBtn = (UIButton *)[self.scrollerView viewWithTag:_lastIndex+1000];
        [lastBtn setSelected:NO];
    }
    
    UIButton *selectBtn = (UIButton *)[self.scrollerView viewWithTag:1000+_currentIndex];
    [selectBtn setSelected:YES];
    
    _lastIndex = _currentIndex;
    
    CGFloat pointX = selectBtn.frame.origin.x;
    CGFloat btnWidth = selectBtn.frame.size.width;
    
    CGFloat x = pointX+btnWidth/2;
    
    [UIView animateWithDuration:0.4 animations:^{
        
        _titleLineView.frame = CGRectMake(pointX, self.frame.size.height-2, btnWidth, 2);
        
        if (_currentIndex <= 2) {
            _scrollerView.contentOffset = CGPointMake(0, 0);
        }
        else if (_currentIndex >= _titles.count-3) {
            _scrollerView.contentOffset = CGPointMake(_totalWidth-self.frame.size.width, 0);
        }
        else {
            // 居中
            if (x > self.frame.size.width/2) {
                _scrollerView.contentOffset = CGPointMake(x-self.frame.size.width/2, 0);
            }
            else {
                _scrollerView.contentOffset = CGPointMake(0, 0);
            }
        }
    }];
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    
    // 更新界面
    [self updateUI];
}

#pragma mark - button 事件
- (void)btnEvent:(UIButton *)sender {
    
    if (sender.selected) {
        return;
    }
    sender.selected = !sender.selected;
    
    NSInteger tag = sender.tag;
    if (_clickItemBlock) {
        _clickItemBlock(tag-1000);
    }
    
    _currentIndex = tag-1000;
    [self updateIndexUI];
}

- (void)setIsShowTitleLine:(BOOL)isShowTitleLine {
    _isShowTitleLine = isShowTitleLine;
    _titleLineView.backgroundColor = _titleLineColor;
    if (_isShowTitleLine) {
        _titleLineView.alpha = 1.0;
    }
    else {
        _titleLineView.alpha = 0.0;
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
