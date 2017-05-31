//
//  MainInfo.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/5/31.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "JSONModel.h"

@interface MainInfo : JSONModel

@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *name_spell;
@property (nonatomic, copy) NSString *avatar_url;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *userid;

@end
