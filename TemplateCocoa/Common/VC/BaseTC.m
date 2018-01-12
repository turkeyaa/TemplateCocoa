//
//  BaseTC.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "BaseTC.h"

#import "BaseTCell.h"

@interface BaseTC ()

@end

@implementation BaseTC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableView];
    
    [self setupLayout];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView *tableView = [[UITableView alloc] init];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.backgroundColor = [UIColor clearColor];
            tableView.tableFooterView = [[UIView alloc] init];
            tableView.tableHeaderView = [[UIView alloc] init];
            tableView;
        });
    }
    return _tableView;
}

#pragma mark - 
#pragma mark - 约束，子类可以重写该方法(自定义frame)
- (void)setupLayout {
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.offset(0);
    }];
}

#pragma mark - 
#pragma mark - UITableView delegate and dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [BaseTCell classCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 分隔线左对齐（TableView）
- (void)viewDidLayoutSubviews {
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:[self separatorInsetForTableView]];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:[self separatorInsetForTableView]];
    }
    if ([self.tableView respondsToSelector:@selector(setSeparatorColor:)]) {
        [self.tableView setSeparatorColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.3]];
    }
}

// 分隔线左对齐（TableViewCell）
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:[self separatorInsetForTableViewCell:cell atIndexPath:indexPath]];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:[self separatorInsetForTableViewCell:cell atIndexPath:indexPath]];
    }
}

#pragma mark - sparator
- (UIEdgeInsets)separatorInsetForTableView {
    return UIEdgeInsetsZero;
}

- (UIEdgeInsets)separatorInsetForTableViewCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath *)indexPath{
    return UIEdgeInsetsZero;
}

- (UIColor *)separatorColor {
    return [UIColor redColor];
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
