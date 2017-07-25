//
//  UIScrollView+refreshable.m
//  SMTableView
//
//  Created by 王金东 on 2017/7/12.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "UIScrollView+refreshable.h"
#import <objc/runtime.h>
#import "SMRefreshManager.h"

static const void *sViewKeyForRefreshKey = &sViewKeyForRefreshKey;
//头部刷新
static const void *sViewKeyForHeaderRefresh = &sViewKeyForHeaderRefresh;
//底部刷新
static const void *sViewKeyForFooterRefresh = &sViewKeyForFooterRefresh;
static const void *sViewKeyForHeaderRereshing = &sViewKeyForHeaderRereshing;
static const void *sViewKeyForFooterRereshing = &sViewKeyForFooterRereshing;

@implementation UIScrollView (refreshable)


- (void)setHeaderRereshing:(HeaderRereshing)headerRereshing {
    objc_setAssociatedObject(self, sViewKeyForHeaderRereshing, headerRereshing, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self _addHeadRefresh];
}
- (HeaderRereshing)headerRereshing {
    return objc_getAssociatedObject(self, sViewKeyForHeaderRereshing);
}

- (void)setFooterRereshing:(FooterRereshing)footerRereshing {
    objc_setAssociatedObject(self, sViewKeyForFooterRereshing, footerRereshing, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self _addFootRefresh];
}
- (FooterRereshing)footerRereshing {
    return objc_getAssociatedObject(self, sViewKeyForFooterRereshing);
}

- (void)setRefreshKey:(NSString *)refreshKey {
    objc_setAssociatedObject(self, sViewKeyForRefreshKey, refreshKey, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)refreshKey {
    return objc_getAssociatedObject(self, sViewKeyForRefreshKey);
}

- (id<SMScrollViewRefreshDataSource>)refreshViewDataSource {
    NSString *_key = self.refreshKey;
    return [[SMRefreshManager shareInstance] refreshViewDataSourceForKey:_key];
}

//设置下拉刷新
- (void)setRefreshHeaderable:(BOOL)refreshHeaderable{
    objc_setAssociatedObject(self, sViewKeyForHeaderRefresh, @(refreshHeaderable), OBJC_ASSOCIATION_ASSIGN);
    [self _addHeadRefresh];
}
- (BOOL)refreshHeaderable{
    return [objc_getAssociatedObject(self, sViewKeyForHeaderRefresh) boolValue];
}
- (void)_addHeadRefresh {
    if(self.refreshHeaderable && self.headerRereshing){
        // 下拉刷新
        // 下拉刷新
        [self.refreshViewDataSource scrollView:self addHeaderWithTarget:self action:@selector(_headerRereshing)];
    }else{
        [self.refreshViewDataSource removeHeaderFromScrollView:self];
    }
}

- (BOOL)refreshFooterable{
    return [objc_getAssociatedObject(self, sViewKeyForFooterRefresh) boolValue];
}
//设置上啦加载
- (void)setRefreshFooterable:(BOOL)refreshFooterable{
    objc_setAssociatedObject(self, sViewKeyForFooterRefresh, @(refreshFooterable), OBJC_ASSOCIATION_ASSIGN);
    [self _addFootRefresh];
}
- (void)_addFootRefresh {
    if(self.refreshFooterable && self.footerRereshing){
        // 上拉加载更多
        [self.refreshViewDataSource scrollView:self addFooterWithTarget:self action:@selector(_footerRereshing)];
    }else{
        [self.refreshViewDataSource removeFooterFromScrollView:self];
    }
}
/**
 **开始刷新数据
 **/
- (void)_headerRereshing{
    self.headerRereshing(self);
}

/**
 **开始加载数据
 **/
- (void)_footerRereshing{
    self.footerRereshing(self);
}


//加载完调用 子类调用
- (void)endRefresh:(SMRefreshScrollViewType)type{
    // 刷新表格
    if([self isKindOfClass:[UITableView class]]){
        [(UITableView *)self reloadData];
    }else if([self isKindOfClass:[UICollectionView class]]){
        [(UICollectionView *)self reloadData];
    }
    if(type == SMRefreshScrollViewHeader){
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.refreshViewDataSource headerEndRefreshingFromScrollView:self];
    }else{
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.refreshViewDataSource footerEndRefreshingFromScrollView:self];
    }}



@end
