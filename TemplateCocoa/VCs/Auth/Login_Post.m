//
//  Login_Post.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/1/19.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "Login_Post.h"

#import "URLUtil.h"

@interface Login_Post ()

{
    NSString *_account;
    NSString *_password;
}

@end

@implementation Login_Post

- (id)initWithAccount:(NSString *)account
             password:(NSString *)password {
    
    if (self = [super initWithURL:[BaseRestApi getRestApiURL:@"curefun/curefun/user/login"] httpMethods:HttpMethods_Get]) {
        
        _account = account;
        _password = password;
    }
    return self;
}

- (id)prepareRequestData {
    return @{
             @"user_account":_account,
             @"user_pwd":[URLUtil base64Encode:_password],
             @"manage_k":@"android"
             };
}

- (BOOL)parseResponseJson:(NSDictionary *)json {
    
    return YES;
}

@end
