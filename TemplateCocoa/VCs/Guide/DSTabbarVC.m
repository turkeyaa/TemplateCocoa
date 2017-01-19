//
//  DSTabbarVC.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "DSTabbarVC.h"

// VC
#import "LibraryVC.h"
#import "MainVC.h"
#import "MineVC.h"
// View
#import "DSTabbarView.h"


@interface DSTabbarVC () <DSTabbarDelegate,DSTabbarDataSource>

{
    NSArray *_models;
}

@end

@implementation DSTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化视图控制器
    [self initVC];
}

- (void)initVC {
    
#if 1
    
    // 默认 tabbar
    MainVC *mainVc = [[MainVC alloc] init];
    LibraryVC *libraryVc = [[LibraryVC alloc] init];
    MineVC *mineVc = [[MineVC alloc] init];
    
    UITabBarItem *mainItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"main"] selectedImage:[UIImage imageNamed:@"mainHigh"]];
    mainVc.tabBarItem = mainItem;
    
    UITabBarItem *libraryItem = [[UITabBarItem alloc] initWithTitle:@"病例库" image:[UIImage imageNamed:@"library"] selectedImage:[UIImage imageNamed:@"libraryHigh"]];
    libraryVc.tabBarItem = libraryItem;
    
    UITabBarItem *mineItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[UIImage imageNamed:@"mine"] selectedImage:[UIImage imageNamed:@"mineHigh"]];
    mineVc.tabBarItem = mineItem;
    
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:mainVc];
    UINavigationController *libraryNav = [[UINavigationController alloc] initWithRootViewController:libraryVc];
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mineVc];
    
    self.viewControllers = @[mainNav,libraryNav,mineNav];
    
    
#else
    
    // 自定义 tabbar
    MainVC *mainVc = [[MainVC alloc] init];
    LibraryVC *libraryVc = [[LibraryVC alloc] init];
    MineVC *mineVc = [[MineVC alloc] init];
    
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:mainVc];
    UINavigationController *libraryNav = [[UINavigationController alloc] initWithRootViewController:libraryVc];
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mineVc];
    
    self.viewControllers = @[mainNav,libraryNav,mineNav];
    
    self.tabBar.alpha = 0.0;
    self.selectedIndex = 0;
    
    /**
     *  配置
     */
    _models = @[[DSTabItemModel modelWithTitle:@"首页" image:@"main" selectedImage:@"mainHigh"],
                [DSTabItemModel modelWithTitle:@"病例库" image:@"library" selectedImage:@"libraryHigh"],
                [DSTabItemModel modelWithTitle:@"我的" image:@"mine" selectedImage:@"mineHigh"]
                ];
    

    self.dsTabbar = [[DSTabbarView alloc] initWithFrame:CGRectMake(0, DEVICE_HEIGHT-TAB_HEIGHT, DEVICE_WIDTH, TAB_HEIGHT)];
    self.dsTabbar.delegate = self;
    self.dsTabbar.dataSource = self;
    [self.view addSubview:self.dsTabbar];
    [self.dsTabbar setupViews];

#endif
    
}

#pragma mark - delegate or dataSource methods
- (NSUInteger)numberOfItemsInTabbar:(DSTabbarView *)tabbar {
    return _models.count;
}
- (DSTabItemModel *)tabbar:(DSTabbarView *)tabbar itemModelAtIndex:(NSUInteger)index {
    return _models[index];
}
- (void)tabbar:(DSTabbarView *)tabbar clickAtIndex:(NSUInteger)index {
    self.selectedIndex = index;
}
- (BOOL)tabbar:(DSTabbarView *)tabbar canSelectedAtIndex:(NSUInteger)index {
    return YES;
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
