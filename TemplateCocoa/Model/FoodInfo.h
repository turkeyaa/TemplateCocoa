//
//  FoodInfo.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/6.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "JSONModel.h"

@interface FoodInfo : JSONModel

@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger store_nums; // 剩余数量
@property (nonatomic, copy) NSString *specifics;    // 规格
@property (nonatomic, copy) NSString *brand_name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *partner_price;
@property (nonatomic, copy) NSString *img;

/* 扩展属性 */
// 购买数量
@property (nonatomic, assign) NSInteger buy_numbers;
// 是否收藏
@property (nonatomic, assign) BOOL collected;

@end


@interface FoodType : JSONModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *foodInfos;

@end
