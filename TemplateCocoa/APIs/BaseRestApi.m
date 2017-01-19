//
//  BaseRestApi.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "BaseRestApi.h"

#import "URLHelper.h"

@interface BaseRestApi ()


@end

@implementation BaseRestApi

+ (NSString *)getRestApiURL:(NSString *)relativeURL {
    return [[URLHelper getInstance] restApiURL:relativeURL];
}

- (NSData *)queryPostData {
    id requestData = [self prepareRequestData];
    
    if ([requestData isKindOfClass:NSData.class]) {
        return requestData;
    }
    if ([requestData isKindOfClass:NSDictionary.class]) {
        NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithDictionary:requestData];
        NSData * jsondata=[NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
//        _requestIsJson = YES;
        return jsondata;
    }
    if ([requestData isKindOfClass:NSArray.class]) {
        
//        _requestIsJson = YES;
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:requestData];
        NSData *jsondata = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
        return jsondata;
    }
    if ([requestData isKindOfClass:NSString.class]) {
        return [((NSString*)requestData) dataUsingEncoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (void)doSuccess:(id)responseObject {
    NSLog(@"RestApi :[%@]",self.class);
    NSLog(@"RestApi Response:[%@]",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    
    
}


- (MockType)mockType {
    return MockNone;
}
- (NSString *)mockFile {
    return @"";
}


@end
