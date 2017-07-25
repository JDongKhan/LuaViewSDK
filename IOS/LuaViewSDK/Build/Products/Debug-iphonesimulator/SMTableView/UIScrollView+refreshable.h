//
//  UIScrollView+refreshable.h
//  SMTableView
//
//  Created by 王金东 on 2017/7/12.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, SMRefreshScrollViewType) {
    SMRefreshScrollViewHeader,//head类型
    SMRefreshScrollViewFooter,
};

typedef void(^HeaderRereshing) (UIScrollView *scrollView);
typedef void(^FooterRereshing) (UIScrollView *scrollView);

@interface UIScrollView (refreshable)

@property (nonatomic, assign) BOOL refreshHeaderable;
@property (nonatomic, assign) BOOL refreshFooterable;

@property (nonatomic, copy) NSString *refreshKey;

@property (nonatomic, copy) HeaderRereshing headerRereshing;
@property (nonatomic, copy) FooterRereshing footerRereshing;

/**
 *@brief 加载完毕后调用该方法结束加载状态
 **/
- (void)endRefresh:(SMRefreshScrollViewType)type;


@end
