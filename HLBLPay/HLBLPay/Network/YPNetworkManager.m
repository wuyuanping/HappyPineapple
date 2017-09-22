//
//  YPNetworkManager.m
//  HLBLPay
//
//  Created by 吴园平 on 17/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPNetworkManager.h"

@implementation YPNetworkManager

+ (YPNetworkManager *)sharedInstance
{
    static YPNetworkManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YPNetworkManager alloc] init];
    });
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        //初始化
    }
    return self;
}

- (BOOL)getWithUrl:(NSString *)url data:(NSDictionary *)data cacheInfo:(YPDbCacheInfo*)cacheInfo success:(SuccessBlock)success failure:(ErrorBlock)failure
{
    //存储缓存结果
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (cacheInfo && (cacheInfo.cacheRule == YPDbCacheRuleLocal || cacheInfo.cacheRule == YPDbCacheRuleLocalAndNetwork)) {
        YPDbCacheResult *cacheData = [[YPDbCache sharedInstance] dataWithCacheInfo:cacheInfo];
        if (cacheData != nil) {
            YPHttpResult *response  = [[YPHttpResult alloc] init];
            NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
            BOOL outDated = (now - cacheData.cacheTime > cacheInfo.expireTime);

            response.isCache = YES;
            response.timestamp = cacheData.cacheTime; // 缓存存储时间
            response.outDated = outDated || cacheData.outDated;
            
            NSError* error;
            if (cacheData.data != nil) {
                NSDictionary *jsonObject=[NSJSONSerialization
                                          JSONObjectWithData:cacheData.data
                                          options:kNilOptions
                                          error:&error];
                if(!error) {
                    response.dataDic = jsonObject;
                    if (success) {
                        success(response);
                    }
                    
                    if (!response.outDated) {
                        return NO;
                    }
                } else {
                    
                }
            }
        }
    }
    
    //发送请求
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:UserLoginInfo] != nil) {
        id userData = [[NSUserDefaults standardUserDefaults] valueForKey:UserLoginInfo];
//        LPUserModel *user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
//        if (![NSString isEmpty:user.data.token]) {
//            NSString *token = [NSString stringWithFormat:@"Bearer %@",user.data.token];
//            [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
//        }
    }
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",@"application/x-javascript",nil];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager.requestSerializer setHTTPShouldHandleCookies:YES];
    
    [manager GET:url parameters:data progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSURL* url = [task.response URL];
        
        YPHttpResult *response = [[YPHttpResult alloc] initWithObj:responseObject dataTask:task];
        response.timestamp = [[NSDate date] timeIntervalSince1970];
        response.cacheInfo = cacheInfo;
        response.url = [url absoluteString];
        response.dataDic = responseObject;
        if (cacheInfo != nil && (cacheInfo.cacheRule == YPDbCacheRuleLocalAndNetwork || cacheInfo.cacheRule == YPDbCacheRuleRefresh || cacheInfo.cacheRule == YPDbCacheRuleLocal)) {
            if (responseObject != nil) {
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
                //写入db数据：异步线程
                [[YPDbCache sharedInstance] updateData:jsonData withCacheInfo:cacheInfo];
            }
        }
        if (success) {
            success(response);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YPHttpResult *response = [[YPHttpResult alloc] init];
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)task.response;
        if (httpResp) {
            response.retCode = [httpResp statusCode];
            response.msg = [NSHTTPURLResponse localizedStringForStatusCode:[httpResp statusCode]];
        }
        response.error = error;
        if (failure) {
            failure(response);
        }
    }];
    return YES;
}

- (BOOL)postWithUrl:(NSString *)url data:(NSDictionary *)data success:(SuccessBlock)success failure:(ErrorBlock)failure
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:UserLoginInfo] != nil) {
       // id userData = [[NSUserDefaults standardUserDefaults] valueForKey:UserLoginInfo];
       // YPUserModel *user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
        
//        if (![NSString isEmpty:user.data.token]) {
//            NSString *token = [NSString stringWithFormat:@"Bearer %@",user.data.token];
//            [manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
//        }
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager.requestSerializer setHTTPShouldHandleCookies:YES];
    [manager POST:url parameters:data progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSURL* url = [task.response URL];
        
        YPHttpResult *response = [[YPHttpResult alloc] initWithObj:responseObject dataTask:task];
        //        response.retCode = ERROR_NOERROR;
        response.timestamp = [[NSDate date] timeIntervalSince1970];
        response.url = [url absoluteString];
        response.dataDic = responseObject;
        if (success) {
            success(response);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        YPHttpResult *response = [[YPHttpResult alloc] init];
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)task.response;
        if (httpResp) {
            response.retCode = [httpResp statusCode];
            response.msg = [NSHTTPURLResponse localizedStringForStatusCode:[httpResp statusCode]];
        }
        response.error = error;
        
        if (failure) {
            failure(response);
        }
        
    }];
    return YES;
}

@end
