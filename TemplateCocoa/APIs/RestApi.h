//
//  RestApi.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HttpMethods) {
    HttpMethods_Get = 1,
    HttpMethods_Post = 2,
    HttpMethods_Delete = 3,
    HttpMethods_Put = 4,
};

@interface RestApi : NSObject

/**
 *  接口请求
 *
 *  @param url        接口url
 *  @param httpMethod 请求方式
 *
 *  @return RestApi 实例对象
 */
- (id)initWithURL:(NSString *)url httpMethods:(HttpMethods)httpMethod;

- (void)call;
//- (void)callWithTimeout:(NSTimeInterval)timeout;
- (void)callWithAsync:(BlockJsonData)result;

/**
 *  异步执行
 *  @param timeout     请求超时时间
 *  @param block       回调(模型对象、数组对象)
 */
- (void)callWithTimeout:(NSTimeInterval)timeout
                  async:(BlockJsonData)block;

/* 取消 */
- (void)cancel;

/* 设置header */
- (void)setRequestHeader:(NSMutableURLRequest *)request;

/* 成功回调-同步 */
- (void)doSuccess:(id)responseObject;
/* 成功回调-异步 */
- (id)doHttpResonse:(id)responseObject
                error:(NSError *)error;
- (void)doHttpResonse:(id)responseObject
              error:(NSError *)error
              block:(BlockJsonData)result;

- (void)raiseException:(NSString*)exception;

/* POST方式参数 */
- (NSData *)queryPostData;
/* GET方式参数 */
- (NSDictionary *)queryGetParameters;

- (void)onSuccessed;
- (void)onFailed;
- (void)onCancelled;
- (void)onTimeout;
- (void)onError:(NSError *)error;

@end
