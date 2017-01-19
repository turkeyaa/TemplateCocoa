//
//  Login_Post.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/1/19.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BaseRestApi.h"

@interface Login_Post : BaseRestApi

- (id)initWithAccount:(NSString *)account
             password:(NSString *)password;

@end
