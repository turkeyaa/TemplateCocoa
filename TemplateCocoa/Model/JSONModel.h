//
//  JSONModel.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * JSONModel 基类
 * 支持JSON自动转化为Model模型
 * 支持自动化编码和解码
 */


@interface JSONModel : NSObject <NSCopying,NSCoding,NSMutableCopying>


+ (id)jsonModelWithDictionary:(NSDictionary *)jsonDict;
+ (NSDictionary *)jsonModelWithModel:(JSONModel *)model;

@end
