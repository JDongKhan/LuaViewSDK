//
//  UICollectionView+simplify.h
//  HsCore
//
//  Created by 王金东 on 15/12/18.
//  Copyright © 2015年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HsCollectionViewDelegate.h"
#import "HsCollectionViewDataSource.h"


typedef NS_ENUM(NSInteger, HsBaseRefreshCollectionViewType) {
    HsBaseRefreshCollectionViewHeader,//head类型
    HsBaseRefreshCollectionViewFooter,
};


@interface UICollectionView (simplify)<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic,assign) BOOL enableSimplify;
/**
 *@brief 取消系统默认的delegate和datasource 用下面的来实现自定义
 **/
@property (nonatomic,weak) id<HsCollectionViewDelegate> baseDelegate;
@property (nonatomic,weak) id<HsCollectionViewDataSource> baseDataSource;

/**
 *@brief controler
 **/
@property (nonatomic,weak) UIViewController *baseViewController;

/**
 *@brief 是否分块
 **/
@property (nonatomic, assign) BOOL sectionable;

/**
 *  @brief 数据源
 */
@property (nonatomic, strong) NSMutableArray *itemsArray;


/**
 *  @brief cell的类名
 **/
@property (nonatomic,assign) id collectionViewCellClass;


/**
 *@brief 如果itemsArray里面是NSDictionary 则第二级的数组按照keyOfItemArray来取
 * 默认是items
 **/

@property (nonatomic, strong) NSString *keyOfItemArray;


/**
 *@brief 刷新collectionView
 **/
- (void)reloadDataWithEmptyView;


@end



#pragma mark 刷新协议
@protocol HsBaseCollectionViewRefreshDelegate <NSObject>

@optional
/**
 *@brief 开始刷新数据
 **/
- (void)headerRereshing;

/**
 *@brief 开始加载数据
 **/
- (void)footerRereshing;

@end


/**
 *@brief  是否开启刷新功能 默认开启
 **/

@interface UICollectionView (refreshable)<HsBaseCollectionViewRefreshDelegate>

@property (nonatomic,assign) BOOL refreshHeaderable;
@property (nonatomic,assign) BOOL refreshFooterable;

@property (nonatomic,weak) id<HsBaseCollectionViewRefreshDelegate> refreshDelegate;

/**
 *@brief 加载完毕后调用该方法结束加载状态
 **/
- (void)didLoaded:(HsBaseRefreshCollectionViewType)type;


@end
