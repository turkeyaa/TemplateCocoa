//
//  BaseTC.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "BaseVC.h"

@interface BaseTC : BaseVC <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end
