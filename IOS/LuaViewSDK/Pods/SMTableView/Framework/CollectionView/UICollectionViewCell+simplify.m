//
//  UICollectionViewCell+simplify.m
//  SMCore
//
//  Created by 王金东 on 15/12/18.
//  Copyright © 2015年 王金东. All rights reserved.
//

#import "UICollectionViewCell+simplify.h"
#import <objc/runtime.h>

static const void *cViewCellKeyForViewController= &cViewCellKeyForViewController;
static const void *cViewKeyForDataInfo = &cViewKeyForDataInfo;

@implementation UICollectionViewCell (simplify)

- (void)setDataInfo:(id)dataInfo {
    objc_setAssociatedObject(self, cViewKeyForDataInfo, dataInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)dataInfo {
    return  objc_getAssociatedObject(self, cViewKeyForDataInfo);
}

- (void)render:(id)dataInfo {
    //不知道该咋处理，还是你自己来吧
}


- (void)setViewController:(UIViewController *)viewController {
    objc_setAssociatedObject(self, cViewCellKeyForViewController, viewController, OBJC_ASSOCIATION_ASSIGN);
}
- (UIViewController *)viewController {
    return  objc_getAssociatedObject(self, cViewCellKeyForViewController);
}

@end
