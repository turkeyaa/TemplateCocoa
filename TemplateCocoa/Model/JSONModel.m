//
//  JSONModel.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "JSONModel.h"

#import "NSObject+Property.h"

@implementation JSONModel

- (id)initWithDictionary:(NSDictionary *)jsonDict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:jsonDict];
    }
    return self;
}

#pragma mark -
#pragma mark - NSCoding协议:解码
- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        
        NSArray *properNames = [self getPropertyList];
        
        for (NSString *key in properNames) {
            
            id varValue = [aDecoder decodeObjectForKey:key];
            if (varValue) {
                [self setValue:varValue forKey:key];
            }
        }
    }
    return self;
}
#pragma mark -
#pragma mark - NSCoding协议:编码
- (void)encodeWithCoder:(NSCoder *)aCoder {
    NSArray *properNames = [self getPropertyList];
    for (NSString *key in properNames) {
        
        id varValue = [self valueForKey:key];
        if (varValue)
        {
            [aCoder encodeObject:varValue forKey:key];
        }
    }
}

#pragma mark -
#pragma mark - NSCopying协议
- (id)mutableCopyWithZone:(NSZone *)zone {
    // subclass implementation should do a deep mutable copy
    // this class doesn't have any ivars so this is ok
    JSONModel *newModel = [[JSONModel allocWithZone:zone] init];
    return newModel;
}

- (id)copyWithZone:(NSZone *)zone {
    // subclass implementation should do a deep mutable copy
    // this class doesn't have any ivars so this is ok
    JSONModel *newModel = [[JSONModel allocWithZone:zone] init];
    return newModel;
}

#pragma mark -
#pragma mark - UndefinedKey
- (id)valueForUndefinedKey:(NSString *)key {
    NSLog(@"Undefined key:%@",key);
    return nil;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    // subclass implementation should set the correct key value mappings for custom keys
    NSLog(@"Undefined key:%@",key);
}

@end
