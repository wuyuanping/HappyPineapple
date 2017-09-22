//
//  YPHttpResult.m
//  HLBLPay
//
//  Created by 吴园平 on 17/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPHttpResult.h"

@implementation YPHttpResult

- (id)initWithObj:(id) responseObject
         dataTask:(NSURLSessionDataTask *)task
{
    self = [super init];
    if (self) {
        self.task = task;
        if ([responseObject isKindOfClass:[NSData class]]) {
            self.data = responseObject;
        } else if ([responseObject isKindOfClass:[NSError class]]) {
            self.error = responseObject;
        } else {
            self.error = [[NSError alloc] init];
        }
        self.reqArgs = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id)initWithObj:(id) responseObject
{
    self = [super init];
    if (self) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            self.data = responseObject;
        } else if ([responseObject isKindOfClass:[NSError class]]) {
            self.error = responseObject;
        } else {
            self.error = [[NSError alloc] init];
        }
        self.reqArgs = [NSMutableDictionary dictionary];
    }
    return self;
}


@end
