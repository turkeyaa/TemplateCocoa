//
//  BaseVC.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "BaseVC.h"

#import "SVProgressHUD.h"

@interface BaseVC ()

@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIButton *leftBtn;


@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = Color_AppBackground;
    
    _leftTitle = @"";
    _rightTitle = @"";
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_isHideNav) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
    else {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
}

- (void)setupUI {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBtn];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = ({
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
            [btn setTitle:_leftTitle forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
            [btn.titleLabel setFont:FONT_TEXT_SMALL];
            btn;
        });
    }
    return _leftBtn;
}
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = ({
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
            [btn setTitle:_rightTitle forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
            [btn.titleLabel setFont:FONT_TEXT_SMALL];
            btn;
        });
    }
    return _rightBtn;
}

- (void)goBack {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)goNext {
    [self.view endEditing:YES];
}


- (void)setLeftTitle:(NSString *)leftTitle {
    _leftTitle = leftTitle;
    [_leftBtn setTitle:_leftTitle forState:UIControlStateNormal];
}
- (void)setRightTitle:(NSString *)rightTitle {
    _rightTitle = rightTitle;
    [_rightBtn setTitle:_rightTitle forState:UIControlStateNormal];
}
- (void)setLeftImage:(UIImage *)leftImage {
    _leftImage = leftImage;
    [_leftBtn setImage:_leftImage forState:UIControlStateNormal];
}
- (void)setRightImage:(UIImage *)rightImage {
    _rightImage = rightImage;
    [_rightBtn setImage:_rightImage forState:UIControlStateNormal];
}

#pragma mark - SVProgressHUD
- (void)showLoadingHUD {
    [self showLoadingHUD:@"正在加载"];
}
- (void)showLoadingHUD:(NSString *)status {
    [self settingSVProgressHUD];
    [SVProgressHUD showWithStatus:status];
}
- (void)hideLoadingHUD {
    [SVProgressHUD dismiss];
}
- (void)showInfoMessage:(NSString *)msg {
    [self settingSVProgressHUD];
    [SVProgressHUD showInfoWithStatus:msg];
}
- (void)showErrorMessage:(NSString *)msg {
    [self settingSVProgressHUD];
    [SVProgressHUD showErrorWithStatus:msg];
}
- (void)showSuccessMessage:(NSString *)msg {
    [self settingSVProgressHUD];
    [SVProgressHUD showSuccessWithStatus:msg];
}

- (void)settingSVProgressHUD {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setMinimumDismissTimeInterval:3];
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
