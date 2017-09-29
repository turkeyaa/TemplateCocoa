//
//  BaseFormTC.m
//  TemplateCocoa
//
//  Created by yuwenhua on 17/9/27.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BaseFormTC.h"

#import "BaseTCell.h"

#import "TPKeyboardAvoidingTableView.h"
#import "XCDFormInputAccessoryView.h"

@interface BaseFormTC ()

{
    XCDFormInputAccessoryView *_inputAccessoryView;
}

@end

@implementation BaseFormTC

- (void)setCells:(NSArray *)cells {
    _cells = cells;
    
    self.dataSource= [cells mutableCopy];
    [self.tableView reloadData];
}

- (UITableView *)createTableView {
    TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    return tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTCell *cell = self.cells[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BaseTCell *cell = self.cells[indexPath.row];
    if (cell.click) {
        cell.click(indexPath,cell);
    }
}

- (UIView *)inputAccessoryView {
    if (!_inputAccessoryView) {
        _inputAccessoryView = [[XCDFormInputAccessoryView alloc] init];
    }
    return _inputAccessoryView;
}

- (void)readDataFromUI {
    
}
- (BOOL)valueChanged {
    return YES;
}
- (BOOL)invalidateInput:(NSString *__autoreleasing *)error {
    return YES;
}
- (void)cancel {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)submit{
    
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
