//
//  BSTCellLabel.h
//  HealthCloud
//
//  Created by yuwenhua on 2017/10/31.
//  Copyright © 2017年 www.bsoft.com. All rights reserved.
//

#import "BaseTCell.h"

@interface TCell_Label : BaseTCell

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *value;

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *valueColor;

@end
