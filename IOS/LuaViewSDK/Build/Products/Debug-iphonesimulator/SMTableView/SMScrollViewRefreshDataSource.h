//
//  SMBaseTableViewRefreshDelegate.h
//  tableivewSimplifyDemo
//
//  Created by 王金东 on 14/12/15.
//  Copyright © 2015年 王金东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SMScrollViewRefreshDataSource <NSObject>

- (void)scrollView:(UIScrollView *)scrollView addHeaderWithTarget:(id)delegate action:(SEL)action;
- (void)scrollView:(UIScrollView *)scrollView addFooterWithTarget:(id)delegate action:(SEL)action;

- (void)removeHeaderFromScrollView:(UIScrollView *)scrollView ;
- (void)removeFooterFromScrollView:(UIScrollView *)scrollView ;

- (void)headerEndRefreshingFromScrollView:(UIScrollView *)scrollView ;
- (void)footerEndRefreshingFromScrollView:(UIScrollView *)scrollView;


@end
