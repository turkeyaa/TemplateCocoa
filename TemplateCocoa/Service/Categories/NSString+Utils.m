//
//  NSString+Utils.m
//  shopbaby
//
//  Created by mac on 14-12-17.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "NSString+Utils.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>


@implementation NSString (Utils)

+ (NSString*)guid
{
    CFUUIDRef uuid_ref=CFUUIDCreate(nil);
    CFStringRef uuid_string_ref=CFUUIDCreateString(nil, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid=[NSString stringWithString:(__bridge NSString *)(uuid_string_ref)];
    CFRelease(uuid_string_ref);
    return uuid;
}

+ (BOOL)isEmpty:(NSString*)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

- (NSString*)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr,(int)strlen(cStr),result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0],result[1],result[2],result[3],
             result[4],result[5],result[6],result[7],
             result[8],result[9],result[10],result[11],
             result[12],result[13],result[14],result[15]
             ] lowercaseString];
}

- (NSString*)trimLeft
{
    NSUInteger i=0;
    for (;i<self.length;i++) {
        if ([self characterAtIndex:i] != ' ') {
            break;
        }
    }
    
    return [self stringByReplacingCharactersInRange:NSMakeRange(0, i) withString:@""];
}

- (NSString*)trimRight
{
    int i = (int)self.length-1;
    for (;i >= 0;i--) {
        if ([self characterAtIndex:i] != ' ') {
            break;
        }
    }
    
    if (i == self.length-1)
        return self;
    
    i++;
    
    return [self stringByReplacingCharactersInRange:NSMakeRange(i, self.length-i) withString:@""];
}

- (NSInteger)indexOf:(NSString*)string
{
    NSRange range = [self rangeOfString:string];
    if (range.length > 0) {
        return range.location;
    }
    return -1;
}

- (BOOL)startWithString:(NSString*)string
{
    if (self.length < string.length) {
        return NO;
    }
    
    return [[self substringToIndex:string.length] isEqualToString:string];
}

@end
