//
//  UserModel.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (id)mutableCopyWithZone:(NSZone *)zone {
    // subclass implementation should do a deep mutable copy
    // this class doesn't have any ivars so this is ok
//    JSONModel *newModel = [[JSONModel allocWithZone:zone] init];
//    return newModel;
    
    UserModel *info = [[UserModel allocWithZone:zone] init];
    info.user_id = _user_id;
    return info;
}

- (id)copyWithZone:(NSZone *)zone {
    // subclass implementation should do a deep mutable copy
    // this class doesn't have any ivars so this is ok
    UserModel *info = [[UserModel allocWithZone:zone] init];
    return info;
}

@end
