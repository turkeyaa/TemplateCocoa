//
//  TCell_Image.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/10/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BaseTCell.h"

@interface TCell_Image : BaseTCell

@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *value;

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *valueColor;

@property (nonatomic, strong) UIColor *bgColor;

/* 消息提示（红点） */
@property (nonatomic, assign) BOOL hasMsg;

@end
