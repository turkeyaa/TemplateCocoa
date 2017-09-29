//
//  BaseFormTC.h
//  TemplateCocoa
//
//  Created by yuwenhua on 17/9/27.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BaseTC.h"

@interface BaseFormTC : BaseTC

@property (nonatomic, strong) NSArray *cells;

- (void)readDataFromUI;
- (BOOL)valueChanged;
- (BOOL)invalidateInput:(NSString**)error;
- (void)submit;
- (void)cancel;

@end
