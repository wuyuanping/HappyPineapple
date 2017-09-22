//
//  YPDbCache.h
//  HLBLPay
//
//  Created by 吴园平 on 17/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kYPDbFileName               @"public.cache"               // YP公共db文件
static const NSInteger kDBCacheExpireTime = 5 * 60;   // 默认的缓存过期时间:5分钟

typedef enum {
    YPDbCacheRuleLocal,             // 直接取缓存，无缓存数据才发请求
    YPDbCacheRuleLocalAndNetwork,   // 先取缓存再根据缓存是否过期决定是否发请求，回包将覆盖缓存
    YPDbCacheRuleRefresh,           // 直接发请求，网络回包将覆盖缓存，一般用于下拉刷新
    YPDbCacheRuleNetwork,           // 直接发请求，忽略缓存，一般用于加载更多页
} YPDbCacheRule;

@class YPDbCacheInfo;
@class YPDbCacheResult;

@interface YPDbCache : NSObject

+ (YPDbCache *)sharedInstance;

/**
 *  删除db文件
 *  线程：当前线程
 */
+ (void)deleteDbFile;

/**
 *  从db读取数据
 *  线程：当前线程
 */
- (YPDbCacheResult *)dataWithCacheInfo:(YPDbCacheInfo *)cacheInfo;

/**
 *  写入db数据
 *  线程：异步线程
 */
- (void)updateData:(id)data withCacheInfo:(YPDbCacheInfo *)cacheInfo;

/**
 *  删除某条数据
 *  线程：异步线程
 */
- (void)deleteDataWithCacheInfo:(YPDbCacheInfo *)cacheInfo;

/**
 *  使db中某条数据过期
 *  线程：异步线程
 */
- (void)expireDataWithCacheInfo:(YPDbCacheInfo *)cacheInfo;

@end


@interface YPDbCacheInfo : NSObject

@property (nonatomic, strong) NSString *cacheKey;           // 主key
@property (nonatomic, strong) NSString *cacheKey1;          // 额外key1
@property (nonatomic, strong) NSString *cacheKey2;          // 额外key2

@property (nonatomic, assign) NSTimeInterval expireTime;    // 缓存失效时间，默认为kDBCacheExpireTime
@property (nonatomic, strong) NSString *tableName;          // 如果为空，统一存到公共表
@property (nonatomic, assign) YPDbCacheRule cacheRule;      // 缓存规则
@property (nonatomic, assign) BOOL autoSave;                // 是否在公共模块统一保存

+ (YPDbCacheInfo *)cacheInfoWithCacheRule:(YPDbCacheRule)cacheRule;

// 用于数据库操作的真实key
- (NSString *)realKey;
- (NSString *)realKey1;
- (NSString *)realKey2;

@end


@interface YPDbCacheResult : NSObject

@property (nonatomic,assign) BOOL outDated;                // 是否已失效/过期
@property (nonatomic,assign) NSTimeInterval cacheTime;     // 缓存存储时间
@property (nonatomic,strong) NSData *data;

@end

