//
//  RestApi.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "RestApi.h"

#import "AFNetworking.h"

@interface RestApi ()

{
    NSString *_url;
    HttpMethods _httpMethod;
    AFHTTPSessionManager *_manager;
    
    BOOL _isCancel;
}

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

- (void)call {
    [self callWithTimeout:10.0];
}

- (void)callWithTimeout:(CGFloat)timeout {
    
    if ([NSThread isMainThread]) {
        NSAssert(NO, @"主线程不允许同步调用");
        return;
    }
    
    // TODO:
    
    
}

- (void)cancel {
    if (!_isCancel) {
        
        // TODO
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
