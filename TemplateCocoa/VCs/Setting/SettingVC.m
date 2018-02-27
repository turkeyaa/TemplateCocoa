//
//  SettingVC.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/10/21.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "SettingVC.h"

// VC
#import "NewsVC.h"
#import "MessageVC.h"
#import "EmptyVC.h"

// Cell
#import "TCell_Image.h"
#import "TCell_Input.h"
#import "TCell_Label.h"
#import "TCell_Notify.h"

@interface SettingVC ()

@property (nonatomic, strong) TCell_Image *cellUser;
@property (nonatomic, strong) TCell_Image *cellVersion;
@property (nonatomic, strong) TCell_Image *cellAbout;

@property (nonatomic, strong) TCell_Image *cellNews;
@property (nonatomic, strong) TCell_Image *cellMessages;

@property (nonatomic, strong) TCell_Notify *notifyCell;
@property (nonatomic, strong) TCell_Notify *networkCell;

@property (nonatomic, strong) TCell_Input *nameCell;
@property (nonatomic, strong) TCell_Input *cardCell;

@property (nonatomic, strong) TCell_Label *emptyCell;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    // 自定义导航栏
    self.isHideNav = YES;
    self.isSetCustomNav = YES;
//    self.view.backgroundColor = Color_Nav;
    
    [self setupUI];
}

/** 自定义导航栏时需要更新表视图约束 */
- (void)setupLayout {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.offset(0);
        make.top.offset(NAV_HEIGHT+STATUS_HEIGHT);
        make.bottom.offset(-TAB_HEIGHT);
    }];
}

- (void)setupUI {
    [super setupUI];
    
    WEAKSELF
    _cellUser = [TCell_Image tcell:self.tableView reuse:NO];
    _cellUser.icon = [UIImage imageNamed:@"s_info"];
    _cellUser.title = @"设置";
    _cellUser.value = @"详情";
    
    _cellVersion = [TCell_Image tcell:self.tableView reuse:NO];
    _cellVersion.icon = [UIImage imageNamed:@"s_setting"];
    _cellVersion.title = @"版本";
    _cellVersion.value = @"V1.0";
    
    _cellAbout = [TCell_Image tcell:self.tableView reuse:NO];
    _cellAbout.icon = [UIImage imageNamed:@"s_notify"];
    _cellAbout.title = @"消息";
    _cellAbout.value = @"更多消息";
    _cellVersion.hasMsg = YES;
    
    // 多视图控制器切换(支持空页面)
    _cellNews = [TCell_Image tcell:self.tableView reuse:NO];
    _cellNews.icon = [UIImage imageNamed:@"s_notify"];
    _cellNews.title = @"新闻";
    _cellNews.click = ^(NSIndexPath *indexPath, BaseTCell *cell) {
        [weakSelf gotoNewsVC];
    };
    _cellMessages = [TCell_Image tcell:self.tableView reuse:NO];
    _cellMessages.icon = [UIImage imageNamed:@"s_notify"];
    _cellMessages.title = @"消息";
    _cellMessages.click = ^(NSIndexPath *indexPath, BaseTCell *cell) {
        [weakSelf gotoMessageVC];
    };
    
    _nameCell = [TCell_Input stringInputCell];
    _nameCell.icon = [UIImage imageNamed:@"business_nor"];
    _nameCell.title = @"姓名";
    _nameCell.showIndicator = NO;
    _nameCell.limitMaxLength = 12;
    _nameCell.placeholder = @"请输入姓名";
    
    _cardCell = [TCell_Input numberInputCell];
    _cardCell.title = @"身份证";
    _cardCell.showIndicator = NO;
    _cardCell.limitMaxLength = 20;
    _cardCell.placeholder = @"请输入身份证号码";
    
    _notifyCell =  [TCell_Notify tcell:self.tableView reuse:YES];
    _notifyCell.title = @"通知";
    _notifyCell.showIndicator = NO;
    _notifyCell.isNotifyOpened = NO;
    [_notifyCell addSwitchTarget:self selector:@selector(switchEvent:)];
    
    _networkCell = [TCell_Notify tcell:self.tableView reuse:YES];
    _networkCell.title = @"WIFI";
    _networkCell.showIndicator = NO;
    _networkCell.isNotifyOpened = YES;
    [_networkCell addSwitchTarget:self selector:@selector(switchEvent:)];
    
    _emptyCell = [TCell_Label tcell:self.tableView reuse:YES];
    _emptyCell.title = @"空页面";
    _emptyCell.value = @"测试空页面";
    _emptyCell.click = ^(NSIndexPath *indexPath, BaseTCell *cell) {
        [weakSelf gotoEmptyVC];
    };
    
    self.cells = @[@[_cellUser],@[_cellAbout,_cellVersion],@[_cellNews,_cellMessages],@[_notifyCell,_networkCell],@[_nameCell,_cardCell],@[_emptyCell]];
}

#pragma mark - 新闻
- (void)gotoNewsVC {
    NewsVC *vc = [[NewsVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 消息
- (void)gotoMessageVC {
    MessageVC *vc = [[MessageVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 空页面
- (void)gotoEmptyVC {
    EmptyVC *vc = [[EmptyVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Switch 事件
- (void)switchEvent:(UISwitch *)aSwitch {
    if (aSwitch.isOn) {
        [self showInfoMessage:@"打开开关"];
    }
    else {
        [self showInfoMessage:@"关闭开关"];
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
