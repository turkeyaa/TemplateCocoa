//
//  BaseRestApi.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "RestApi.h"


typedef NS_ENUM(NSInteger, RestApiCode) {
    RestApi_OK = 0,                     // 成功
    RestApi_NoUserId = 0001,            // 无用户ID信息 （请登录）
    RestApi_UnkownError = 0002,         // 未知错误（系统出错）
    
    RestApi_InvalidJSON = 108,          // 解析 JSON 异常
};

typedef NS_ENUM(NSInteger, MockType) {
    MockNone,
    MockFile,
};

@interface BaseRestApi : RestApi

+ (NSString *)getRestApiURL:(NSString *)relativeURL;

@property (nonatomic, assign) RestApiCode code;     // 状态码
@property (nonatomic, copy) NSString *message;      // 状态提示
@property (nonatomic, copy) NSString *errorMessage; // 错误提示

/* 数据源 */
@property (nonatomic, strong) NSMutableArray *dataSource;

#pragma mark - Subclassing methods
- (BOOL)parseResponseJson:(NSDictionary *)json;
- (id)queryObjData;

/* 参数，字典类型：POST方法请求数据 */
- (id)prepareRequestData;

#pragma mark - Mock
- (MockType)mockType;
- (NSString *)mockFile;

@end
