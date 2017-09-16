//
//  YPNotificationCenter.h
//  HLBLPay
//
//  Created by 吴园平 on 16/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YPNotificationCenter : NSObject

+(void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject;
+(void)postNotificationName:(NSString *)aName object:(id)anObject;
+(void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)userInfo;
+(void)removeObserver:(id)observer;
+(void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject;


@end
