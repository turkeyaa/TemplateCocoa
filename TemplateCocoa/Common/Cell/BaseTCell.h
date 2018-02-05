//
//  BaseTCell.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseTCell;

typedef void(^ClickEventBlock)(NSIndexPath *indexPath, BaseTCell *cell);

@interface BaseTCell : UITableViewCell

+ (CGFloat)classCellHeight;

+ (instancetype)tcell:(UITableView *)tableView reuse:(BOOL)reuse;

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign) BOOL showIndicator;
@property (nonatomic, strong) ClickEventBlock click;

- (CGFloat)height;

- (void)setupUI;

- (void)scrollToActiveTextField;

#pragma mark - Subclass
- (void)setupSubViews;
- (void)setupLayout;

@end
