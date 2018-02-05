//
//  EmptyView.h
//  HealthCloud
//
//  Created by yuwenhua on 2017/10/30.
//  Copyright © 2017年 www.bsoft.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EmptyType) {
    EmptyType_Full,         // 全屏
    EmptyType_NoNav,        // 导航栏以下
    EmptyType_NoTab,        // 标签栏以上
    EmptyType_NoNavAndTab,  // 导航栏和标签栏之间
};

@interface EmptyView : UIView

/** 空页面图片 */
@property (nonatomic, strong) UIImage *emptyImage;
/** 空页面提示：可选，默认为空 */
@property (nonatomic, copy) NSString *emptyTitle;
/** 空页面提示：可选，默认为空 */
@property (nonatomic, copy) NSString *emptySecondTitle;
/** 空页面尺寸:推荐方法 */
@property (nonatomic, assign) EmptyType emptyType;

/** 空页面尺寸(自定义大小：以window为父视图) */
- (void)updateEmptyViewFrame:(CGRect)newFrame;



@end
