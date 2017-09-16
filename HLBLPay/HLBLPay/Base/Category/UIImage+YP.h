//
//  UIImage+YP.h
//  HLBLPay
//
//  Created by 吴园平 on 15/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YP)

+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 * 将图片Base64编码
 */
+ (NSString *)imageToDataURL:(UIImage *)image;
- (UIImage *)scaleToSize:(CGSize)size;

@end
