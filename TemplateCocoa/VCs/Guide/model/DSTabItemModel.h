//
//  DSTabItemModel.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/1/17.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSTabItemModel : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *imageName;
@property (nonatomic, copy, readonly) NSString *selectedImageName;

/**
 *  自定义标签栏条目模型
 *
 *  @param title             标题
 *  @param imageName         默认图片
 *  @param selectedImageName 高亮图片
 *
 *  @return 模型对象
 */
+ (DSTabItemModel*)modelWithTitle:(NSString*)title
                            image:(NSString*)imageName
                    selectedImage:(NSString*)selectedImageName;

@end
