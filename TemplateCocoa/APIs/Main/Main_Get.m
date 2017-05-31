//
//  Main_Get.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/5/31.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "Main_Get.h"

#import "MainInfo.h"

@implementation Main_Get

- (id)init {
    return [self initWithPageNum:1 pageSize:100];
}
- (id)initWithPageNum:(NSInteger)pageNum
             pageSize:(NSInteger)pageSize {
    if (self = [super init]) {
        
        _dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)parseResponseJson:(NSDictionary *)json {
    NSArray *array = json[@"data"];
    if (array) {
        
        for (NSDictionary *dict in array) {
            MainInfo *info = [MainInfo yy_modelWithDictionary:dict];
            [self.dataSource addObject:info];
        }
    }
    return self.dataSource && self.dataSource.count;
}

- (MockType)mockType {
    return MockFile;
}
- (NSString *)mockFile {
    return @"main";
}




@end
