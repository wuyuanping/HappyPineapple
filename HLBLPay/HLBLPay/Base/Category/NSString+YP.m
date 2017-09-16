//
//  NSString+YP.m
//  HLBLPay
//
//  Created by 吴园平 on 14/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "NSString+YP.h"

@implementation NSString (YP)

+ (BOOL)isEmpty:(NSString *)string
{
    if (string == nil) {
        return YES;
    }
   NSString *str = trim(string);
    if (0 == str.length) {
        return YES;
    }
    return NO;
}

@end
