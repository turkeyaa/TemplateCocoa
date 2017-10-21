//
//  RestApi.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "RestApi.h"

#import "AFNetworking.h"

static NSTimeInterval kNetworkTimeout = 10;

@interface RestApi ()

{
    NSString *_url;
    HttpMethods _httpMethod;
    
    BOOL _isCancel;
}

@property (nonatomic, strong) NSURLSessionDataTask *task;

@end

@implementation RestApi

- (id)initWithURL:(NSString *)url httpMethods:(HttpMethods)httpMethod {
    if (self = [super init]) {
        _url = url;
        _httpMethod = httpMethod;
        
        _isCancel = NO;
    }
    return self;
}

- (void)dealloc {
    [self cancel];
}

- (void)raiseException:(NSString *)exception {
    [NSException raise:exception format:@"Exception"];
}

- (void)call {
    [self callWithTimeout:kNetworkTimeout];
}

- (void)callWithTimeout:(NSTimeInterval)timeout {
    [self callWithTimeout:timeout async:nil];
}

- (void)callWithAsync:(BlockJsonData)result {
    [self callWithTimeout:kNetworkTimeout async:result];
}

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
            
//            [weakSelf doHttpResonse:response error:error block:^(id data) {
//                block(data);
//            }];
            
            id obj = [self doHttpResonse:response error:error];
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
                
                [weakSelf doFailure:error];
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

- (void)cancel {
    if (!_isCancel) {
        
        [_task cancel];
        _isCancel = YES;
    }
}
- (void)setRequestHeader:(NSMutableURLRequest *)request {}

- (NSString*)getHttpMethod {
    switch (_httpMethod) {
        case HttpMethods_Get:
            return @"GET";
        case HttpMethods_Post:
            return @"POST";
        case HttpMethods_Put:
            return @"PUT";
        case HttpMethods_Delete:
            return @"DELETE";
        default:
            return nil;
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

- (void)onSuccessed {
    
    // TODO:成功日志
}

- (void)onFailed {
    // TODO:失败日志
}
- (void)onCancelled {
    // TODO:取消日志
}
- (void)onTimeout {
    // TODO: 超时日志
}
- (void)onError:(NSError *)error {
    // TODO: 错误日志
}

- (NSData *)queryPostData { return nil; }
- (NSDictionary *)queryGetParameters { return nil; }



@end
