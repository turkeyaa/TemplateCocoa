//
//  UIMacro.h
//  TemplateCocoa
//
//  Created by yuwenhua on 2016/12/15.
//  Copyright © 2016年 DS. All rights reserved.
//

#ifndef UIMacro_h
#define UIMacro_h

///设备宽高
#define DEVICE_HEIGHT   ([[UIScreen mainScreen]bounds].size.height)
#define DEVICE_WIDTH    ([[UIScreen mainScreen]bounds].size.width)

#define TAB_HEIGHT 49
#define NAV_HEIGHT 44
#define STATUS_HEIGHT 20

// 常用字体
#define FONT(fontsize)                [UIFont systemFontOfSize:fontsize]
#define FONT_BOLD(fontsize)           [UIFont boldSystemFontOfSize:fontsize]

// 粗体
#define FONT_H(fontsize)              [UIFont fontWithName:@"Helvetica" size:fontsize]
#define FONT_H_B(fontsize)            [UIFont fontWithName:@"Helvetica-Bold" size:fontsize]

// 字体大小
#define FONT_TEXT_BIG               FONT_H(19)        // A
#define FONT_TEXT_NORMAL            FONT_H(17)        // B
#define FONT_TEXT_SMALL             FONT_H(15)        // C
#define FONT_TEXT_SMALL2            FONT_H(13)        // D
#define FONT_TEXT_SMALL3            FONT_H(11)        // E
#define FONT_TEXT_SMALL4            FONT_H(9)         // F

// App 配置
#define Color_Nav                   RGB(0,123,252)
#define Color_Tab                   RGB(240,240,240)
#define Color_AppBackground         RGB(235, 236, 237)

#define Color_Alert_BackgroundLayer [UIColor colorWithWhite:.5f alpha:0.5f]

#define RGB(Red,Green,Blue)         [UIColor colorWithRed:Red/255.0 green:Green/255.0 blue:Blue/255.0 alpha:1.0]
#define RGBA(Red,Green,Blue,Alpha)  [UIColor colorWithRed:Red/255.0 green:Green/255.0 blue:Blue/255.0 alpha:Alpha]


#endif /* UIMacro_h */
