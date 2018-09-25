//
//  BaseLoadTC.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "BaseLoadTC.h"

#import <MJRefresh/MJRefresh.h>

const NSUInteger static kPageSize = 10;

@interface BaseLoadTC ()

{
    NSInteger _pageNumber;  // 第几页，默认为1
}

@end


@implementation BaseLoadTC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pageNumber = 1;
    
//    MJChiBaoZiHeader *header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
//    header.lastUpdatedTimeLabel.hidden = YES;
//    header.stateLabel.hidden = YES;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    
    [self loadData];
}

- (void)loadData {
    _pageNumber = 1;
    [self updateData:YES];
}

- (void)refreshData {
    _pageNumber = 1;
    [self updateData:NO];
}

- (void)loadMore {
    _pageNumber++;
    [self updateData:NO];
}

- (NSMutableArray *)loadDataPageNum:(NSInteger)pageNum
                           pageSize:(NSInteger)pageSize {
    NSAssert(NO, @"子类必须重写改方法");
    return nil;
}

- (void)updateData:(BOOL)showLoading {
    
    if (showLoading) {
        [self showLoadingHUD:@"正在加载"];
    }
    
    [GCDUtil runInGlobalQueue:^{
        
        NSMutableArray *ret = [self loadDataPageNum:self->_pageNumber pageSize:kPageSize];
        
        if (self->_pageNumber == 1) {
            self.dataSource = ret;
        }
        else {
            [self.dataSource addObjectsFromArray:[ret copy]];
        }
        
        [GCDUtil runInMainQueue:^{
            [self hideLoadingHUD];
            
            // total: 数据库所有数据列表
            NSInteger total = 100;
            [self setupRefreshWithTotal:total];
            
            [self.tableView reloadData];
        }];
    }];
}

- (void)setupRefreshWithTotal:(NSInteger)total {
    
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
    
    if (total <= self.dataSource.count) {
        // 暂无更多结果
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    else {
        [self.tableView.mj_footer resetNoMoreData];
    }
}

@end
