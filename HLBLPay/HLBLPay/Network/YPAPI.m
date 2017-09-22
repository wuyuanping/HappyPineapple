//
//  YPAPI.m
//  HLBLPay
//
//  Created by 吴园平 on 17/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPAPI.h"

@implementation YPAPI

+ (YPAPI *)sharedInstance
{
    static YPAPI *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YPAPI alloc] init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        // 初始化
    }
    return self;
}

+ (void)getWithUrl:(NSString *)url data:(NSDictionary *)data cacheInfo:(YPDbCacheInfo *)cacheInfo success:(SuccessBlock)success failure:(ErrorBlock)failure
{
    [[YPNetworkManager sharedInstance] getWithUrl:url data:data cacheInfo:cacheInfo success:^(YPHttpResult *responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(YPHttpResult *responseObject) {
        if (failure) {
            failure(responseObject);
        }
    }];
}

+ (void)postWithUrl:(NSString *)url data:(NSDictionary *)data cacheInfo:(YPDbCacheInfo *)cacheInfo success:(SuccessBlock)success failure:(ErrorBlock)failure
{
    [[YPNetworkManager sharedInstance] postWithUrl:url data:data success:^(YPHttpResult *responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(YPHttpResult *responseObject) {
        if (failure) {
            failure(responseObject);
        }
    }];
}

+ (void)postWithUrl:(NSString *)url data:(NSDictionary *)data success:(SuccessBlock)success failure:(ErrorBlock)failure
{
    [[YPNetworkManager sharedInstance] postWithUrl:url data:data success:^(YPHttpResult *responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(YPHttpResult *responseObject) {
        if (failure) {
            failure(responseObject);
        }
    }];
}



@end
