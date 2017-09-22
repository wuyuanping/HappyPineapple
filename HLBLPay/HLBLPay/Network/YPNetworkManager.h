//
//  YPNetworkManager.h
//  HLBLPay
//
//  Created by 吴园平 on 17/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "YPHttpResult.h"
#import "YPDbCache.h"

typedef void (^SuccessBlock)(YPHttpResult *responseObject);
typedef void (^ErrorBlock)(YPHttpResult *responseObject);

@interface YPNetworkManager : NSObject

+ (YPNetworkManager *)sharedInstance;

- (BOOL)getWithUrl:(NSString *)url data:(NSDictionary *)data cacheInfo:(YPDbCacheInfo *)cacheInfo success:(SuccessBlock)success failure:(ErrorBlock)failure;

- (BOOL)postWithUrl:(NSString *)url data:(NSDictionary *)data success:(SuccessBlock)success failure:(ErrorBlock)failure;

@end
