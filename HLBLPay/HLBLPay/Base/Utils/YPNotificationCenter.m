//
//  YPNotificationCenter.m
//  HLBLPay
//
//  Created by 吴园平 on 16/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPNotificationCenter.h"

@implementation YPNotificationCenter

#pragma mark - Public Methods
+ (void)addObserver:(id)observer selector:(SEL)aSelector name:(NSString *)aName object:(id)anObject
{
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:aName object:anObject];
}

+ (void)postNotificationName:(NSString *)aName object:(id)anObject
{
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject];
        });
    }else {
        [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject];
    }
}

+ (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)userInfo
{
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject userInfo:userInfo];
        });
    }else {
        [[NSNotificationCenter defaultCenter] postNotificationName:aName object:anObject userInfo:userInfo];
    }
}

+ (void)removeObserver:(id)observer
{
    [[NSNotificationCenter defaultCenter] removeObserver:observer];
}

+ (void)removeObserver:(id)observer name:(NSString *)aName object:(id)anObject
{
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:aName object:anObject];
}

@end
