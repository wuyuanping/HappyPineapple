//
//  YPRefreshViewController.m
//  HLBLPay
//
//  Created by 吴园平 on 16/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

#import "YPRefreshViewController.h"
#import "YPRefreshHeader.h"
#import "YPRefreshFooter.h"

@interface YPRefreshViewController ()

@end

@implementation YPRefreshViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //加入contentScrollView及contrainerView
    [self.view addSubview:self.contentScrollView];
    [self.contentScrollView addSubview:self.contrainerView];
    //加入头部和尾部刷新控件
    YPRefreshHeader *header = [YPRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(beginRefreshing)];
    self.contentScrollView.mj_header = header;
    YPRefreshFooter *footer = [YPRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(beginLoadMore)];
    self.contentScrollView.mj_footer = footer;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    //布局加入的子控件
    [_contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navBar.mas_bottom);
        make.leading.equalTo(@0);
        make.trailing.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
    
    [_contrainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.mas_equalTo(_contentScrollView.mas_width);
    }];
    
    //子类的底部视图的bottom = containerView bottom 否则无法设置scrollView ContentSize
}

#pragma makr - refreshing target
- (void)beginRefreshing
{
    //子类必须重写此类
}

- (void)beginLoadMore
{
    //子类必须重写此类
}

#pragma mark - getter
- (UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _contentScrollView.alwaysBounceVertical = YES; //垂直滚动
        _contentScrollView.showsVerticalScrollIndicator = NO;//不显示垂直滚动条
    }
    return _contentScrollView;
}

- (UIView *)contrainerView
{
    if (!_contrainerView) {
        _contrainerView = [[UIView alloc] initWithFrame:CGRectZero];
        _contrainerView.backgroundColor = HEXCOLOR(0xf8f8f8);
    }
    return _contrainerView;
}

- (void)endRefreshing
{
    if (self.contentScrollView.mj_header) {
        [self.contentScrollView.mj_header endRefreshing];
        [self.contentScrollView.mj_footer endRefreshing];
    }
}

// 上拉时：提示没有更多数据
- (void)noMoreData
{
    [self.contentScrollView.mj_footer endRefreshingWithNoMoreData];
}

- (void)setRefreshFooterHidden:(BOOL)hide
{
    self.contentScrollView.hidden = hide;
    if (!hide) { //不隐藏,保留加载更多
        YPRefreshFooter *footer = [YPRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(beginLoadMore)];
        self.contentScrollView.mj_footer = footer;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
