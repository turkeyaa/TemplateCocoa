//
//  Foods_Get.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/6.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "Foods_Get.h"

#import "FoodInfo.h"

@implementation Foods_Get
    
- (id)init {
    if (self = [super initWithURL:@"food/list" httpMethods:HttpMethods_Get]) {
        self.dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)parseResponseJson:(NSDictionary *)json {
    NSArray *data = json[@"data"];
    if (data) {
        for (NSDictionary *dict in data) {
            
            FoodType *type = [FoodType yy_modelWithDictionary:dict];
            type.foodInfos = [[NSMutableArray alloc] init];
            
            NSArray *foods = dict[@"goods"];
            for (NSDictionary *foodDict in foods) {
                FoodInfo *info = [FoodInfo yy_modelWithDictionary:foodDict];
                [type.foodInfos addObject:info];
            }
            
            [self.dataSource addObject:type];
        }
    }
    return self.dataSource && self.dataSource.count > 0;
}

- (id)queryObjData {
    return self.dataSource;
}

- (MockType)mockType {
    return MockFile;
}
- (NSString *)mockFile {
    return @"foods";
}

@end
