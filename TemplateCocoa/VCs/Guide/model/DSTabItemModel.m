//
//  DSTabItemModel.m
//  TemplateCocoa
//
//  Created by yuwenhua on 2017/1/17.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSTabItemModel.h"

@interface DSTabItemModel ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *selectedImageName;

@end

@implementation DSTabItemModel

+ (DSTabItemModel*)modelWithTitle:(NSString*)title
                            image:(NSString*)imageName
                    selectedImage:(NSString*)selectedImageName {
    DSTabItemModel *model = [[DSTabItemModel alloc] init];
    model.title = title;
    model.imageName = imageName;
    model.selectedImageName = selectedImageName;
    return model;
}

@end
