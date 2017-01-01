//
//  SettingVC.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/10/21.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "SettingVC.h"

// VC
#import "SettingDetailVC.h"
#import "NotifyListVC.h"

@interface SettingVC ()

@property (nonatomic, strong) TCell_Image *cellUser;
@property (nonatomic, strong) TCell_Image *cellVersion;
@property (nonatomic, strong) TCell_Image *cellAbout;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    [self setupUI];
}

- (void)setupUI {
    [super setupUI];
    
    WEAKSELF
    _cellUser = [TCell_Image tcell:self.tableView reuse:NO];
    _cellUser.icon = [UIImage imageNamed:@"s_info"];
    _cellUser.title = @"设置";
    _cellUser.value = @"详情";
    _cellUser.click = ^(NSIndexPath *indexPath, BaseTCell *cell) {
        [weakSelf gotoSettingDetailVC];
    };
    _cellVersion = [TCell_Image tcell:self.tableView reuse:NO];
    _cellVersion.icon = [UIImage imageNamed:@"s_setting"];
    _cellVersion.title = @"版本";
    _cellVersion.value = @"V1.0";
    _cellVersion.click = ^(NSIndexPath *indexPath, BaseTCell *cell) {
        
    };
    _cellAbout = [TCell_Image tcell:self.tableView reuse:NO];
    _cellAbout.icon = [UIImage imageNamed:@"s_notify"];
    _cellAbout.title = @"消息";
    _cellAbout.value = @"更多消息";
    _cellVersion.hasMsg = YES;
    _cellAbout.click = ^(NSIndexPath *indexPath, BaseTCell *cell) {
        [weakSelf gotoNotifyListVC];
    };
    
    self.cells = @[@[_cellUser],@[_cellAbout,_cellVersion]];
}

#pragma mark - 消息列表
- (void)gotoNotifyListVC {
    NotifyListVC *vc = [[NotifyListVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 设置详情
- (void)gotoSettingDetailVC {
    SettingDetailVC *vc = [[SettingDetailVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
