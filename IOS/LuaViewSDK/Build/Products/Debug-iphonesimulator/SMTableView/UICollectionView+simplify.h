//
//  UICollectionView+simplify.h
//  SMCore
//
//  Created by 王金东 on 15/12/18.
//  Copyright © 2015年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMCollectionViewSimplifyModel.h"



@interface UICollectionView (simplify)

@property (nonatomic, assign) BOOL enableSimplify;

/**
 *@brief controler
 **/
@property (nonatomic, weak) UIViewController *viewController;

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
@property (nonatomic, assign) id collectionViewCellClass;


/**
 *@brief 如果itemsArray里面是NSDictionary 则第二级的数组按照keyOfItemArray来取
 * 默认是items
 **/

@property (nonatomic, copy) NSString *keyOfItemArray;


@end

