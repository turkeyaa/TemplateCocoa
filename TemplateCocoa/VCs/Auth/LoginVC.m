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
// VC
#import "RegisterVC.h"

@interface LoginVC ()

@property (nonatomic, strong) UITextField *accountField;
@property (nonatomic, strong) UITextField *passwordField;

@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UILabel *promptLabel;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    self.rightTitle = @"注册";
    self.leftImage = [UIImage imageNamed:@"app_back"];
    
    [self p_setupUI];
    [self p_setupLayout];
}

#pragma mark - 界面
- (void)p_setupUI {
    [self.view addSubview:self.accountField];
    [self.view addSubview:self.passwordField];
    
    [self.view addSubview:self.promptLabel];
    
    [self.view addSubview:self.loginBtn];
    
    // 默认账号
    _accountField.text = @"186xxxxxxxx";
    _passwordField.text = @"123456";
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
        make.top.mas_equalTo(self.accountField.mas_bottom).offset(10);
        make.height.offset(40);
    }];
    
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(20);
        make.right.offset(-20);
        make.top.mas_equalTo(self.passwordField.mas_bottom).offset(30);
        make.height.offset(40);
    }];
}
- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = ({
            UIButton *btn = [[UIButton alloc] init];
            [btn setBackgroundColor:Color_Nav];
            [btn setTitle:@"登录" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(loginEvent) forControlEvents:UIControlEventTouchUpInside];
            btn;
        });
    }
    return _loginBtn;
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
- (void)loginEvent {
    
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
        sleep(2);
        
        [GCDUtil runInMainQueue:^{
            
            [self hideLoadingHUD];
            
            if (loginApi.code == RestApi_OK) {
                // 登录成功
                self.promptLabel.text = [NSString stringWithFormat:@"登录成功,当前用户为:%@",loginApi.userInfo.user_name];
                
                // 登录成功配置
                [[Workspace getInstance] onLogIn:loginApi];
                
                // 返回到首页
                [self.navigationController popViewControllerAnimated:YES];
            }
            else {
                // 登录失败了
                [self showErrorMessage:loginApi.errorMessage];
            }
        }];
    }];
}

#pragma mark - 登录接口
- (void)goNext {
    RegisterVC *vc = [[RegisterVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
