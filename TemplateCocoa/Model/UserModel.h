//
//  UserModel.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "JSONModel.h"

@interface UserModel : JSONModel

/* 账号 */
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *password;

/* 用户信息 */
@property (nonatomic, copy) NSString *user_id;

@property (nonatomic, copy) NSString *user_name;

@property (nonatomic, copy) NSString *org_name;

@property (nonatomic, copy) NSString *user_icon;

@property (nonatomic, copy) NSString *org_id;

@property (nonatomic, copy) NSString *invitation;

@property (nonatomic, strong) NSArray *role_id_list;

@end
