//
//  SMBaseRefreshManager.h
//  tableivewSimplifyDemo
//
//  Created by 王金东 on 14/12/15.
//  Copyright © 2015年 王金东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMScrollViewRefreshDataSource.h"


@interface SMRefreshManager : NSObject


+ (instancetype)shareInstance;
//全局配置即可
- (void)registerRefreshViewDataSource:(id<SMScrollViewRefreshDataSource>)delegate ;
- (void)registerRefreshViewDataSource:(id<SMScrollViewRefreshDataSource>)delegate forKey:(NSString *)key;
- (id<SMScrollViewRefreshDataSource>)refreshViewDataSourceForKey:(NSString *)key;


@end
