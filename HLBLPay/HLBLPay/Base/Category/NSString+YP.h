//
//  NSString+YP.h
//  HLBLPay
//
//  Created by 吴园平 on 14/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>

// 返回去除用户输入的前后空格字符串
#define trim(str) [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]

@interface NSString (YP)

// 判断字符串是否为空
+ (BOOL)isEmpty:(NSString *)string;


@end
