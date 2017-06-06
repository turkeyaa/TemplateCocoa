//
//  Activity_Get.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/6.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "Activity_Get.h"
#import "ActivityInfo.h"

@implementation Activity_Get
    
    - (id)init {
        if (self = [super initWithURL:@"food/activity" httpMethods:HttpMethods_Get]) {
            
            self.dataSource = [[NSMutableArray alloc] init];
        }
        return self;
    }
    
    - (BOOL)parseResponseJson:(NSDictionary *)json {
        NSArray *data = json[@"data"];
        if (data) {
            for (NSDictionary *dict in data) {
                ActivityInfo *info = [ActivityInfo yy_modelWithDictionary:dict];
                [self.dataSource addObject:info];
            }
        }
        return self.dataSource && self.dataSource.count > 0;
    }
    
    - (MockType)mockType {
        return MockFile;
    }
    - (NSString *)mockFile {
        return @"activity";
    }

@end
