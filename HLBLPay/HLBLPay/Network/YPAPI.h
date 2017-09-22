//
//  YPAPI.h
//  HLBLPay
//
//  Created by 吴园平 on 17/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPNetworkManager.h"
#import "YPDbCache.h"

#define AppBase_url   @"http://appg.cloudxt.cn/api/app"
#define APIBASE_URL_TEST    @"gt.cloudxt.cn"

//UserDefault
static NSString *const GiftListArray          = @"GiftListArray";
static NSString *const UserLoginInfo          = @"UserLoginInfo";


@interface YPAPI : NSObject

+ (YPAPI *)sharedInstance;

+ (void)getWithUrl:(NSString *)url data:(NSDictionary *)data cacheInfo:(YPDbCacheInfo *)cacheInfo success:(SuccessBlock)success failure:(ErrorBlock)failure;
// TODO
+ (void)postWithUrl:(NSString *)url data:(NSDictionary *)data cacheInfo:(YPDbCacheInfo *)cacheInfo success:(SuccessBlock)success failure:(ErrorBlock)failure;

+ (void)postWithUrl:(NSString *)url data:(NSDictionary *)data success:(SuccessBlock)success failure:(ErrorBlock)failure;





@end
