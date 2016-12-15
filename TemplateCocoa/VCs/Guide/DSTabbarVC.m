//
//  DSTabbarVC.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "DSTabbarVC.h"

#import "LibraryVC.h"
#import "MainVC.h"
#import "MineVC.h"


@interface DSTabbarVC ()

@end

@implementation DSTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 初始化视图控制器
    [self initVC];
}

- (void)initVC {
    MainVC *mainVc = [[MainVC alloc] init];
    mainVc.title = @"首页";
    LibraryVC *libraryVc = [[LibraryVC alloc] init];
    libraryVc.title = @"病例库";
    MineVC *mineVc = [[MineVC alloc] init];
    mineVc.title = @"我的";
    
    self.viewControllers = @[mainVc,libraryVc,mineVc];
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
