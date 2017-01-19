//
//  DSTabbarView.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/1/17.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DSTabItemView.h"

@protocol DSTabbarDelegate, DSTabbarDataSource;


@interface DSTabbarView : UIView

@property (nonatomic, weak) id<DSTabbarDelegate> delegate;
@property (nonatomic, weak) id<DSTabbarDataSource> dataSource;

@property (nonatomic, strong, readonly) NSArray *items;

@property (nonatomic, assign) NSInteger selectedIndex;

- (void)setupViews;

@end

@protocol DSTabbarDataSource <NSObject>

- (NSUInteger)numberOfItemsInTabbar:(DSTabbarView *)tabbar;
- (DSTabItemModel *)tabbar:(DSTabbarView *)tabbar itemModelAtIndex:(NSUInteger)index;

@end

@protocol DSTabbarDelegate <NSObject>

- (void)tabbar:(DSTabbarView *)tabbar clickAtIndex:(NSUInteger)index;
- (BOOL)tabbar:(DSTabbarView*)tabbar canSelectedAtIndex:(NSUInteger)index;

@end
