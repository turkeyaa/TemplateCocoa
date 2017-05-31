//
//  NSString+Utils.h
//  shopbaby
//
//  Created by mac on 14-12-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utils)

+ (NSString*)guid;

+ (BOOL)isEmpty:(NSString*)string;

- (NSString*)md5;

- (NSString*)trimLeft;

- (NSString*)trimRight;

- (NSInteger)indexOf:(NSString*)string;

- (BOOL)startWithString:(NSString*)string;

@end
