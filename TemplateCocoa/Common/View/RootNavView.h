//
//  TLQRootNavView.h
//  Template
//
//  Created by yuwenhua on 16/9/21.
//  Copyright © 2016年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootNavView : UIView

@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, copy) NSArray *titlesArray;

@property (nonatomic, copy) void (^clickItemBlock)(NSInteger index);

@end
