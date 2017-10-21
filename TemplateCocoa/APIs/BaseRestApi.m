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
        return jsondata;
    }
    if ([requestData isKindOfClass:NSArray.class]) {
        
        NSMutableArray *array = [NSMutableArray arrayWithArray:requestData];
        NSData *jsondata = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
        return jsondata;
    }
    if ([requestData isKindOfClass:NSString.class]) {
        return [((NSString*)requestData) dataUsingEncoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (void)callWithTimeout:(NSTimeInterval)timeout
                  async:(BlockJsonData)block {
    if ([NSThread isMainThread]) {
        [self raiseException:@"主线程不允许同步调用"];
        return;
    }
    
    if ([self mockType] == MockNone) {
        [super callWithTimeout:timeout async:block];
    }
    else {
        /*
         * 模拟本地登录, 从本地 .json 文件中读取数据
         */
        __weak BaseRestApi *weakSelf = self;
        
        __block void(^ simulateBlock)() = ^{
            
            NSData *responseData = nil;
            
            NSString *mockFile = [self mockFile];
            if (mockFile) {
                NSString *filePath = [[NSBundle mainBundle] pathForResource:mockFile ofType:@"json"];
                responseData = [NSData dataWithContentsOfFile:filePath];
            }
            
            if (responseData == nil) {
                [weakSelf raiseException:@"应答数据不能为nil, responseData==nil"];
            }
            
            id obj = [self doHttpResonse:responseData error:nil];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                block(obj);
            });
        };
        
        simulateBlock();
    }
}

- (void)doSuccess:(id)responseObject {
    NSLog(@"RestApi :[%@]",self.class);
    NSLog(@"RestApi Response:[%@]",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    
    @try {
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        self.code = [json[@"status"] integerValue];
        self.message = json[@"message"];
        
        if (self.code == RestApi_OK && [self parseResponseJson:json]) {
            [self onSuccessed];
        }
        else {
            if (self.code == RestApi_OK) {
                
                [self onSuccessed];
            }
            else {
                [self onFailed];
            }
        }
        
    } @catch (NSException *exception) {
        [self onError:nil];
    } @finally {
        
    }
}

- (id)doHttpResonse:(id)responseObject
              error:(NSError *)error {
    [self doSuccess:responseObject];
    if (self.code == RestApi_OK) {
        return [self queryObjData];
    }
    return nil;
}

- (id)queryObjData {
    NSAssert(NO, @"子类必须重写该方法");
    return nil;
}

- (NSDictionary *)errorCodeMessage {
    return @{
             [NSString stringWithFormat:@"%@",@(RestApi_NoUserId)]:@"无用户ID信息,请先登录",
             [NSString stringWithFormat:@"%@",@(RestApi_UnkownError)]:@"系统错误"
             };
}

- (void)onSuccessed {
    [super onSuccessed];
}

- (void)onFailed {
    [super onFailed];
}

- (void)onTimeout {
    [super onTimeout];
}
- (void)onCancelled {
    [super onCancelled];
}
- (void)onError:(NSError *)error {
    
    self.code = RestApi_UnkownError;
    [super onError:error];
}

- (MockType)mockType {
    return MockNone;
}
- (NSString *)mockFile {
    return @"login";
}


@end
