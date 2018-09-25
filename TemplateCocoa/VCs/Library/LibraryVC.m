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
#import "GoodsDetailVC.h"
// Notify
#import "CollectionNotify.h"
// App
#import "AppDelegate.h"

@interface LibraryVC () <UITableViewDelegate,UITableViewDataSource,CAAnimationDelegate>

{
    CALayer *_cartLayer;
}

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
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
            self.dataSource = foodApi.dataSource;
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
    
    // 收藏
    cell.clickCollectBlock = ^(BOOL flag) {
        
        if (flag) {
            [self showInfoMessage:@"收藏成功"];
            [[Workspace getInstance].collectionArray addObject:foodInfo];
        }
        else {
            [self showInfoMessage:@"取消收藏"];
            [[Workspace getInstance].collectionArray removeObject:foodInfo];
        }
    };
    // 添加到购物车
    cell.clickAddBlock = ^(NSInteger index) {
        
        FoodCell *cell = (FoodCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        CGFloat cellY = cell.frame.origin.y;
        CGFloat offsetY = tableView.contentOffset.y;
        
        CGPoint position = CGPointMake(5+55, cellY-offsetY+200+45+55-NAV_HEIGHT);
        WEAKSELF
        [weakSelf addCartFood:foodInfo];
        [weakSelf cartAnimationWithPosition:position content:cell.cartImage];
    };
    cell.clickReduceBlock = ^(NSInteger index) {
        
        WEAKSELF
        [weakSelf reduceCartFood:foodInfo];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FoodType *typeInfo = self.dataSource[indexPath.section];
    FoodInfo *foodInfo = typeInfo.foodInfos[indexPath.row];
    
    GoodsDetailVC *vc = [[GoodsDetailVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.foodInfo = foodInfo;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 
#pragma mark - 数据：购物车商品
- (void)addCartFood:(FoodInfo *)foodInfo {
    
    __block BOOL result = NO;
    [[Workspace getInstance].foodCartArray enumerateObjectsUsingBlock:^(FoodInfo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([foodInfo._id isEqualToString:obj._id]) {
            result = YES;
            *stop = YES;
        }
    }];
    if (!result) {
        [[Workspace getInstance].foodCartArray addObject:foodInfo];
    }
    [self updateBadge];
}

- (void)reduceCartFood:(FoodInfo *)foodInfo {
    
    __block BOOL result = NO;
    [[Workspace getInstance].foodCartArray enumerateObjectsUsingBlock:^(FoodInfo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([foodInfo._id isEqualToString:obj._id]) {
            if (obj.buy_numbers == 0) {
                result = YES;
                *stop = YES;
            }
        }
    }];
    if (result) {
        [[Workspace getInstance].foodCartArray removeObject:foodInfo];
    }
    [self updateBadge];
}

#pragma mark - 更新角标
- (void)updateBadge {
    
    __block NSInteger numbers = 0;
    [[Workspace getInstance].foodCartArray enumerateObjectsUsingBlock:^(FoodInfo *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        numbers += obj.buy_numbers;
    }];
    [SharedApp.tabbarVC updateBadge:2 badge:numbers];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim {
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    [_cartLayer removeFromSuperlayer];
    _cartLayer = nil;
}

#pragma mark - 购物车动画
- (void)cartAnimationWithPosition:(CGPoint)position
                          content:(UIImage *)content {
    
    if (_cartLayer) {
        return;
    }
    // 动画
    _cartLayer = [[CALayer alloc] init];
    _cartLayer.bounds = CGRectMake(0, 0, 110, 110);
    _cartLayer.position = position;
    _cartLayer.contents = (id)content.CGImage;
    [self.view.layer addSublayer:_cartLayer];
    
    // 贝塞尔曲线绘制动画路径
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    [bezier moveToPoint:CGPointMake(_cartLayer.position.x, _cartLayer.position.y)];
    [bezier addCurveToPoint:CGPointMake(DEVICE_WIDTH/5*3-30, DEVICE_HEIGHT-TAB_HEIGHT) controlPoint1:CGPointMake(_cartLayer.position.x+50, _cartLayer.position.y-20) controlPoint2:CGPointMake(_cartLayer.position.x+100, _cartLayer.position.y)];
    keyframeAnimation.path = bezier.CGPath;
    keyframeAnimation.duration = 1.0;
    
    // 缩放
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    rotationAnimation.duration = 1.0;
    rotationAnimation.autoreverses = NO;
    rotationAnimation.fromValue = @(1);
    rotationAnimation.toValue = @(0.2);
    
    // 添加到动画组
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[keyframeAnimation,rotationAnimation];
    group.duration = 1.0;
    group.delegate = self;
    group.removedOnCompletion = YES;
    [_cartLayer addAnimation:group forKey:@"CartAnimation"];
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
