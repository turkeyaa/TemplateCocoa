//
//  NotifyListVC.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/10/21.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "NotifyListVC.h"

/* 测试BaseLoadTC类 */
#import "Main_Get.h"
#import "MainCell.h"
#import "MainInfo.h"

@interface NotifyListVC ()

@end

@implementation NotifyListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息列表";
    self.leftImage = [UIImage imageNamed:@"app_back"];
}

- (NSMutableArray *)loadDataPageNum:(NSInteger)pageNum pageSize:(NSInteger)pageSize {
    Main_Get *mainApi = [[Main_Get alloc] init];
    [mainApi call];
    return mainApi.dataSource;
}

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
