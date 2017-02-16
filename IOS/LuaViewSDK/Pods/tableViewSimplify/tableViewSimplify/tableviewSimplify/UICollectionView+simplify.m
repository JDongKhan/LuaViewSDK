//
//  UICollectionView+simplify.m
//  HsCore
//
//  Created by 王金东 on 15/12/18.
//  Copyright © 2015年 王金东. All rights reserved.
//

#import "UICollectionView+simplify.h"
#import <objc/runtime.h>
#import "UICollectionViewCell+simplify.h"
#import "HsBaseRefreshManager.h"

#define collectionCellId @"collectionCellId"


//数组
static const void *collectionViewKeyForItemArray = &collectionViewKeyForItemArray;

//对象中数组的key
static const void *collectionViewKeyForKeyOfItemArray = &collectionViewKeyForKeyOfItemArray;
//刷新委托类
static const void *collectionViewKeyForRefreshDelegate = &collectionViewKeyForRefreshDelegate;
//头部刷新
static const void *collectionViewKeyForHeaderRefresh = &collectionViewKeyForHeaderRefresh;
//底部刷新
static const void *collectionViewKeyForFooterRefresh = &collectionViewKeyForFooterRefresh;
//cell
static const void *collectionViewKeyForTableViewCell = &collectionViewKeyForTableViewCell;
//section
static const void *collectionViewKeyForSectionable = &collectionViewKeyForSectionable;
//委托类
static const void *collectionViewKeyForBaseDelegate = &collectionViewKeyForBaseDelegate;
//数据源
static const void *collectionViewKeyForBaseDataSource = &collectionViewKeyForBaseDataSource;
//baseViewController;
static const void *collectionViewKeyForBaseViewController = &collectionViewKeyForBaseViewController;
static const void *collectionViewKeyForEnableSimplify = &collectionViewKeyForEnableSimplify;


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprotocol"
@implementation UICollectionView (simplify)
#pragma clang diagnostic pop


#pragma mark -----------------------------set方法----------------------------------
- (void)setEnableSimplify:(BOOL)enableSimplify{
    objc_setAssociatedObject(self, collectionViewKeyForEnableSimplify, @(enableSimplify), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)enableSimplify {
    return  [objc_getAssociatedObject(self, collectionViewKeyForEnableSimplify) boolValue];
}
//委托
- (void)setBaseDelegate:(id<HsCollectionViewDelegate>)baseDelegate{
    objc_setAssociatedObject(self, collectionViewKeyForBaseDelegate, baseDelegate, OBJC_ASSOCIATION_ASSIGN);
}
- (id<HsCollectionViewDelegate>)baseDelegate {
    return  objc_getAssociatedObject(self, collectionViewKeyForBaseDelegate);
}
- (void)setBaseDataSource:(id<HsCollectionViewDataSource>)baseDataSource{
    objc_setAssociatedObject(self, collectionViewKeyForBaseDataSource, baseDataSource, OBJC_ASSOCIATION_ASSIGN);
}
- (id<HsCollectionViewDataSource>)baseDataSource {
    return  objc_getAssociatedObject(self, collectionViewKeyForBaseDataSource);
}


- (NSMutableArray *)itemsArray{
    NSMutableArray *array = objc_getAssociatedObject(self, collectionViewKeyForItemArray);
    if (array == nil) {
        array = [NSMutableArray array];
        self.itemsArray = array;
    }
    return array;
}
- (void)setItemsArray:(NSMutableArray *)itemsArray {
    NSMutableArray *array = itemsArray;
    if([itemsArray isMemberOfClass:[NSArray class]]){
        array = itemsArray.mutableCopy;
    }
    objc_setAssociatedObject(self, collectionViewKeyForItemArray, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.enableSimplify) {
        self.dataSource = self;
        self.delegate = self;        //委托事件
    }
}

//二级数组里第二级数组的key
- (void)setKeyOfItemArray:(NSString *)keyOfItemArray{
    objc_setAssociatedObject(self, collectionViewKeyForKeyOfItemArray, keyOfItemArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)keyOfItemArray {
    NSString *key = objc_getAssociatedObject(self, collectionViewKeyForKeyOfItemArray);
    if (key == nil) {
        return @"items";
    }
    return key;
}

//baseviewcontroller
- (void)setBaseViewController:(UIViewController *)baseViewController  {
    objc_setAssociatedObject(self, collectionViewKeyForBaseViewController, baseViewController, OBJC_ASSOCIATION_ASSIGN);
}
- (UIViewController *)baseViewController {
    return  objc_getAssociatedObject(self, collectionViewKeyForBaseViewController);
}

//是否分块
- (void)setSectionable:(BOOL)sectionable {
    objc_setAssociatedObject(self, collectionViewKeyForSectionable, @(sectionable), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)sectionable {
    return  [objc_getAssociatedObject(self, collectionViewKeyForSectionable) boolValue];
}

/**
 *@brief 刷新collectionView
 **/
- (void)reloadDataWithEmptyView{
    [self reloadData];
}

- (void)setCollectionViewCellClass:(id)collectionViewCellClass{
    if(collectionViewCellClass != nil){
         objc_setAssociatedObject(self, collectionViewKeyForTableViewCell, collectionViewCellClass, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if([collectionViewCellClass isKindOfClass:[UINib class]]){
            [self registerNib:collectionViewCellClass forCellWithReuseIdentifier:collectionCellId];
        }else{
            [self registerClass:collectionViewCellClass forCellWithReuseIdentifier:collectionCellId];
        }
    }
}
- (id)collectionViewCellClass {
     return objc_getAssociatedObject(self, collectionViewKeyForTableViewCell);
}

#pragma mark -----------------------我是分隔线---------------------
#pragma mark -------------------------数据源---------------------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.sectionable) {
        return self.itemsArray.count;
    }
    return 1;
}
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.baseDataSource && [self.baseDataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]){
        return [self.baseDataSource collectionView:collectionView numberOfItemsInSection:section];
    }
    if(self.sectionable && self.itemsArray.count > 0){//分块 二维数组
        id cellInfo = self.itemsArray[section];
        if([cellInfo isKindOfClass:[NSArray class]]){
            return [(NSArray *)cellInfo count];
        }else if([cellInfo isKindOfClass:[NSDictionary class]]){
            NSArray *array = cellInfo[self.keyOfItemArray];
            if(array != nil && [array isKindOfClass:[NSArray class]]){
                return  [array count];
            }
        }
        return 0;
    }
    NSInteger count = self.itemsArray.count;
    return count;
}


//获取当前数据，分组与不分组的数据
- (id)dataInfoforCellatCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    if(self.itemsArray.count == 0){
        return nil;
    }
    id dataInfo = nil;
    //设置数据源给tableviewcell
    if(self.sectionable){//分块
        id cellInfo = self.itemsArray[indexPath.section];
        if([cellInfo isKindOfClass:[NSArray class]]){
            dataInfo = cellInfo[indexPath.row];
        }else if([cellInfo isKindOfClass:[NSDictionary class]]){
            NSArray *array = cellInfo[self.keyOfItemArray];
            if(array != nil && [array isKindOfClass:[NSArray class]]){
                dataInfo = array[indexPath.row];
            }
        }
    }else{
        dataInfo = self.itemsArray[indexPath.row];
    }
    return dataInfo;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.baseDataSource && [self.baseDataSource respondsToSelector:@selector(collectionView:cellForItemAtIndexPath:)]) {
        return [self.baseDataSource collectionView:collectionView cellForItemAtIndexPath:indexPath];
    }
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellId forIndexPath:indexPath];
    
    NSAssert([cell isKindOfClass:[UICollectionViewCell class]], @"cell必须是HsBaseCollectionViewCell的子类");
    cell.baseViewController = self.baseViewController;
    cell.dataInfo = [self dataInfoforCellatCollectionView:collectionView indexPath:indexPath];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (self.baseDataSource && [self.baseDataSource respondsToSelector:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)]) {
        return [self.baseDataSource collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
    }
    return nil;
}


#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        return [self.baseDelegate collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
    }
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    return flowLayout.itemSize;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        return [self.baseDelegate collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:section];
    }
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    return flowLayout.sectionInset;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        return [self.baseDelegate collectionView:collectionView layout:collectionViewLayout minimumLineSpacingForSectionAtIndex:section];
    }
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    return flowLayout.minimumLineSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        return [self.baseDelegate collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
    }
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    return flowLayout.minimumInteritemSpacing;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
        return [self.baseDelegate collectionView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection:section];
    }
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]) {
        return [self.baseDelegate collectionView:collectionView layout:collectionViewLayout referenceSizeForFooterInSection:section];
    }
    return CGSizeZero;
}

- (void)scrollViewDidEndDragging:(UICollectionView *)collectionView willDecelerate:(BOOL)decelerate{
    if(collectionView.baseDelegate && [collectionView.baseDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]){
        [collectionView.baseDelegate scrollViewDidEndDragging:collectionView willDecelerate:decelerate];
    }
}
- (void)scrollViewDidScroll:(UICollectionView *)collectionView {
    if(collectionView.baseDelegate && [collectionView.baseDelegate respondsToSelector:@selector(scrollViewDidScroll:)]){
        [collectionView.baseDelegate scrollViewDidScroll:collectionView];
    }
}

#pragma mark --UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.baseDelegate && [self.baseDelegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
        [self.baseDelegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }
}


@end




#pragma mark ------------------------------------我是分割线------------------------------
#pragma mark ------------------------------------下面是拓展的功能-------------------------
#pragma mark 刷新功能
@implementation UICollectionView (refreshable)

- (void)setRefreshDelegate:(id<HsBaseCollectionViewRefreshDelegate>)refreshDelegate{
    objc_setAssociatedObject(self, collectionViewKeyForRefreshDelegate, refreshDelegate, OBJC_ASSOCIATION_ASSIGN);
    self.refreshFooterable = self.refreshFooterable;
    self.refreshHeaderable = self.refreshHeaderable;
}

- (id<HsBaseCollectionViewRefreshDelegate>)refreshDelegate{
    id<HsBaseCollectionViewRefreshDelegate> delegate = objc_getAssociatedObject(self, collectionViewKeyForRefreshDelegate);
    if (delegate == nil) {
        return self;
    }
    return delegate;
}

//设置下拉刷新
- (void)setRefreshHeaderable:(BOOL)refreshHeaderable{
    objc_setAssociatedObject(self, collectionViewKeyForHeaderRefresh, @(refreshHeaderable), OBJC_ASSOCIATION_ASSIGN);
    if(refreshHeaderable){
        // 下拉刷新
        [[HsBaseRefreshManager shareInstance] scrollView:self addHeaderWithTarget:self.refreshDelegate action:@selector(headerRereshing)];
    }else{
        [[HsBaseRefreshManager shareInstance] removeHeaderFromScrollView:self];
    }
}
- (BOOL)refreshHeaderable{
    return [objc_getAssociatedObject(self, collectionViewKeyForHeaderRefresh) boolValue];
}
- (BOOL)refreshFooterable{
    return [objc_getAssociatedObject(self, collectionViewKeyForFooterRefresh) boolValue];
}
//设置上啦加载
- (void)setRefreshFooterable:(BOOL)refreshFooterable{
     objc_setAssociatedObject(self, collectionViewKeyForFooterRefresh, @(refreshFooterable), OBJC_ASSOCIATION_ASSIGN);
    if(refreshFooterable){
        // 上拉加载更多
        [[HsBaseRefreshManager shareInstance] scrollView:self addFooterWithTarget:self.refreshDelegate action:@selector(footerRereshing)];
    }else{
        [[HsBaseRefreshManager shareInstance] removeFooterFromScrollView:self];
    }
}
/**
 **开始刷新数据
 **/
- (void)headerRereshing{
    [self didLoaded:HsBaseRefreshCollectionViewHeader];
}

/**
 **开始加载数据
 **/
- (void)footerRereshing{
    [self didLoaded:HsBaseRefreshCollectionViewFooter];
}
//加载完调用 子类调用
- (void)didLoaded:(HsBaseRefreshCollectionViewType)type{
    // 刷新表格
    [self reloadData];
    if(type == HsBaseRefreshCollectionViewHeader){
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [[HsBaseRefreshManager shareInstance] headerEndRefreshingFromScrollView:self];
    }else{
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [[HsBaseRefreshManager shareInstance] footerEndRefreshingFromScrollView:self];
    }
}


@end
