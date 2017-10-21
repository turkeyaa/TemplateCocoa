//
//  BaseView.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView

/* Subclass - 需要子类重写 */
- (void)setupUI;
- (void)setupLayout;

@end
