//
//  BaseDataSource.m
//  HLBLPay
//
//  Created by 吴园平 on 17/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "BaseDataSource.h"

@implementation BaseDataSource

- (id)initWithCellIdentifier:(NSString *)cellID configureCellBlock:(CellConfigureBlock)block
{
    if (self = [super init]) {
        //初始化
        self.cellIdentifier = cellID;
        self.block = [block copy];
        self.items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)itemAtIndexPath:(NSIndexPath *)indexPath
{
    return [_items objectAtIndex:indexPath.item];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


@end
