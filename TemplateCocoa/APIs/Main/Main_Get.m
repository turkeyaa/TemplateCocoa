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
    
    if (self = [super initWithURL:[BaseRestApi getRestApiURL:@"curefun/main/user"] httpMethods:HttpMethods_Get]) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)parseResponseJson:(NSDictionary *)json {
    NSArray *array = json[@"data"];
    if (array) {
        
        for (NSDictionary *dict in array) {
            /** JSON转化成model
             * 可以使用YYModel、MJExtension... 等库.
             * 目前使用基类JSONModel中的初始化方法即可实现自动转化
             */
            
//            MainInfo *info = [MainInfo yy_modelWithDictionary:dict];
            
            MainInfo *info = [MainInfo jsonModelWithDictionary:dict];
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
