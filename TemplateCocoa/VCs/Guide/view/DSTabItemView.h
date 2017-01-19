//
//  DSTabItemView.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/1/17.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DSTabItemModel.h"

@interface DSTabItemView : UIView

/**
 *  消息个数 - TODO: 暂未完成
 */
@property (nonatomic, assign) NSInteger badgeNumber;

@property (nonatomic, assign) BOOL selected;

/**
 *  自定义标签栏条目视图
 *
 *  @param model DSTabItemModel 对象
 *
 *  @return 视图对象
 */
- (id)initWithModel:(DSTabItemModel *)model;

@end



