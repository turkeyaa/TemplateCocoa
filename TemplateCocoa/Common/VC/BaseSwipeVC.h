//
//  BaseSwipeVC.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/10/21.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BaseVC.h"

@interface BaseSwipeVC : BaseVC

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *vcs;

@property (nonatomic, assign, readonly) NSInteger selectIndex;

@end
