//
//  YPCommonTool.h
//  HLBLPay
//
//  Created by 吴园平 on 16/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPCommonTool : NSObject


/**
 * 求一段字符串所占的宽高
 */
+ (CGSize)findWidthForText:(NSString *)text havingHeight:(CGFloat)heightValue andFont:(UIFont *)font;

/**
 * 秒转字符串输出
 */
+ (NSString *)getReadableStringForTime:(long)sec;

/**
 *  字符串 转成 NSURLRequest对象
 */
+ (NSURLRequest *)urlToURLRequest:(NSString *)string;

//+ (void)webViewSetCookie;



@end
