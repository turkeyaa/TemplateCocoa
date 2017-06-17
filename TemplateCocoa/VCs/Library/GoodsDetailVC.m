//
//  GoodsDetailVC.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/9.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "GoodsDetailVC.h"

#import <WebKit/WebKit.h>

@interface GoodsDetailVC () <WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *wkWebView;

@end

@implementation GoodsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"详情";
    self.leftImage = [UIImage imageNamed:@"app_back"];
    
    [self settingWebView];
}

- (void)dealloc {
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"collectionEvent"];
}

- (void)settingWebView {
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences.minimumFontSize = 18;
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    [self.view addSubview:self.wkWebView];
    
    
#if 1
    // 本地文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"goods" ofType:@"html"];
    NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
    [self.wkWebView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
#else
    
    // 服务器h5页面
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.wkWebView loadRequest:request];
    
#endif
    
    WKUserContentController *userCc = config.userContentController;
    [userCc addScriptMessageHandler:self name:@"collectionEvent"];
    
    [GCDUtil runAfterSecs:0.4 block:^{
        // 更新js
        NSString *name = _foodInfo.name;
        NSString *desc = _foodInfo.specifics;
        NSString *stan = _foodInfo.brand_name;
        NSString *url = _foodInfo.img;
        
        NSString *jsString = [NSString stringWithFormat:@"updateJs('%@','%@','%@','%@')",name,desc,stan,url];
        [self.wkWebView evaluateJavaScript:jsString completionHandler:^(id obj, NSError * _Nullable error) {
            
        }];
        
        if (_foodInfo.collected) {
            [self.wkWebView evaluateJavaScript:@"collectionJs()" completionHandler:nil];
        }
    }];
}

/* js 调用原生接口 */
#pragma mark - 
#pragma mark - WKScriptMessageHandler delegate
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%@",NSStringFromSelector(_cmd));
    NSLog(@"%@",message.body);
    
    if ([message.name isEqualToString:@"collectionEvent"]) {
        
        // 收藏该商品
        _foodInfo.collected = YES;
        [[Workspace getInstance].collectionArray addObject:_foodInfo];
        
        // 原生调用js，更新js
        [self.wkWebView evaluateJavaScript:@"collectionJs()" completionHandler:^(id obj, NSError * _Nullable error) {
            
            if (!error) {
                [self showSuccessMessage:@"收藏商品成功"];
            }
        }];
    }
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
