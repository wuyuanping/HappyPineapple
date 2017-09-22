//
//  YPDbCache.m
//  HLBLPay
//
//  Created by 吴园平 on 17/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPDbCache.h"
#import "FMDB.h"

static YPDbCache *instance = nil;
static NSString *kYPDbTableCommon   = @"DbTableCommon";    // 公共table
const char *kDatabaseOperationQueue = "databaseOperationQueue";  // 数据库操作线程

@interface YPDbCache ()
{
    dispatch_queue_t    _dbOperQueue; //FMDB中线程安全
}

@property (nonatomic, strong) NSString *dbFilePath;
@property (nonatomic, strong) FMDatabaseQueue *databaseQ;

@end

@implementation YPDbCache

+ (YPDbCache *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YPDbCache alloc] init];
    });
    return instance;
}

+ (void)deleteDbFile
{
    if (!instance) {
        return;
    }
    @synchronized (self) {
        [instance.databaseQ close];
        if (![[NSFileManager defaultManager] removeItemAtPath:instance.dbFilePath error:nil]) {
        }
        // 重新初始化单例
        instance = [[YPDbCache alloc] init];
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        self.dbFilePath = [path stringByAppendingPathComponent:kYPDbFileName];
        self.databaseQ = [FMDatabaseQueue databaseQueueWithPath:self.dbFilePath];
        _dbOperQueue = dispatch_queue_create(kDatabaseOperationQueue, NULL);
    }
    return self;
}

- (BOOL)initTableWithName:(NSString *)name database:(FMDatabase *)database
{
    NSString *initSQL = [NSString stringWithFormat: @"CREATE TABLE if not exists %@ (key text, key1 text, key2 text, data blob, outdated int, timestamp double, PRIMARY KEY(key, key1, key2))", name];
    return [database executeUpdate:initSQL];
}

- (NSMutableDictionary *)paramDictWithCacheInfo:(YPDbCacheInfo *)cacheInfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[cacheInfo realKey] forKey:@"key"];
    [params setObject:[cacheInfo realKey1] forKey:@"key1"];
    [params setObject:[cacheInfo realKey2] forKey:@"key2"];
    return params;
}

// 查询db数据
- (YPDbCacheResult *)dataWithCacheInfo:(YPDbCacheInfo *)cacheInfo
{
    __block YPDbCacheResult *result;
    [self.databaseQ inDatabase:^(FMDatabase *db) {
        // 表不存在的话先创建表
        [self initTableWithName:cacheInfo.tableName database:db];
        
        NSDictionary *paramDict = [self paramDictWithCacheInfo:cacheInfo];
        NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE key = :key AND key1 = :key1 AND key2 = :key2", cacheInfo.tableName];
        
        FMResultSet *res = [db executeQuery:querySQL withParameterDictionary:paramDict];
        if ([res next]) {   // 这里默认只命中一条
            result = [[YPDbCacheResult alloc] init];
            result.data = [res dataForColumn:@"data"];
            result.cacheTime = [res doubleForColumn:@"timestamp"];
            result.outDated = [res boolForColumn:@"outdated"];
        }
        // NSLog(@"query db data, sql: %@, cache info: %@, res = %@", querySQL, cacheInfo, res);
        [res close];
    }];
    return result;
}

// 写入db数据：异步线程
- (void)updateData:(id)data withCacheInfo:(YPDbCacheInfo *)cacheInfo
{
    dispatch_async(_dbOperQueue, ^{
        [self.databaseQ inDatabase:^(FMDatabase *db) {
            // 表不存在的话先创建表
            [self initTableWithName:cacheInfo.tableName database:db];
            NSString *replaceSQL = [NSString stringWithFormat:@"INSERT OR REPLACE INTO %@ VALUES (:key, :key1, :key2, :data, :outdated, :timestamp)", cacheInfo.tableName];
            NSMutableDictionary *paramDict = [self paramDictWithCacheInfo:cacheInfo];
            [paramDict setObject:data forKey:@"data"];
            [paramDict setObject:[NSNumber numberWithInt:0] forKey:@"outdated"];
            [paramDict setObject:[NSNumber numberWithDouble:[[NSDate date] timeIntervalSince1970]] forKey:@"timestamp"];
            [db executeUpdate:replaceSQL withParameterDictionary:paramDict];
            // BOOL res = [db executeUpdate:replaceSQL withParameterDictionary:paramDict];
            // NSLog(@"update db data, sql: %@, cache info: %@, res = %d", replaceSQL, cacheInfo, res);
        }];
    });

}

// 删除某条数据，异步线程
- (void)deleteDataWithCacheInfo:(YPDbCacheInfo *)cacheInfo
{
    dispatch_async(_dbOperQueue, ^{
        [self.databaseQ inDatabase:^(FMDatabase *db) {
            NSString *deleteSQL = [NSString stringWithFormat:@"DELETE FROM %@ WHERE key = :key AND key1 = :key1 AND key2 = :key2", cacheInfo.tableName];
            NSDictionary *paramDict = [self paramDictWithCacheInfo:cacheInfo];
            [db executeUpdate:deleteSQL withParameterDictionary:paramDict];
            // BOOL res = [db executeUpdate:deleteSQL withParameterDictionary:paramDict];
            // NSLog(@"delete db data, sql: %@, cache info: %@, res = %d", deleteSQL, cacheInfo, res);
        }];
    });
}

// 使db中某条数据过期,异步线程
- (void)expireDataWithCacheInfo:(YPDbCacheInfo *)cacheInfo
{
    dispatch_async(_dbOperQueue, ^{
        [self.databaseQ inDatabase:^(FMDatabase *db) {
            NSString *updateSQL = [NSString stringWithFormat:@"UPDATE %@ SET outdated = %d WHERE key = ? AND key1 = ? AND key2 = ?", cacheInfo.tableName, 1];
            [db executeUpdate:updateSQL, [cacheInfo realKey], [cacheInfo realKey1], [cacheInfo realKey2]];
            // BOOL res = [db executeUpdate:updateSQL, [cacheInfo realKey], [cacheInfo realKey1], [cacheInfo realKey2]];
     // NSLog(@"expire db data, sql: %@, cache info: %@, res = %d", updateSQL, cacheInfo, res);
        }];
    });
}

- (void)dealloc
{
    [self.databaseQ close];
    // dispatch_release(_dbOperQueue);
}

@end

@implementation YPDbCacheInfo

+ (YPDbCacheInfo *)cacheInfoWithCacheRule:(YPDbCacheRule)cacheRule
{
    YPDbCacheInfo *info = [[YPDbCacheInfo alloc] init];
    info.tableName = kYPDbTableCommon;  // 默认存放到公共table，设置该属性可存储到指定table
    info.cacheRule = cacheRule;
    info.expireTime = kDBCacheExpireTime;
    info.autoSave = YES;    // 默认统一在公共模块进行缓存
    return info;
}

- (NSString *)realKey
{
    return self.cacheKey ?: @"default";
}

- (NSString *)realKey1
{
    return self.cacheKey1 ?: @"default";
}

- (NSString *)realKey2
{
    return self.cacheKey2 ?: @"default";
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"tableName = %@, key = %@, key1 = %@, key2 = %@, cacheRule: %d", _tableName, [self realKey], [self realKey1], [self realKey2], _cacheRule];
}

@end

@implementation YPDbCacheResult

@end



