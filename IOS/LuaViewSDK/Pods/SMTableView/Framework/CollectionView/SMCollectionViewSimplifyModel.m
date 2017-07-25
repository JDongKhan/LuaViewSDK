//
//  smCollectionViewSimplifyModel.m
//  smCore
//
//  Created by 王金东 on 16/1/22.
//  Copyright © 2016年 王金东. All rights reserved.
//

#import "SMCollectionViewSimplifyModel.h"
#import "UICollectionViewCell+simplify.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "UICollectionView+simplify.h"

#define collectionCellId @"collectionCellId"

#define c_respondsSel(target,sel)  (target && [target respondsToSelector:sel])
#define isCollectionView(collectionView) ([collectionView isKindOfClass:[UICollectionView class]])

@implementation SMCollectionViewSimplifyModel

#pragma mark -----------------------我是分隔线---------------------

#pragma mark -------------------------数据源---------------------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView.sectionable) {
        return collectionView.itemsArray.count;
    }
    return 1;
}
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(collectionView.sectionable && collectionView.itemsArray.count > 0){//分块 二维数组
        id cellInfo = collectionView.itemsArray[section];
        if([cellInfo isKindOfClass:[NSArray class]]){
            return [(NSArray *)cellInfo count];
        }else if([cellInfo isKindOfClass:[NSDictionary class]]){
            NSArray *array = cellInfo[collectionView.keyOfItemArray];
            if(array != nil && [array isKindOfClass:[NSArray class]]){
                return  [array count];
            }
        }
        return 0;
    }
    NSInteger count = collectionView.itemsArray.count;
    return count;
}


//获取当前数据，分组与不分组的数据
+ (id)dataInfoforCellatCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    if(collectionView.itemsArray.count == 0){
        return nil;
    }
    id dataInfo = nil;
    //设置数据源给tableviewcell
    if(collectionView.sectionable){//分块
        id cellInfo = collectionView.itemsArray[indexPath.section];
        if([cellInfo isKindOfClass:[NSArray class]]){
            dataInfo = cellInfo[indexPath.row];
        }else if([cellInfo isKindOfClass:[NSDictionary class]]){
            NSArray *array = cellInfo[collectionView.keyOfItemArray];
            if(array != nil && [array isKindOfClass:[NSArray class]]){
                dataInfo = array[indexPath.row];
            }
        }
    }else{
        dataInfo = collectionView.itemsArray[indexPath.row];
    }
    return dataInfo;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCellId forIndexPath:indexPath];
    
    NSAssert([cell isKindOfClass:[UICollectionViewCell class]], @"cell必须是UICollectionViewCell的子类");
    cell.viewController = collectionView.viewController;
    cell.dataInfo = [SMCollectionViewSimplifyModel dataInfoforCellatCollectionView:collectionView indexPath:indexPath];
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    return flowLayout.itemSize;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    return flowLayout.sectionInset;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    return flowLayout.minimumLineSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    return flowLayout.minimumInteritemSpacing;
}

@end
