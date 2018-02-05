//
//  EmptyVC.m
//  TemplateCocoa
//
//  Created by wenhua yu on 2018/2/5.
//  Copyright © 2018年 DS. All rights reserved.
//

#import "EmptyVC.h"

@interface EmptyVC ()

@end

@implementation EmptyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"空页面交互";
    self.rightTitle = @"重置";
    self.leftImage = [UIImage imageNamed:@"app_back"];
    self.isShowEmptyView = YES;
}

- (void)goNext {
    self.isShowEmptyView = YES;
}

/** 可选，子类已实现 */
- (UIImage *)baseEmptyImage {
    return [UIImage imageNamed:@"app_emptyView"];
}
- (NSString *)baseEmptyTitle {
    return @"暂无内容";
}
- (NSString *)baseEmptySecondTitle {
    return @"暂无子标题";
}
- (void)baseEmptyRefresh {
    [self showLoadingHUD:@"刷新空页面"];
    [GCDUtil runInGlobalQueue:^{
        sleep(1);
        [GCDUtil runInMainQueue:^{
            [self showSuccessMessage:@"刷新成功"];
            self.isShowEmptyView = NO;
        }];
    }];
}
- (CGRect)baseEmptyViewFrame {
    return CGRectMake(0, STATUS_HEIGHT+NAV_HEIGHT, DEVICE_WIDTH, DEVICE_HEIGHT-STATUS_HEIGHT-NAV_HEIGHT);
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
