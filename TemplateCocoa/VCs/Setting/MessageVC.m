//
//  MessageVC.m
//  TemplateCocoa
//
//  Created by wenhua yu on 2018/1/12.
//  Copyright © 2018年 DS. All rights reserved.
//

#import "MessageVC.h"

@interface MessageVC ()

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.leftImage = [UIImage imageNamed:@"app_back"];
}

- (NSArray *)swipeViewTitles {
    return @[@"全部",@"已读",@"未读"];
}
- (NSArray *)swipeViewControllers {
    BaseVC *one = [[BaseVC alloc] init];
    one.view.backgroundColor = [UIColor redColor];
    BaseVC *two = [[BaseVC alloc] init];
    two.view.backgroundColor = [UIColor blueColor];
    BaseVC *three = [[BaseVC alloc] init];
    three.view.backgroundColor = [UIColor yellowColor];
    
    return @[one,two,three];
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
