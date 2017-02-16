//
//  HsBaseRefreshManager.h
//  tableivewSimplifyDemo
//
//  Created by 王金东 on 14/12/15.
//  Copyright © 2015年 王金东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HsBaseScrollViewRefreshDelegate.h"


@interface HsBaseRefreshManager : NSObject


+ (instancetype)shareInstance;
//全局配置即可
- (void)registerRefreshView:(id<HsBaseScrollViewRefreshDelegate>)delegate;

//添加下拉事件
- (void)scrollView:(UIScrollView *)gitscrollView addHeaderWithTarget:(id)delegate action:(SEL)action;
//添加上拉事件
- (void)scrollView:(UIScrollView *)scrollView addFooterWithTarget:(id)delegate action:(SEL)action;
//移除下拉事件 或 视图
- (void)removeHeaderFromScrollView:(UIScrollView *)scrollView ;
//移除上拉事件 或 视图
- (void)removeFooterFromScrollView:(UIScrollView *)scrollView ;

//结束下拉时调用
- (void)headerEndRefreshingFromScrollView:(UIScrollView *)scrollView ;
//结束上拉时调用
- (void)footerEndRefreshingFromScrollView:(UIScrollView *)scrollView ;

@end
