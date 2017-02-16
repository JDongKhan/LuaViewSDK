//
//  HsBaseTableViewDataSource.h
//  hundsun_zjfae
//
//  Created by 王金东 on 14-7-30.
//  Copyright (c) 2014年 王金东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol HsBaseTableViewDataSource <UITableViewDataSource>

@optional

- (NSInteger)tableView:(UITableView *)tableView typeForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 ** 可以设置行样式
 **/
- (void)tableView:(UITableView *)tableView cellStyleForRowAtIndexPath:(UITableViewCell *)cell;


@end
