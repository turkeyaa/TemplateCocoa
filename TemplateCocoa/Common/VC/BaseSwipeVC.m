//
//  BaseSwipeVC.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/10/21.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BaseSwipeVC.h"

@interface BaseSwipeVC () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollerView;
@property (nonatomic, strong) BaseVC *currentVC;

@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation BaseSwipeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.scrollerView];
    [self reloadUI];
}

- (UIScrollView *)scrollerView {
    if (!_scrollerView) {
        _scrollerView = ({
            UIScrollView *scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT)];
            scroller.pagingEnabled = YES;
            scroller.delegate = self;
            scroller.backgroundColor = [UIColor whiteColor];
            scroller.showsHorizontalScrollIndicator = NO;
            scroller.showsVerticalScrollIndicator = NO;
//            scroller.layer.borderWidth = 6.0;
//            scroller.layer.borderColor = [UIColor orangeColor].CGColor;
            scroller;
        });
    }
    return _scrollerView;
}

- (void)reloadUI {
    if (_titles.count != _vcs.count) {
        NSAssert(NO, @"标题必须和控制器个数一致");
        return;
    }
    
    self.scrollerView.contentSize = CGSizeMake(DEVICE_WIDTH*_titles.count,DEVICE_HEIGHT-NAV_HEIGHT-STATUS_HEIGHT);
    
    _selectIndex = 0;
    [self updateCurrentVC];
}

- (void)updateCurrentVC {
    self.currentVC = _vcs[_selectIndex];
    self.currentVC.view.frame = CGRectMake(DEVICE_WIDTH*_selectIndex, 0, DEVICE_WIDTH, DEVICE_HEIGHT-NAV_HEIGHT-STATUS_HEIGHT);
    
//    if (![self.childViewControllers containsObject:self.currentVC]) {
//        [self addChildViewController:self.currentVC];
//    }
    
    if (![self.scrollerView.subviews containsObject:self.currentVC.view]) {
        [self.scrollerView addSubview:self.currentVC.view];
    }
}

#pragma mark - UIScrollerView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _selectIndex = scrollView.contentOffset.x/DEVICE_WIDTH;
    [self updateCurrentVC];
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
