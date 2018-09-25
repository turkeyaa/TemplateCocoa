//
//  TabSwitchScroll.m
//  new_supply
//
//  Created by wfpb on 15/5/9.
//  Copyright (c) 2015年 bysunnet. All rights reserved.
//

#import "TabSwitchScroll.h"

static const int kScrollLineHeight = 3;

@interface TabSwitchScroll ()

@property (nonatomic, strong) NSArray* titles;
@property (nonatomic, strong) NSArray* buttons;
@property (nonatomic, strong) UIView* scrollLine;

@end

@implementation TabSwitchScroll

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    _titles = titles;
    return [super initWithFrame:frame];
}

- (void)setupUI {
    [super setupUI];
}

- (NSArray *)constructSubViews {
    
    NSMutableArray* result = [NSMutableArray array];
    
    for (int i=0;i<self.titles.count;i++) {
        NSString* title = [self.titles objectAtIndex:i];
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTag:i];
        [button setTitleColor:self.titleColor forState:UIControlStateNormal];
        [button setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [result addObject:button];
    }
    
    self.buttons = [result copy];
    
    [result addObject:self.scrollLine];
    
    return result;
}

- (UIView*)scrollLine {
    if (!_scrollLine) {
        _scrollLine = [[UIView alloc] initWithFrame:CGRectZero];
        _scrollLine.backgroundColor = self.scrollLineColor;
    }
    return _scrollLine;
}

- (NSArray *)constraints {
    NSMutableArray* result = [NSMutableArray array];
    [result addObjectsFromArray:[self buttonsConstaints]];
    [result addObjectsFromArray:[self scrollLineConstaints]];
    return result;
}

- (NSLayoutConstraint *)XConstraint:(NSInteger)index forView:(UIView*)view {
    if (index == 0) {
        return [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.f constant:0];
    } else {
        return [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.f*index/self.buttons.count constant:0];
    }
}

- (NSArray*)buttonsConstaints {
    
    NSMutableArray* result = [NSMutableArray array];
    
    for (UIButton* button in self.buttons) {
        
        [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-0-[button]-%d-|", kScrollLineHeight] options:0 metrics:nil views:NSDictionaryOfVariableBindings(button)]];
        
        [result addObject:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.f/self.buttons.count constant:0]];
        
        [result addObject:[self XConstraint:button.tag forView:button]];
    }
    
    return result;
}

- (NSArray*)scrollLineConstaints {
    
    NSMutableArray* result = [NSMutableArray array];
    
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[_scrollLine(==%d)]-0-|", kScrollLineHeight] options:0 metrics:nil views:NSDictionaryOfVariableBindings(_scrollLine)]];
    
    [result addObject:[NSLayoutConstraint constraintWithItem:_scrollLine attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1.f/self.buttons.count constant:0]];
    
    return result;
}

- (void)setIndex:(NSInteger)index Animated:(BOOL)animated {
    [super setIndex:index];
    [self updateViews:animated];
}

- (void)setIndex:(NSInteger)index{
    [self setIndex:index Animated:YES];
}

- (void)updateViews:(BOOL)animated {
    
    for (UIButton* button in self.buttons) {
        button.selected = button.tag==self.index;
    }
    
    void (^block)(void) = ^ {
        
        CGFloat width = self.frame.size.width / self.buttons.count;
        self.scrollLine.frame = CGRectMake(width * self.index, self.frame.size.height - kScrollLineHeight, width, kScrollLineHeight);
    };
    
    if (animated) {
        // 移动滑条
        [UIView animateWithDuration:0.3f animations:block];
    } else {
        block();
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width / self.buttons.count;
    self.scrollLine.frame = CGRectMake(width * self.index, self.frame.size.height - kScrollLineHeight, width, kScrollLineHeight);
}

#pragma mark - 属性

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    
    for (UIButton* button in self.buttons) {
        button.titleLabel.font = font;
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    [super setTitleColor:titleColor];
    
    for (UIButton* button in self.buttons) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    [super setSelectedTitleColor:selectedTitleColor];
    
    for (UIButton* button in self.buttons) {
        [button setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    }
}

- (void)setScrollLineColor:(UIColor *)scrollLineColor {
    _scrollLineColor = scrollLineColor;
    self.scrollLine.backgroundColor = scrollLineColor;
}

#pragma mark - 事件

- (void)buttonClicked:(UIButton*)button {
    self.index = button.tag;
}

@end
