//
//  NewsVC.m
//  TemplateCocoa
//
//  Created by wenhua yu on 2018/1/12.
//  Copyright © 2018年 DS. All rights reserved.
//

#import "NewsVC.h"

@interface NewsVC ()

@end

@implementation NewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.leftTitle = @"返回";
    self.title = @"新闻";
}

- (void)setupUI {
    
    self.normalTitleColor = [UIColor blackColor];
    self.selectTitleColor = [UIColor redColor];
    self.titleLineColor = [UIColor redColor];
    
    [super setupUI];
}

- (NSArray *)swipeViewTitles {
    return @[@"关注",@"推荐",@"热点",@"社会",@"科技",@"趣图",@"问答",@"健康"];
}
- (NSArray *)swipeViewControllers {
    BaseVC *one = [[BaseVC alloc] init];
    one.view.backgroundColor = [UIColor blueColor];
    BaseVC *two = [[BaseVC alloc] init];
    two.view.backgroundColor = [UIColor redColor];
    BaseVC *three = [[BaseVC alloc] init];
    three.view.backgroundColor = [UIColor yellowColor];
    
    BaseVC *four = [[BaseVC alloc] init];
    four.view.backgroundColor = [UIColor greenColor];
    BaseVC *five = [[BaseVC alloc] init];
    five.view.backgroundColor = [UIColor lightGrayColor];
    BaseVC *six = [[BaseVC alloc] init];
    six.view.backgroundColor = [UIColor orangeColor];
    BaseVC *seven = [[BaseVC alloc] init];
    seven.view.backgroundColor = [UIColor redColor];
    BaseVC *eight = [[BaseVC alloc] init];
    eight.view.backgroundColor = [UIColor blueColor];
    return @[one,two,three,four,five,six,seven,eight];
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
