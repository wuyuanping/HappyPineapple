//
//  BaseDataSource.h
//  HLBLPay
//
//  Created by 吴园平 on 17/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

// 抽象的数据源类

#import <Foundation/Foundation.h>

typedef void(^CellConfigureBlock)(id cell,id item);

@interface BaseDataSource : NSObject<UITableViewDataSource,UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) CellConfigureBlock block;

- (id)initWithCellIdentifier:(NSString *)cellID configureCellBlock:(CellConfigureBlock)block;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
