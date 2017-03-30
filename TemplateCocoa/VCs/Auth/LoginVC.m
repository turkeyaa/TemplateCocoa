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

@property (nonatomic, strong) UITextField *accountField;
@property (nonatomic, strong) UITextField *passwordField;

@property (nonatomic, strong) UILabel *promptLabel;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    self.rightTitle = @"提交";
    self.leftImage = [UIImage imageNamed:@"app_back"];
    
    [self p_setupUI];
    [self p_setupLayout];
}

#pragma mark - 界面
- (void)p_setupUI {
    [self.view addSubview:self.accountField];
    [self.view addSubview:self.passwordField];
    
    [self.view addSubview:self.promptLabel];
}
- (void)p_setupLayout {
    
    [_promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.offset(70);
        make.height.offset(20);
    }];
    
    [_accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(20);
        make.right.offset(-20);
        make.top.offset(100);
        make.height.offset(40);
    }];
    [_passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.top.mas_equalTo(_accountField.mas_bottom).offset(10);
        make.height.offset(40);
    }];
}
- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = @"暂未登录";
            label.textColor = [UIColor redColor];
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
    }
    return _promptLabel;
}
- (UITextField *)accountField {
    if (!_accountField) {
        _accountField = ({
            UITextField *view = [[UITextField alloc] init];
            view.placeholder = @"您的账号";
            view.keyboardType = UIKeyboardTypeDefault;
            view.borderStyle = UITextBorderStyleRoundedRect;
            view;
        });
    }
    return _accountField;
}
- (UITextField *)passwordField {
    if (!_passwordField) {
        _passwordField = ({
            UITextField *view = [[UITextField alloc] init];
            view.placeholder = @"您的密码";
            view.keyboardType = UIKeyboardTypePhonePad;
            view.borderStyle = UITextBorderStyleRoundedRect;
            view.secureTextEntry = YES;
            view;
        });
    }
    return _passwordField;
}

#pragma mark - 触摸事件,关闭键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if ([_accountField isFirstResponder]) {
        [_accountField resignFirstResponder];
    }
    if ([_passwordField isFirstResponder]) {
        [_passwordField resignFirstResponder];
    }
}

#pragma mark - 登录接口
- (void)goNext {
    
    NSString *account = _accountField.text;
    NSString *password = _passwordField.text;
    
    if (account.length == 0) {
        [self showInfoMessage:@"账号不能为空"];
        return;
    }
    if (password.length == 0) {
        [self showInfoMessage:@"密码不能为空"];
        return;
    }
    
    [self showLoadingHUD];
    
    [GCDUtil runInGlobalQueue:^{
        
        // 登录
        Login_Post *loginApi = [[Login_Post alloc] initWithAccount:account password:password];
        [loginApi call];
        
        // 线程休眠3秒
        sleep(3);
        
        [GCDUtil runInMainQueue:^{
            
            [self hideLoadingHUD];
            
            if (loginApi.code == RestApi_OK) {
                // 登录成功
                _promptLabel.text = [NSString stringWithFormat:@"登录成功,当前用户为:%@",loginApi.userInfo.user_name];
            }
            else {
                // 登录失败了
                [self showErrorMessage:loginApi.errorMessage];
            }
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
