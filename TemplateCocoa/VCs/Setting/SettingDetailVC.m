//
//  SettingDetailVC.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/10/21.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "SettingDetailVC.h"

#import "MainVC.h"
#import "LibraryVC.h"

@interface SettingDetailVC ()



@end

@implementation SettingDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.leftImage = [UIImage imageNamed:@"app_back"];
    self.title = @"首页";
    [self setupUI];
}

- (void)setupUI {
    [super setupUI];
    self.titles = @[@"首页",@"商品"];
    
    MainVC *mainVc = [[MainVC alloc] init];
    LibraryVC *libraryVc = [[LibraryVC alloc] init];
    
    self.vcs = @[mainVc,libraryVc];
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
