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

// TODO: form表单格式上传文件
//- (id)initWithURL:(NSString *)url formData:

- (void)call;
- (void)callWithTimeout:(CGFloat)timeout;

- (void)cancel;

- (void)setRequestHeader:(NSMutableURLRequest *)request;

- (void)doSuccess:(id)responseObject;

- (NSData *)queryPostData;
- (NSDictionary *)queryGetParameters;

- (void)onSuccessed;
- (void)onFailed;
- (void)onCancelled;
- (void)onTimeout;
- (void)onError:(NSError *)error;

@end
