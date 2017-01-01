//
//  BaseWebVC.m
//  Template
//
//  Created by yuwenhua on 15/12/31.
//  Copyright © 2015年 DS. All rights reserved.
//

#import "BaseWebVC.h"

#import "AppDelegate.h"

@interface BaseWebVC () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation BaseWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.webView];
    [self.view addConstraints:[self customConstraints]];
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        _webView.translatesAutoresizingMaskIntoConstraints = NO;
        _webView.delegate = self;
    }
    return _webView;
}

- (NSArray *)customConstraints {
    NSMutableArray *rs = [NSMutableArray array];
    
    [rs addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_webView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_webView)]];
    [rs addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_webView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_webView)]];
    
    return rs;
}

- (void)setBaseUrl:(NSString *)baseUrl {
    _baseUrl = baseUrl;
    
    [self reloadURL];
}

- (void)reloadURL {
    NSURL *url = [NSURL URLWithString:_baseUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = NO;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = YES;
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
