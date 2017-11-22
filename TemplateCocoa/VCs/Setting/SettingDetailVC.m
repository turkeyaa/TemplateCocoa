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
}

- (NSArray *)swipeViewTitles {
    return @[@"首页",@"商品",@"Three",@"Four"];
}

- (NSArray *)swipeViewControllers {
    MainVC *mainVc = [[MainVC alloc] init];
    LibraryVC *libraryVc = [[LibraryVC alloc] init];
    BaseVC *vc3 = [[BaseVC alloc] init];
    vc3.view.layer.borderColor = [UIColor redColor].CGColor;
    vc3.view.layer.borderWidth = 5.0;
    
    BaseVC *vc4 = [[BaseVC alloc] init];
    vc4.view.layer.borderColor = [UIColor blueColor].CGColor;
    vc4.view.layer.borderWidth = 5.0;
    
    return @[mainVc,libraryVc,vc3,vc4];
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
