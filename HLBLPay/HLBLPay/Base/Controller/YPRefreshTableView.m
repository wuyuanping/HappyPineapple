//
//  YPRefreshTableView.m
//  HLBLPay
//
//  Created by 吴园平 on 16/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPRefreshTableView.h"
#import "YPRefreshHeader.h"
#import "YPRefreshFooter.h"

@interface YPRefreshTableView ()

@property (nonatomic,assign) NSInteger page;

@end

@implementation YPRefreshTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _page = 1;
        __weak typeof(self) weakSelf = self;
        self.mj_header = [YPRefreshHeader headerWithRefreshingBlock:^{
            weakSelf.page = 1;
            //下拉刷新
            if (weakSelf.pullingDelegate && [weakSelf.pullingDelegate respondsToSelector:@selector(pullingTableViewDidStartRefreshing:)]) {
                [weakSelf.pullingDelegate pullingTableViewDidStartRefreshing:weakSelf];
            }
        }];
        
        self.mj_footer = [YPRefreshFooter footerWithRefreshingBlock:^{
            //上拉加载更多
            weakSelf.page ++;
            if (weakSelf.pullingDelegate && [weakSelf.pullingDelegate respondsToSelector:@selector(pullingTableViewDidStartLoadMoreData:page:)]) {
                [weakSelf.pullingDelegate pullingTableViewDidStartLoadMoreData:weakSelf page:weakSelf.page];
            }
        }];
    }
    return self;
}

- (void)endRefreshing
{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

- (void)noMoreData
{
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)resetPage
{
    self.page = 1;
}

- (void)setRefreshFooterHidden:(BOOL)hide
{
    self.mj_footer.hidden = hide;
}


@end
