//
//  HsBaseRefreshManager.m
//  tableivewSimplifyDemo
//
//  Created by 王金东 on 14/12/15.
//  Copyright © 2015年 王金东. All rights reserved.
//

#import "HsBaseRefreshManager.h"

@implementation HsBaseRefreshManager{
    id<HsBaseScrollViewRefreshDelegate> _delegate;
}

+ (instancetype)shareInstance {
    static HsBaseRefreshManager *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)registerRefreshView:(id<HsBaseScrollViewRefreshDelegate>)delegate {
    _delegate = delegate;
}


- (void)scrollView:(UIScrollView *)scrollView addHeaderWithTarget:(id)delegate action:(SEL)action {
    if (_delegate) {
        [_delegate scrollView:scrollView addHeaderWithTarget:delegate action:action];
    }
}
- (void)scrollView:(UIScrollView *)scrollView addFooterWithTarget:(id)delegate action:(SEL)action {
    if (_delegate) {
        [_delegate scrollView:scrollView addFooterWithTarget:delegate action:action];
    }
}

- (void)removeHeaderFromScrollView:(UIScrollView *)scrollView  {
    if (_delegate) {
        [_delegate removeHeaderFromScrollView:scrollView];
    }
}
- (void)removeFooterFromScrollView:(UIScrollView *)scrollView {
    if (_delegate) {
        [_delegate removeFooterFromScrollView:scrollView];
    }
}

- (void)headerEndRefreshingFromScrollView:(UIScrollView *)scrollView {
    if (_delegate) {
        [_delegate headerEndRefreshingFromScrollView:scrollView];
    }
}
- (void)footerEndRefreshingFromScrollView:(UIScrollView *)scrollView {
    if (_delegate) {
        [_delegate footerEndRefreshingFromScrollView:scrollView];
    }
}


@end
