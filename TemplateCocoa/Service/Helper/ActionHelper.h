//
//  ActionHelper.h
//  CureFunNew
//
//  Created by yuwenhua on 2017/3/28.
//  Copyright © 2017年 TLQ. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>


typedef void(^DismissAction)(NSInteger buttonIndex);

@interface ActionHelper : NSObject

/**
 *  自定义 AlertView
 *
 *  @param title          标题
 *  @param message        内容
 *  @param actions        操作
 *  @param vc             呈现的控制器
 *  @param clickItemBlock 回调
 */
+ (void)showAlertTitle:(NSString *)title
          message:(NSString *)message
           actions:(NSArray *)actions
               vc:(UIViewController *)vc
            block:(DismissAction)clickItemBlock;

/**
 *  自定义 SheetView
 *
 *  @param title          标题
 *  @param actions        操作
 *  @param vc             呈现的控制器
 *  @param clickItemBlock 回调
 */
+ (void)showSheetTitle:(NSString *)title
               actions:(NSArray *)actions
                    vc:(UIViewController *)vc
                 block:(DismissAction)clickItemBlock;



@end
