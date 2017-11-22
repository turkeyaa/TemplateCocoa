//
//  SegmentedView.h
//  Refrence
//
//  Created by mac on 15/8/15.
//  Copyright (c) 2015年 ds. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SegmentedViewDelegate <NSObject>

- (void)clickSegmentedViewWithIndex:(NSInteger)index;

@end

@interface SegmentedView : UIView

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, assign) BOOL isMyDiscuss;

@property (nonatomic, assign) NSInteger showRedView;

@property (nonatomic, strong) NSArray *btnTitles;

@property (nonatomic, assign) id<SegmentedViewDelegate>delegate;

@end



