//
//  Main_Get.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/5/31.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BaseRestApi.h"

@interface Main_Get : BaseRestApi

@property (nonatomic, strong) NSMutableArray *dataSource;

- (id)init;
- (id)initWithPageNum:(NSInteger)pageNum
             pageSize:(NSInteger)pageSize;

@end
