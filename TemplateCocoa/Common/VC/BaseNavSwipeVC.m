//
//  BaseNavSwipeVC.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/10/21.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BaseNavSwipeVC.h"

#import "RootNavView.h"

@interface BaseNavSwipeVC () <UIScrollViewDelegate>

{
    NSArray *_viewControllers;
    NSArray *_titles;
}

@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, strong) RootNavView *navView;


@end

@implementation BaseNavSwipeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self removeNavTitleView];
}

#pragma mark - 界面
- (void)setupUI {
    [super setupUI];
    
    _titles = [self swipeViewTitles];
    _viewControllers = [self swipeViewControllers];
    
    if (_titles.count != _viewControllers.count) {
        NSAssert(NO, @"标题必须和控制器个数一致");
        return;
    }
    
    [self.navigationController.navigationBar addSubview:self.navView];
    
    [self.view addSubview:self.scrollerView];
    
    NSInteger index = 0;
    for (BaseVC *vc in _viewControllers) {
        [self addChildViewController:vc];
        [vc.view setFrame:CGRectMake(index*DEVICE_WIDTH, 0, DEVICE_WIDTH, _scrollerView.frame.size.height)];
        [self.scrollerView addSubview:vc.view];
        
        index++;
    }
    
    self.scrollerView.contentSize = CGSizeMake(DEVICE_WIDTH*_titles.count, _scrollerView.frame.size.height);
    
    _currentIndex = 0;
}

- (UIScrollView *)scrollerView {
    if (!_scrollerView) {
        _scrollerView = ({
            UIScrollView *scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-NAV_HEIGHT-STATUS_HEIGHT)];
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
- (RootNavView *)navView {
    if (!_navView) {
        _navView = ({
            
            __weak BaseNavSwipeVC *weakSelf = self;
            
            RootNavView *view = [[RootNavView alloc] initWithFrame:CGRectMake(70, 5, DEVICE_WIDTH-140, 34)];
            view.clickItemBlock = ^(NSInteger index) {
                __strong BaseNavSwipeVC *strongSelf = weakSelf;
                [strongSelf clickItemWithIndex:index];
            };
            view.titlesArray = _titles;
            view.currentIndex = _currentIndex;
            view;
        });
    }
    return _navView;
}

- (void)removeNavTitleView {
    if (_navView) {
        [_navView removeFromSuperview];
        _navView = nil;
    }
}

/** 更新索引，默认从0开始,否则调用该方法 */
- (void)updateFirstIndex:(NSInteger)index {
    self.navView.currentIndex = index;
    self.currentIndex = index;
}

#pragma mark - 设置方法
- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    
    [UIView animateWithDuration:0.4 animations:^{
        self.scrollerView.contentOffset = CGPointMake(currentIndex*DEVICE_WIDTH, 0);
    }];
}

#pragma mark - 更新索引
- (void)clickItemWithIndex:(NSInteger)index {
    [self setCurrentIndex:index];
}

#pragma mark - UIScrollerView delegate method
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/DEVICE_WIDTH;
    if (index != _currentIndex) {
        self.currentIndex = index;
        self.navView.currentIndex = index;
    }
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
