//
//  UICollectionView+simplify.m
//  SNCore
//
//  Created by 王金东 on 15/12/18.
//  Copyright © 2015年 王金东. All rights reserved.
//

#import "UICollectionView+simplify.h"
#import <objc/runtime.h>
#import "SMRefreshManager.h"

#define collectionCellId @"collectionCellId"


//cell
static const void *cViewKeyForCell = &cViewKeyForCell;

static const void *cViewKeyForEnableSimplify = &cViewKeyForEnableSimplify;
static const void *cViewKeyForItemsArray = &cViewKeyForItemsArray;

static const void *cViewKeyForKeyOfItemArray = &cViewKeyForKeyOfItemArray;
static const void *cViewKeyForSectionable = &cViewKeyForSectionable;
static const void *cViewKeyForViewController = &cViewKeyForViewController;


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprotocol"
@implementation UICollectionView (simplify)
#pragma clang diagnostic pop


#pragma mark -----------------------------set方法----------------------------------
- (void)setEnableSimplify:(BOOL)enableSimplify {
    objc_setAssociatedObject(self, cViewKeyForEnableSimplify, @(enableSimplify), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)enableSimplify {
    return  [objc_getAssociatedObject(self, cViewKeyForEnableSimplify) boolValue];
}

- (NSMutableArray *)itemsArray{
    return objc_getAssociatedObject(self, cViewKeyForItemsArray);
}
- (void)setItemsArray:(NSMutableArray *)itemsArray {
    objc_setAssociatedObject(self, cViewKeyForItemsArray,itemsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//二级数组里第二级数组的key
- (void)setKeyOfItemArray:(NSString *)keyOfItemArray{
    objc_setAssociatedObject(self, cViewKeyForItemsArray, keyOfItemArray, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)keyOfItemArray {
   return objc_getAssociatedObject(self, cViewKeyForItemsArray);
}

//是否分块
- (void)setSectionable:(BOOL)sectionable {
    objc_setAssociatedObject(self, cViewKeyForSectionable,@(sectionable), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)sectionable {
    return [objc_getAssociatedObject(self, cViewKeyForSectionable) boolValue];
}

//baseviewcontroller
- (void)setViewController:(UIViewController *)viewController  {
    objc_setAssociatedObject(self, cViewKeyForViewController,viewController, OBJC_ASSOCIATION_ASSIGN);
}
- (UIViewController *)viewController {
    return  objc_getAssociatedObject(self, cViewKeyForViewController);
}

- (void)setCollectionViewCellClass:(id)collectionViewCellClass{
    if(collectionViewCellClass != nil){
         objc_setAssociatedObject(self, cViewKeyForCell, collectionViewCellClass, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        if([collectionViewCellClass isKindOfClass:[UINib class]]){
            [self registerNib:collectionViewCellClass forCellWithReuseIdentifier:collectionCellId];
        }else{
            [self registerClass:collectionViewCellClass forCellWithReuseIdentifier:collectionCellId];
        }
    }
}
- (id)collectionViewCellClass {
     return objc_getAssociatedObject(self, cViewKeyForCell);
}

@end


#pragma mark -------------------------------------------------------------

@interface UICollectionView (_implement)
@end

@implementation UICollectionView (_implement)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method orignalDataSource;
        Method swizzleDataSource;
        //将方法替换
        orignalDataSource = class_getInstanceMethod(self, @selector(setDataSource:));
        swizzleDataSource = class_getInstanceMethod(self, @selector(_setDataSource:));
        method_exchangeImplementations(orignalDataSource, swizzleDataSource);
        
        Method orignalDataDelegate;
        Method swizzleDataDelegate;
        //将方法替换
        orignalDataDelegate = class_getInstanceMethod(self, @selector(setDelegate:));
        swizzleDataDelegate = class_getInstanceMethod(self, @selector(_setDelegate:));
        method_exchangeImplementations(orignalDataDelegate, swizzleDataDelegate);
    });
}
- (void)_setDataSource:(id)dataSources {
    if(self.enableSimplify){
        [self hookDataSource:dataSources];
    }
    [self _setDataSource:dataSources];
}
- (void)_setDelegate:(id)delegate {
    if(self.enableSimplify){
        [self hookDelegate:delegate];
    }
    [self _setDelegate:delegate];
}
- (void)hookDataSource:(id)dataSource {
    if(dataSource == nil){
        return;
    }
    //因调用频率较低固可以用此种简单的加锁方式
    @synchronized (self) {
        SEL selectors[] = {
            @selector(numberOfSectionsInCollectionView:),
            @selector(collectionView:numberOfItemsInSection:),
            @selector(collectionView:cellForItemAtIndexPath:)
        };
        Class kClass = [dataSource class];
        Class dClass = [SMCollectionViewSimplifyModel class];
        for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
            SEL originalSelector = selectors[index];
            SEL swizzleSelector = originalSelector;
            if(![kClass instancesRespondToSelector:originalSelector]){
                Method method = class_getInstanceMethod(dClass, swizzleSelector);
                IMP imp = class_getMethodImplementation(dClass, swizzleSelector);
                const char *type =  method_getTypeEncoding(method);
                class_addMethod(kClass, originalSelector, imp,type);
            }
        }
    }
}
- (void)hookDelegate:(id)delegate {
    if(delegate == nil){
        return;
    }
    //因调用频率较低固可以用此种简单的加锁方式
    @synchronized (self) {
        SEL selectors[] = {
            @selector(collectionView:layout:sizeForItemAtIndexPath:),
            @selector(collectionView:layout:insetForSectionAtIndex:),
            @selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:),
            @selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)
        };
        Class kClass = [delegate class];
        Class dClass = [SMCollectionViewSimplifyModel class];
        for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
            SEL originalSelector = selectors[index];
            SEL swizzleSelector = originalSelector;
            if(![kClass instancesRespondToSelector:originalSelector]){
                Method method = class_getInstanceMethod(dClass, swizzleSelector);
                IMP imp = class_getMethodImplementation(dClass, swizzleSelector);
                const char *type =  method_getTypeEncoding(method);
                class_addMethod(kClass, originalSelector, imp,type);
            }
        }
    }
    
}

@end
