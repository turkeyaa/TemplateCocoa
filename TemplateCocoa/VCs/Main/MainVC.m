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
#import "RegisterVC.h"
// Model
#import "MainInfo.h"
// API
#import "Main_Get.h"
// Cell
#import "MainCell.h"


@interface MainVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.leftTitle = @"登录";
    self.rightTitle = @"注册";
    self.title = @"首页";
    
    // 初始化界面
    [self setupUI];
    
    // 加载数据
    [self loadData];
}

- (void)goBack {
    LoginVC *vc = [[LoginVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)goNext {
    RegisterVC *vc = [[RegisterVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = ({
            UITableView *table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
            table.delegate = self;
            table.dataSource = self;
            table.tableHeaderView = [[UIView alloc] init];
            table.tableFooterView = [[UIView alloc] init];
            table;
        });
    }
    return _tableView;
}


#pragma mark - 加载数据
- (void)loadData {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        Main_Get *mainApi = [[Main_Get alloc] init];
        [mainApi call];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (mainApi.code == RestApi_OK) {
                self.dataSource = mainApi.dataSource;
                [self.tableView reloadData];
            }
            else {
                [self showErrorMessage:@"加载失败"];
            }
        });
    });
}

#pragma mark -
#pragma mark - UITableView delegate and dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MainCell";
    MainCell *cell = (MainCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    MainInfo *info = self.dataSource[indexPath.row];
    cell.mainInfo = info;
    
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
