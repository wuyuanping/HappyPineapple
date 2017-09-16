//
//  YPCommonTool.m
//  HLBLPay
//
//  Created by 吴园平 on 16/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPCommonTool.h"

@implementation YPCommonTool

+ (CGSize)findWidthForText:(NSString *)text havingHeight:(CGFloat)heightValue andFont:(UIFont *)font
{
    CGSize size = CGSizeZero;
    if (text) {
        CGRect frame = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX,heightValue) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
        size = CGSizeMake(frame.size.width+1, frame.size.height);
    }
    return size;
}

+ (NSString *)getReadableStringForTime:(long)sec
{
    if (sec < 60 * 60) {
        return [NSString stringWithFormat:@"%02ld:%02ld", sec / 60, sec % 60];
    } else {
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", sec / 60 / 60,
                (sec / 60) % 60, sec % 60];
    }
}

+ (NSURLRequest *)urlToURLRequest:(NSString *)string
{
    NSURL *linkUrl;
    if ([string hasPrefix:@"http://"] || [string hasPrefix:@"https://"]) {
        linkUrl = [NSURL URLWithString:string];
    } else {
        linkUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",string]];
    }
    return [NSURLRequest requestWithURL:linkUrl];
}

//+ (void)webViewSetCookie
//{
//    NSString *version = [NSString stringWithFormat:@"%@%@",IosAppVersion,WEBVIEW_VERSION];
//    
//    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
//    [cookieProperties setObject:@"version" forKey:NSHTTPCookieName];
//    [cookieProperties setObject:version forKey:NSHTTPCookieValue];
//    [cookieProperties setObject:@"lpsp.coralxt.com" forKey:NSHTTPCookieDomain];
//    [cookieProperties setObject:@"lpsp.coralxt.com" forKey:NSHTTPCookieOriginURL];
//    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
//    [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
//    
//    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
//    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
//}

@end
