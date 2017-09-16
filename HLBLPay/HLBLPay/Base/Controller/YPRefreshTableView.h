//
//  YPRefreshTableView.h
//  HLBLPay
//
//  Created by 吴园平 on 16/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YPRefreshTableView;
@protocol YPRefreshingTableViewDelegate <NSObject>

/**
 * 下拉刷新回调
 */
- (void)pullingTableViewDidStartRefreshing:(YPRefreshTableView *)tableView;

/**
 * 上拉加载更多
 */
- (void)pullingTableViewDidStartLoadMoreData:(YPRefreshTableView *)tableView page:(NSInteger)page;

@end


@interface YPRefreshTableView : UITableView

@property (nonatomic, assign) id<YPRefreshingTableViewDelegate> pullingDelegate;

//结束刷新
- (void)endRefreshing;
//提示：没有更多数据
- (void)noMoreData;
//重置page
- (void)resetPage;
///隐藏尾部
- (void)setRefreshFooterHidden:(BOOL)hide;

@end

