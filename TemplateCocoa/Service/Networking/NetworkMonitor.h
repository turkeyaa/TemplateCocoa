//
//  NetworkMonitor.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/6/7.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NetworkState) {
    NetworkState_Unknown = -1,      // 未知网络
    NetworkState_Not = 0,           // 无网络
    NetworkState_WWAN = 1,          // 默认
    NetworkState_WIFI = 2,          // WIFI
};

@interface NetworkMonitor : NSObject


- (void)startMonitoring;

- (void)stopMonitoring;

@property (nonatomic, readonly) NetworkState state;

@end
