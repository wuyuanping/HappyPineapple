//
//  AppCommonDefine.h
//  HLBLPay
//
//  Created by 吴园平 on 16/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#ifndef AppCommonDefine_h
#define AppCommonDefine_h

//获取当前屏幕高
#define  SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
//获取当前屏幕宽
#define  SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

#pragma mark - Color
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
// 十六进制颜色设置
#define HEXCOLOR(rgbValue) HEXACOLOR(rgbValue,1)
#define HEXACOLOR(rgbValue,a) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00)>>8))/255.0 blue: ((float)((rgbValue) & 0xFF))/255.0 alpha:(a)]



#endif /* AppCommonDefine_h */
