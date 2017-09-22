//
//  YPHttpResult.h
//  HLBLPay
//
//  Created by 吴园平 on 17/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YPDbCache.h"

@interface YPHttpResult : NSObject

@property (nonatomic, strong) NSURLSessionDataTask *task;

/**
 存储Body的元数据
 */
@property (nonatomic, strong) NSData *data;

/**
 错误标识
 */
@property (nonatomic, strong) NSError *error;

/**
 储存临时变量
 */
@property (nonatomic, strong) NSMutableDictionary *reqArgs;

/**
 业务返回的错误码
 */
@property (nonatomic, assign) NSInteger retCode;
/**
 业务返回的二级错误码
 */
@property (nonatomic, assign) int subCode;

#pragma mark - 服务器返回相关
@property (nonatomic, strong) NSString *url;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, assign) NSInteger statusCode;

#pragma mark - 缓存相关
@property (nonatomic, assign) BOOL isCache;
@property (nonatomic, assign) BOOL outDated;;
@property (nonatomic, assign) NSTimeInterval timestamp; // 缓存存储时间
@property (nonatomic, strong) YPDbCacheInfo *cacheInfo;


- (id)initWithObj:(id) responseObject
         dataTask:(NSURLSessionDataTask *)task;

- (id)initWithObj:(id) responseObject;



@end
