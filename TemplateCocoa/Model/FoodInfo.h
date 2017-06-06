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
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *partner_price;
@property (nonatomic, copy) NSString *img;

@end


@interface FoodType : JSONModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray *foodInfos;

@end
