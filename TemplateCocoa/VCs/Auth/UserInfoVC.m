//
//  UserInfoVC.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/6.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "UserInfoVC.h"

#import "MineCell.h"

@interface UserInfoVC ()

@property (nonatomic, strong) NSArray *values;

@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"个人信息";
    self.leftImage = [UIImage imageNamed:@"app_back"];
    
    [self.dataSource addObjectsFromArray:@[@"昵称",@"生日",@"个性签名",@"等级",@"积分"]];
    self.values = @[@"turkey",@"1990/1",@"一切皆有可能",@"Lv10",@"666"];
}

#pragma mark -
#pragma mark - UITableView delegate and dataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MineCell *cell = [MineCell tcell:self.tableView reuse:YES];
    cell.title = self.dataSource[indexPath.row];
    cell.value = self.values[indexPath.row];
    return cell;
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
