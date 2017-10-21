//
//  BaseLoadTC.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import "BaseTC.h"

/**
 * 实现以下功能
 * 1. 下拉刷新、上拉加载更多功能，(可以在子类中删除上拉或者下拉视图)
 * 2. 网络不好提示
 * 3. 空数据提示 (提供默认实现，可由子类重写)
 */

@interface BaseLoadTC : BaseTC

/* 子类重载该的方法 */
- (NSMutableArray *)loadDataPageNum:(NSInteger)pageNum
                    pageSize:(NSInteger)pageSize;

@end
