//
//  LibraryVC.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "LibraryVC.h"

// API
#import "Activity_Get.h"
#import "Foods_Get.h"
// Model
#import "FoodInfo.h"
#import "ActivityInfo.h"
// View
#import "XRCarouselView.h"
// Cell
#import "FoodCell.h"
// VC
#import "SearchVC.h"

@interface LibraryVC () <UITableViewDelegate,UITableViewDataSource>

/* 界面 */
@property (nonatomic, strong) XRCarouselView *carouselView; // 轮播图
@property (nonatomic, strong) UITableView *tableView;

/* 数据源 */
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation LibraryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"商品";
    self.rightImage = [UIImage imageNamed:@"l_search"];
    
    [self customUI];
    
    [self loadData];
}

- (void)goNext {
    SearchVC *vc = [[SearchVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
    
- (void)customUI {
    
    _carouselView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 200)];
    _carouselView.time = 2;
    _carouselView.pagePosition = PositionBottomCenter;
    [self.view addSubview:_carouselView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, DEVICE_WIDTH, DEVICE_HEIGHT-200-TAB_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.tableHeaderView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
}
    
- (void)loadData {
    
    NSArray *icons = @[
                       [UIImage imageNamed:@"1.jpg"],
                       [UIImage imageNamed:@"2.jpg"],
                       [UIImage imageNamed:@"3.jpg"]
                       ];
    _carouselView.imageArray = icons;
    
    [GCDUtil runInGlobalQueue:^{
        
        
//        NSMutableArray *iconsUrl = [[NSMutableArray alloc] init];
        
        Activity_Get *activityApi = [[Activity_Get alloc] init];
        [activityApi call];
        if (activityApi.code == RestApi_OK) {
            // 赋值，更新轮播图数据
//            for (ActivityInfo *info in activityApi.dataSource) {
//                [iconsUrl addObject:info.img];
//            }
//            self.carouselView.imageArray = iconsUrl;
        }
        
        Foods_Get *foodApi = [[Foods_Get alloc] init];
        [foodApi call];
        if (foodApi.code == RestApi_OK) {
            // 赋值，更新表视图数据
            _dataSource = foodApi.dataSource;
        }
        
        [GCDUtil runInMainQueue:^{
            
            [self.tableView reloadData];
        }];
    }];
}

#pragma mark - 
#pragma mark - tableView delegate and dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    FoodType *typeInfo = self.dataSource[section];
    return typeInfo.foodInfos.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [FoodCell classCellHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    FoodType *typeInfo = self.dataSource[section];
    return typeInfo.name;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FoodType *typeInfo = self.dataSource[indexPath.section];
    FoodInfo *foodInfo = typeInfo.foodInfos[indexPath.row];
    
    FoodCell *cell = [FoodCell tcell:self.tableView reuse:YES];
    cell.foodInfo = foodInfo;
    cell.showIndicator = NO;
    
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
