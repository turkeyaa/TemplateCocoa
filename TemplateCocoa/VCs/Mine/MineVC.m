//
//  MineVC.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "MineVC.h"

// View
#import "LogInView.h"
#import "LogOutView.h"
// Cell
#import "MineCell.h"
// Notify
#import "LoginNotify.h"

@interface MineVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MineHeaderView *headerView;

/* 数据源 */
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *valueArr;

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
    
    _titleArr = @[@"我的收藏",@"购买记录"];
    [self.view addSubview:self.tableView];
    
    if ([[Workspace getInstance].appPreference isLoginSuccess]) {
        _headerView = [[LogInView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 200)];
    }
    else {
        _headerView = [[LogOutView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 200)];
    }
    self.tableView.tableHeaderView = _headerView;
    
    [[LoginNotify sharedInstance] addLoginObserver:self selector:@selector(logInNotify:)];
}

- (void)logInNotify:(NSNotification *)notify {
    // TODO:
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView *view = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
            view.delegate = self;
            view.dataSource = self;
            view.tableFooterView = [[UIView alloc] init];
            view.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 20)];
            view;
        });
    }
    return _tableView;
}

#pragma mark -
#pragma mark - tableView delegate and dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineCell *cell = [MineCell tcell:self.tableView reuse:YES];
    cell.showIndicator = YES;
    cell.title = _titleArr[indexPath.row];
    cell.value = @"无";
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
