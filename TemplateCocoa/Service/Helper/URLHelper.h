//
//  URLHelper.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/1/19.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLHelper : NSObject

+ (instancetype)getInstance;

- (NSString *)restApiURL:(NSString *)relativeURL;

- (NSString *)imageURl;

@end
