//
//  BaseSwipeVC.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/10/21.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BaseSwipeVC.h"
#import "TitleIndexView.h"
static const CGFloat kTitleIndexViewHeight = 40.0;

@interface BaseSwipeVC () <UIScrollViewDelegate>

{
    NSArray *_viewControllers;
    NSArray *_titles;
    
    /** 是否跳过移动，优化动画效果*/
    BOOL _isFastIndex;
    NSInteger _lastIndex;
}

@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) TitleIndexView *indexView;

@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation BaseSwipeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

#pragma mark - 界面
- (void)setupUI {
    [super setupUI];
    
    [self.view addSubview:self.indexView];
    [self.view addSubview:self.scrollerView];
    
    _titles = [self swipeViewTitles];
    _viewControllers = [self swipeViewControllers];
    
    NSInteger index = 0;
    for (BaseVC *vc in _viewControllers) {
        [self addChildViewController:vc];
        [vc.view setFrame:CGRectMake(index*DEVICE_WIDTH, 0, _scrollerView.frame.size.width, [self swipeViewHeight])];
        [self.scrollerView addSubview:vc.view];
        
        index++;
    }
    
    // 标题索引
    [self reloadUI];
}

- (NSArray *)swipeViewControllers { return nil; }
- (NSArray *)swipeViewTitles { return nil; }

- (TitleIndexView *)indexView {
    if (!_indexView) {
        _indexView = ({
            
            WEAKSELF
            TitleIndexView *view = [[TitleIndexView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, kTitleIndexViewHeight) titles:[self swipeViewTitles] titleColor:_normalTitleColor selectTitleColor:_selectTitleColor];
            view.backgroundColor = [UIColor whiteColor];
            view.titleLineColor = _titleLineColor;
            view.isShowTitleLine = _isShowTitleLine;
            view.clickItemBlock = ^(NSInteger index) {
                [weakSelf indexViewEvent:index];
            };
            view;
        });
    }
    return _indexView;
}

- (UIScrollView *)scrollerView {
    if (!_scrollerView) {
        _scrollerView = ({
            UIScrollView *scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, DEVICE_WIDTH, DEVICE_HEIGHT-NAV_HEIGHT-STATUS_HEIGHT-kTitleIndexViewHeight)];
            scroller.pagingEnabled = YES;
            scroller.delegate = self;
            scroller.backgroundColor = [UIColor whiteColor];
            scroller.showsHorizontalScrollIndicator = NO;
            scroller.showsVerticalScrollIndicator = NO;
            scroller;
        });
    }
    return _scrollerView;
}


- (void)reloadUI {
    if (_titles.count != _viewControllers.count) {
        NSAssert(NO, @"标题必须和控制器个数一致");
        return;
    }
    
    self.scrollerView.contentSize = CGSizeMake(DEVICE_WIDTH*_titles.count,_scrollerView.frame.size.height);
    
    _currentIndex = 0;
    _lastIndex = 0;
}

- (CGFloat)swipeViewHeight {
    return _scrollerView.frame.size.height;
}

#pragma mark - 点击标题事件
- (void)indexViewEvent:(NSInteger)index {
    if (labs(_lastIndex-index) >= 2) {
        _isFastIndex = YES;
    }
    else {
        _isFastIndex = NO;
    }

    self.currentIndex = index;
    _isFastIndex = NO;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    
    if (_isFastIndex) {
        if (_lastIndex >= currentIndex) {
            self.scrollerView.contentOffset = CGPointMake((currentIndex+1)*DEVICE_WIDTH, 0);
        }
        else {
            self.scrollerView.contentOffset = CGPointMake((currentIndex-1)*DEVICE_WIDTH, 0);
        }
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        self.scrollerView.contentOffset = CGPointMake(currentIndex*DEVICE_WIDTH, 0);
    }];
    
    _lastIndex = currentIndex;
}

#pragma mark - UIScrollerView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x/DEVICE_WIDTH;
    
    if (index == _currentIndex) {
        return;
    }
    
    self.currentIndex = index;
    self.indexView.currentIndex = index;
}

#pragma mark - 更新索引
- (void)updateFirstIndex:(NSInteger)index {
    
    _lastIndex = 0;
    _isFastIndex = YES;
    self.currentIndex = index;
    self.indexView.currentIndex = index;
    // 恢复默认状态
    _isFastIndex = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

