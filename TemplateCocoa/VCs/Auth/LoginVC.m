//
//  LoginVC.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "LoginVC.h"

// Api
#import "Login_Post.h"
// Util
#import "GCDUtil.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    self.rightTitle = @"提交";
    self.leftImage = [UIImage imageNamed:@"app_back"];
}

#pragma mark - 登录
- (void)goNext {
    
    [GCDUtil runInGlobalQueue:^{
        
        Login_Post *loginApi = [[Login_Post alloc] initWithAccount:@"18668089860" password:@"123456"];
        [loginApi call];
        
        [GCDUtil runInMainQueue:^{
            
        }];
    }];
    
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
