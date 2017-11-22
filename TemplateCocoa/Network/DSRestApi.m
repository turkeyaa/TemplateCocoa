//
//  DSRestApi.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/10/30.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSRestApi.h"

@interface DSRestApi ()

{
    NSString *_url;
    HttpMethods _httpMethod;
    
    BOOL _isCancel;
}

@property (nonatomic, strong) NSURLSessionDataTask *task;

@end

@implementation DSRestApi

#pragma mark - 初始化方法
- (void)callWithTimeout:(NSTimeInterval)timeout
                  async:(BlockJsonData)block {
    
    if ([NSThread isMainThread]) {
        [self raiseException:@"主线程不允许同步调用"];
        return;
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    if (_httpMethod == HttpMethods_Get) {
        
        NSMutableString *strUrl = [[NSMutableString alloc] initWithString:_url];
        
        @try {
            NSDictionary *params = [self queryGetParameters];
            if (params) {
                
                // Get 参数
                NSArray *keys = params.allKeys;
                
                for (int i = 0; i< keys.count; i++) {
                    NSString* key = [keys objectAtIndex:i];
                    NSString* value = [params valueForKey:key];
                    
                    if (i == 0) {
                        [strUrl appendString:@"?"];
                    } else {
                        [strUrl appendString:@"&"];
                    }
                    [strUrl appendString:key];
                    [strUrl appendString:@"="];
                    [strUrl appendString:[NSString stringWithFormat:@"%@", value]];
                }
            }
            
            [request setURL:[NSURL URLWithString:strUrl]];
            [request setHTTPMethod:@"GET"];
            [request setTimeoutInterval:timeout];
            
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
    
    else if (_httpMethod == HttpMethods_Post) {
        [request setURL:[NSURL URLWithString:_url]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSData *postData = [self queryPostData];
        [request setHTTPBody:postData];
    }
    else {
        NSAssert(NO, @"目前只支持 GET、POST 请求方式");
    }
    
    NSLog(@"url = %@",_url);
    
    __weak RestApi *weakSelf = self;
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    if (block) {
        _task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            id obj = [weakSelf doHttpResonse:response error:error];
            dispatch_async(dispatch_get_main_queue(), ^{
                block(obj);
            });
        }];
        
        [_task resume];
    }
    else {
        NSCondition *condition = [[NSCondition alloc] init];
        _task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error) {
                
//                [weakSelf doFailure:error];
            }
            else {
                [weakSelf doSuccess:data];
            }
            
            [condition lock];
            [condition signal];
            [condition unlock];
        }];
        
        [_task resume];
        
        if (condition) {
            [condition lock];
            [condition wait];
            [condition unlock];
        }
    }
}

- (void)doFailure:(NSError *)error {
    
    if ([error.domain isEqualToString:NSURLErrorDomain] && error.code == NSURLErrorCancelled) {
        // 取消
        [self onCancelled];
    } else if ([error.domain isEqualToString:NSURLErrorDomain] && error.code == NSURLErrorTimedOut) {
        // 超时
        [self onTimeout];
    } else {
        // 其他错误
        [self onError:error];
    }
}

- (void)doSuccess:(id)responseObject {
    
    [self onSuccessed];
}

@end
