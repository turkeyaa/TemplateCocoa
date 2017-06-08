//
//  CollectionNotify.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/8.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CollectionNotify.h"

static NSString * kNotifyCollection = @"kNotifyCollection";
static NSString * kNotifyCancelCollection = @"kNotifyCollection";

@interface CollectionNotify ()

@property NSNotificationCenter* center;

@end

@implementation CollectionNotify

+ (instancetype)sharedInstance {
    static CollectionNotify *_instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[CollectionNotify alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _center = [NSNotificationCenter defaultCenter];
    }
    return self;
}

#pragma mark - collection
- (void)addCollectionObserver:(id)target selector:(SEL)selector {
    [_center addObserver:target selector:selector name:kNotifyCollection object:nil];
}
- (void)removeCollectionObserver:(id)target {
    [_center removeObserver:target name:kNotifyCollection object:nil];
}
- (void)postCollectionNotify {
    [_center postNotificationName:kNotifyCollection object:nil];
}

#pragma mark - cancel collection
- (void)addCancelCollectionObserver:(id)target selector:(SEL)selector {
    [_center addObserver:target selector:selector name:kNotifyCancelCollection object:nil];
}
- (void)removeCancelCollectionObserver:(id)target selector:(SEL)selector {
    [_center removeObserver:target name:kNotifyCancelCollection object:nil];
}
- (void)postCancelCollectionNotify {
    [_center postNotificationName:kNotifyCancelCollection object:nil];
}

@end
