//
//  YPCommon.h
//  HLBLPay
//
//  Created by 吴园平 on 16/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#ifndef YPCommon_h
#define YPCommon_h

#define SYSTEM_VERSION   [[[UIDevice currentDevice] systemVersion] doubleValue]
#define iOS9            ([[[UIDevice currentDevice] systemVersion] doubleValue]-9.0>=0)
#define iOS8            ([[[UIDevice currentDevice] systemVersion] doubleValue]-8.0>=0)
#define iOS7            ([[[UIDevice currentDevice] systemVersion] doubleValue]-7.0>=0)
#define iOS6            ([[[UIDevice currentDevice] systemVersion] doubleValue]-6.0>=0)
#define iOS5            ([[[UIDevice currentDevice] systemVersion] doubleValue]-5.0>=0)

//#define UISCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define UISCREEN_WIDTH  (((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) ? \
[UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width)

#define UISCREEN_HEIGHT  (((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) ? \
[UIScreen mainScreen].bounds.size.width : [UIScreen mainScreen].bounds.size.height)

//iPhone Device
#define IPHONE4S (UISCREEN_HEIGHT <= 480)
#define IPHONE5_OR_EARLIER (UISCREEN_WIDTH <= 320)
#define IPHONE5_OR_LATTER (UISCREEN_WIDTH > 320)
#define IPHONE6_OR_LATER (UISCREEN_WIDTH >= 375)


// app info
#define iOSAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define iOSBuildVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define iOSAppName  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]


#define AppDelegateDefine ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define URLFromString(str)   [NSURL URLWithString:str]
#define trim(str) [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]






#endif /* YPCommon_h */
