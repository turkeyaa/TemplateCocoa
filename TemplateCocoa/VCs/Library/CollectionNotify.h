//
//  CollectionNotify.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/8.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionNotify : NSObject

+ (instancetype)sharedInstance;

#pragma mark - collection
- (void)addCollectionObserver:(id)target selector:(SEL)selector;
- (void)removeCollectionObserver:(id)target;
- (void)postCollectionNotify;

#pragma mark - cancel collection
- (void)addCancelCollectionObserver:(id)target selector:(SEL)selector;
- (void)removeCancelCollectionObserver:(id)target selector:(SEL)selector;
- (void)postCancelCollectionNotify;

@end
