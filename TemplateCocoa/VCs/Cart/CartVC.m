//
//  CartVC.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/6.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CartVC.h"

// Cell
#import "CartCell.h"

@interface CartVC ()

@end

@implementation CartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"购物车";
    self.rightTitle = @"支付";
}

- (void)goNext {
    
    [self showLoadingHUD:@"支付中..."];
    
    [GCDUtil runInGlobalQueue:^{
        
        [NSThread sleepForTimeInterval:2.0];
        [GCDUtil runInMainQueue:^{
            [self hideLoadingHUD];
            [self showSuccessMessage:@"支付成功"];
        }];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.dataSource = [Workspace getInstance].foodCartArray;
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark - TableView delegate and dataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CartCell classCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FoodInfo *info = self.dataSource[indexPath.row];
    CartCell *cell = [CartCell tcell:self.tableView reuse:YES];
    cell.showIndicator = NO;
    cell.foodInfo = info;
    cell.numbers = info.buy_numbers;
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
