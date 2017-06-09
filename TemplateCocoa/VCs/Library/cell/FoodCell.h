//
//  FoodCell.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/6.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BaseTCell.h"

#import "FoodInfo.h"

@interface FoodCell : BaseTCell
    
@property (nonatomic, strong) FoodInfo *foodInfo;

@property (nonatomic, readonly) UIImage *cartImage;


// 收藏
@property (nonatomic, copy) BlockResult clickCollectBlock;
// 操作 +、-
@property (nonatomic, copy) BlockItem clickReduceBlock;
@property (nonatomic, copy) BlockItem clickAddBlock;


@end
