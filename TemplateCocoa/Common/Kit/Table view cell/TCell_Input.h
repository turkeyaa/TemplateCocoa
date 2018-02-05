//
//  BSTCellInput.h
//  HealthCloud
//
//  Created by yuwenhua on 2017/10/31.
//  Copyright © 2017年 www.bsoft.com. All rights reserved.
//

#import "BaseTCell.h"

@interface TCell_Input : BaseTCell

/** 图片 */
@property (nonatomic, strong) UIImage *icon;
/** 标题 */
@property (nonatomic, strong) NSString *title;
/** 标题颜色 */
@property (nonatomic, strong) UIColor *titleColor;
/** 输入框文本 */
@property (nonatomic, strong) NSString *text;
/** 输入框占位符 */
@property (nonatomic, strong) NSString *placeholder;

/** 支持可输入的最大长度，默认为11 */
@property (nonatomic, assign) NSInteger limitMaxLength;

/** 输入框类型：字符 */
+ (instancetype)stringInputCell;
/** 输入框类型：数字 */
+ (instancetype)numberInputCell;
/** 输入框类型：密码 */
+ (instancetype)passwordInputCell;


@end
