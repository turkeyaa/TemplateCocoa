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
// Helper
#import "ActionHelper.h"
// VC
#import "UserInfoVC.h"
#import "CollectionVC.h"
// Notify
#import "CollectionNotify.h"

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
    
    [self setupHeaderUI];
    
    [[LoginNotify sharedInstance] addLoginObserver:self selector:@selector(logInNotify:)];
    [[LoginNotify sharedInstance] addLogoutObserver:self selector:@selector(logOutNotify:)];
}

- (void)dealloc {
    [[LoginNotify sharedInstance] removeLoginObserver:self];
    [[LoginNotify sharedInstance] removeLogoutObserver:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _valueArr = @[
                  [NSString stringWithFormat:@"%lu",(unsigned long)[Workspace getInstance].collectionArray.count],
                  @"0"
                  ];
    [self.tableView reloadData];
}

- (void)setupHeaderUI {
    
    if ([[Workspace getInstance].appPreference isLoginSuccess]) {
        _headerView = [[LogInView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 200)];
        
        self.tableView.tableFooterView = [self tableFooterView];
    }
    else {
        _headerView = [[LogOutView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 200)];
    }
    
    _headerView.clickItemBlock = ^(NSInteger index) {
        WEAKSELF
        [weakSelf enterUserInfo];
    };
    self.tableView.tableHeaderView = _headerView;
}

- (UIView *)tableFooterView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 60)];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, DEVICE_WIDTH-20, 40)];
    [btn setTitle:@"退出" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(exitEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [btn.layer setBorderWidth:1.0];
    [btn.layer setCornerRadius:4.0];
    [view addSubview:btn];
    
    return view;
}

- (void)exitEvent:(UIButton *)sender {
    
    [ActionHelper showAlertTitle:@"退出登录" message:@"" actions:@[@"取消",@"确定"] vc:self block:^(NSInteger index) {
        
        if (index == 1) {
            
            [[Workspace getInstance] onLogOut];
        }
    }];
}

#pragma mark - 用户中心
- (void)enterUserInfo {
    if ([[Workspace getInstance].appPreference isLoginSuccess]) {
        UserInfoVC *vc = [[UserInfoVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        // 未登录，不做处理
    }
}

#pragma mark - Notify
- (void)logInNotify:(NSNotification *)notify {
    [self loginFlag:YES];
}

- (void)logOutNotify:(NSNotification *)notify {
    
    [self loginFlag:NO];
}

- (void)loginFlag:(BOOL)flag {
    if (flag) {
        _tableView.tableFooterView = [self tableFooterView];
    }
    else {
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    [self setupHeaderUI];
}

- (void)collectionNotify:(NSNotification *)notify {
    
    
}
- (void)cancelCollectionNotify:(NSNotification *)notify {
    
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
    cell.value = _valueArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (![[Workspace getInstance].appPreference isLoginSuccess]) {
        [self showInfoMessage:@"请先登录"];
        return;
    }
    
    switch (indexPath.row) {
        case 0:
        {
            // 收藏
            CollectionVC *vc = [[CollectionVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            // 浏览记录
        }
            break;
            
        default:
            break;
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
