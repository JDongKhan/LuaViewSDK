//
//  UICollectionViewCell+simplify.m
//  HsCore
//
//  Created by 王金东 on 15/12/18.
//  Copyright © 2015年 王金东. All rights reserved.
//

#import "UICollectionViewCell+simplify.h"
#import <objc/runtime.h>

static const void *collectionViewCellKeyForBaseViewController= &collectionViewCellKeyForBaseViewController;

@implementation UICollectionViewCell (simplify)

- (void)setDataInfo:(id)dataInfo {
    
}

- (id)dataInfo {
    return nil;
}

- (void)setBaseViewController:(UIViewController *)baseViewController {
    objc_setAssociatedObject(self, collectionViewCellKeyForBaseViewController, baseViewController, OBJC_ASSOCIATION_ASSIGN);
}
- (UIViewController *)baseViewController {
    return  objc_getAssociatedObject(self, collectionViewCellKeyForBaseViewController);
}


@end
