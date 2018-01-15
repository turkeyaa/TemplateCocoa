//
//  MainVC.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "MainVC.h"

// VC
#import "LoginVC.h"
#import "UserInfoVC.h"
// Model
#import "MainInfo.h"
// API
#import "Main_Get.h"
// Cell
#import "MainCell.h"


@interface MainVC ()

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"首页";
    
    [self setupSettingUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupSettingUI];
}

- (void)setupSettingUI {
    
    if ([[Workspace getInstance].appPreference isLoginSuccess]) {
        self.rightImage = [UIImage imageNamed:@"app_more"];
        self.rightTitle = @"";
    }
    else {
        self.rightImage = nil;
        self.rightTitle = @"登录";
    }
}

- (void)goNext {
    
    if ([[Workspace getInstance].appPreference isLoginSuccess]) {
        UserInfoVC *infoVc = [[UserInfoVC alloc] init];
        infoVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infoVc animated:YES];
    }
    else {
        LoginVC *vc = [[LoginVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - 加载数据
- (NSMutableArray *)loadDataPageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize {
    Main_Get *mainApi = [[Main_Get alloc] init];
    [mainApi call];
    return mainApi.dataSource;
}

#pragma mark -
#pragma mark - UITableView delegate and dataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MainCell classCellHeight];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MainCell *cell = [MainCell tcell:self.tableView reuse:YES];
    MainInfo *info = self.dataSource[indexPath.row];
    cell.mainInfo = info;
    cell.showIndicator = YES;
    
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
