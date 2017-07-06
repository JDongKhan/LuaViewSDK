//
//  UICollectionViewCell+simplify.h
//  HsCore
//
//  Created by 王金东 on 15/12/18.
//  Copyright © 2015年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (simplify)

/**
 *@brief 行数据
 **/
@property (nonatomic,strong) id dataInfo;

/**
 *@brief 上层的viewcontroller
 **/
@property (nonatomic,weak) UIViewController *baseViewController;

@end
