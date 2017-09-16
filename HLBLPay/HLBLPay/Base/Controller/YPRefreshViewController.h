//
//  YPRefreshViewController.h
//  HLBLPay
//
//  Created by 吴园平 on 16/09/2017.
//  Copyright © 2017 WuYuanPing. All rights reserved.
//

// 可以下拉或者上拉刷新的ViewController,此类封装了一些刷新的处理逻辑，方便需要刷新的子类使用，让需要刷新界面的
//  子视图控制器代码逻辑更清晰
//继承此类需知：
//1.在viewWillLayoutSubviews中对子类进行自动布局时，子类的底部视图的bottom = containerView bottom 否则无法设置scrollView 的 ContentSize
//2.如需设置contentScrollerView大小，请使用updateConstraints:更新布局


#import "BaseViewController.h"

@interface YPRefreshViewController : BaseViewController

@property (nonatomic,strong) UIScrollView *contentScrollView; //内容scrollView
@property (nonatomic, strong) UIView *contrainerView;   //内容容器view(此view为了可以在自动布局的时候设置contentScrollView的ContentSize)

//开始刷新
- (void)beginRefreshing;
//加载更多
- (void)beginLoadMore;
//结束刷新
- (void)endRefreshing;
// 提示没有更多数据
- (void)noMoreData;
//是否隐藏尾部刷新控件
- (void)setRefreshFooterHidden:(BOOL)hide;


@end
