//
//  UITableView+simplify.m
//  SMCore
//
//  Created by 王金东 on 15/7/28.
//  Copyright (c) 2015年 王金东. All rights reserved.
//

#import "UITableView+simplify.h"
#import "UITableViewCell+simplify.h"
#import <objc/runtime.h>
#import "SMRefreshManager.h"


NSString *const SMTableViewKeyTypeForRow = @"typeForRow";
NSString *const SMTableViewLayoutForRow = @"layoutForRow";
NSString *const SMTableViewKeyOfItemArray = @"items";


NSString *const _cellID = @"tableViewCellID";

#pragma mark  ----属性
//indexPath
static const void *tableViewKeyForIndexPath = &tableViewKeyForIndexPath;
//单个cell 可是nib也可是class
static const void *tableViewKeyForTableViewCell = &tableViewKeyForTableViewCell;

//category
static const void *tableViewKeyForRefreshDelegate = &tableViewKeyForRefreshDelegate;
static const void *tableViewKeyForHeaderRefresh = &tableViewKeyForHeaderRefresh;
static const void *tableViewKeyForFooterRefresh = &tableViewKeyForFooterRefresh;

static const void *tableViewKeyForEnableSimplify = &tableViewKeyForEnableSimplify;

static const void *tableViewKeyForSelectCellBlock = &tableViewKeyForSelectCellBlock;
static const void *tableViewKeyForCellHeightBlock = &tableViewKeyForCellHeightBlock;
static const void *tableViewKeyForCellTypeBlock = &tableViewKeyForCellTypeBlock;
static const void *tableViewKeyForConfigureCellBlock = &tableViewKeyForConfigureCellBlock;

static const void *tableViewKeyForTitleView = &tableViewKeyForTitleView;
static const void *tableViewKeyForImageView = &tableViewKeyForImageView;
static const void *tableViewKeyForDetailView = &tableViewKeyForDetailView;
static const void *tableViewKeyForHeadTitle = &tableViewKeyForHeadTitle;
static const void *tableViewKeyForKeyOfItemArray = &tableViewKeyForKeyOfItemArray;
static const void *tableViewKeyForViewController = &tableViewKeyForViewController;
static const void *tableViewKeyForTableViewCellStyle = &tableViewKeyForTableViewCellStyle;
static const void *tableViewKeyForFirstSectionHeaderHeight = &tableViewKeyForFirstSectionHeaderHeight;
static const void *tableViewKeyForSectionIndexTitles = &tableViewKeyForSectionIndexTitles;
static const void *tableViewKeyForClearsSelectionDelay = &tableViewKeyForClearsSelectionDelay;
static const void *tableViewKeyForSectionable = &tableViewKeyForSectionable;
static const void *tableViewKeyForSupportHeightCache = &tableViewKeyForSupportHeightCache;


static const void *tableViewKeyForTableViewCellArray = &tableViewKeyForTableViewCellArray;
static const void *tableViewKeyForItemsArray = &tableViewKeyForItemsArray;
static const void *tableViewKeyForAutoLayout = &tableViewKeyForAutoLayout;


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprotocol"
@implementation UITableView (simplify)
#pragma clang diagnostic pop

#pragma mark -----------------------------set方法----------------------------------

- (void)setEnableSimplify:(BOOL)enableSimplify {
    objc_setAssociatedObject(self, tableViewKeyForEnableSimplify, @(enableSimplify), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)enableSimplify {
     return  [objc_getAssociatedObject(self, tableViewKeyForEnableSimplify) boolValue];
}
- (void)setDidSelectCellBlock:(DidSelectCellBlock)didSelectCellBlock {
    objc_setAssociatedObject(self, tableViewKeyForSelectCellBlock,didSelectCellBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (DidSelectCellBlock)didSelectCellBlock {
    return objc_getAssociatedObject(self, tableViewKeyForSelectCellBlock);
}
- (void)setCellHeightBlock:(CellHeightBlock)cellHeightBlock {
    objc_setAssociatedObject(self, tableViewKeyForCellHeightBlock,cellHeightBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (CellHeightBlock)cellHeightBlock {
    return objc_getAssociatedObject(self, tableViewKeyForCellHeightBlock);
}
- (void)setCellTypeBlock:(CellTypeBlock)cellTypeBlock {
     objc_setAssociatedObject(self, tableViewKeyForCellTypeBlock,cellTypeBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (CellTypeBlock)cellTypeBlock {
    return objc_getAssociatedObject(self, tableViewKeyForCellTypeBlock);
}

- (void)setConfigureCellBlock:(TableViewCellConfigureBlock)configureCellBlock {
     objc_setAssociatedObject(self, tableViewKeyForConfigureCellBlock,configureCellBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (TableViewCellConfigureBlock)configureCellBlock {
    return objc_getAssociatedObject(self, tableViewKeyForConfigureCellBlock);
}

//默认cell中title的key
- (void)setKeyForTitleView:(NSString *)keyForTitleView {
    objc_setAssociatedObject(self, tableViewKeyForTitleView,keyForTitleView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)keyForTitleView {
    NSString *title = objc_getAssociatedObject(self, tableViewKeyForTitleView);
    if(title == nil){
        title = SMCellKeyForTitleView;
    }
    return title;
}
//默认cell中image的key
- (void)setKeyForImageView:(NSString *)keyForImageView{
    objc_setAssociatedObject(self, tableViewKeyForImageView,keyForImageView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)keyForImageView {
    NSString *image = objc_getAssociatedObject(self, tableViewKeyForImageView);
    if(image == nil){
        image = SMCellKeyForImageView;
    }
    return image;
}
//默认cell中detail的key
- (void)setKeyForDetailView:(NSString *)keyForDetailView{
    objc_setAssociatedObject(self, tableViewKeyForDetailView,keyForDetailView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)keyForDetailView {
    NSString *detail = objc_getAssociatedObject(self, tableViewKeyForDetailView);
    if(detail == nil){
        detail = SMCellKeyForDetailView;
    }
    return detail;
}

//分组的标题key
- (void)setKeyOfHeadTitle:(NSString *)keyOfHeadTitle {
    objc_setAssociatedObject(self, tableViewKeyForHeadTitle,keyOfHeadTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)keyOfHeadTitle {
    NSString *headTitle = objc_getAssociatedObject(self, tableViewKeyForHeadTitle);
    return headTitle;
}

//二级数组里第二级数组的key
- (void)setKeyOfItemArray:(NSString *)keyOfItemArray{
    objc_setAssociatedObject(self, tableViewKeyForKeyOfItemArray,keyOfItemArray, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)keyOfItemArray {
    NSString *keyOfItemArray = objc_getAssociatedObject(self, tableViewKeyForKeyOfItemArray);
    if(keyOfItemArray == nil){
        keyOfItemArray = SMTableViewKeyOfItemArray;
    }
    return keyOfItemArray;
}

//baseviewcontroller
- (void)setViewController:(UIViewController *)viewController  {
    objc_setAssociatedObject(self, tableViewKeyForViewController,viewController, OBJC_ASSOCIATION_ASSIGN);
}
- (UIViewController *)viewController {
    return objc_getAssociatedObject(self, tableViewKeyForViewController);
}
//tableview的类型
- (void)setTableViewCellStyle:(UITableViewCellStyle)tableViewCellStyle {
    objc_setAssociatedObject(self, tableViewKeyForTableViewCellStyle,@(tableViewCellStyle), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (UITableViewCellStyle)tableViewCellStyle {
    return [objc_getAssociatedObject(self, tableViewKeyForTableViewCellStyle) integerValue];
}

//第一块的head高
- (void)setFirstSectionHeaderHeight:(CGFloat)firstSectionHeaderHeight {
    objc_setAssociatedObject(self, tableViewKeyForFirstSectionHeaderHeight,@(firstSectionHeaderHeight), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (CGFloat)firstSectionHeaderHeight {
    return [objc_getAssociatedObject(self, tableViewKeyForFirstSectionHeaderHeight) floatValue];
}
//右侧索引的数组
- (void)setSectionIndexTitles:(NSArray *)sectionIndexTitles {
    objc_setAssociatedObject(self, tableViewKeyForSectionIndexTitles,sectionIndexTitles, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSArray *)sectionIndexTitles {
    return objc_getAssociatedObject(self, tableViewKeyForSectionIndexTitles);
}
//开启延迟取消选中的背景
- (void)setClearsSelectionDelay:(BOOL)clearsSelectionDelay {
    objc_setAssociatedObject(self, tableViewKeyForClearsSelectionDelay,@(clearsSelectionDelay), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL)clearsSelectionDelay {
    return [objc_getAssociatedObject(self, tableViewKeyForClearsSelectionDelay) boolValue];
}
//是否分块
- (void)setSectionable:(BOOL)sectionable {
    objc_setAssociatedObject(self, tableViewKeyForSectionable,@(sectionable), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL)sectionable {
    return [objc_getAssociatedObject(self, tableViewKeyForSectionable) boolValue];
}

- (void)setSupportHeightCache:(BOOL)supportHeightCache {
    objc_setAssociatedObject(self, tableViewKeyForSupportHeightCache,@(supportHeightCache), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL)supportHeightCache {
     return [objc_getAssociatedObject(self, tableViewKeyForSupportHeightCache) boolValue];
}

#pragma mark 注册cell
//注册 单个tableviewCell
- (void)setTableViewCellClass:(id)tableViewCellClass{
    if(tableViewCellClass != nil){
        objc_setAssociatedObject(self, tableViewKeyForTableViewCell, tableViewCellClass, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        //生成cellid
        NSString *cellID = [_cellID stringByAppendingString:@"_0"];
        if([tableViewCellClass isKindOfClass:[UINib class]]){
            [self registerNib:tableViewCellClass forCellReuseIdentifier:cellID];
        }else{
            [self registerClass:tableViewCellClass forCellReuseIdentifier:cellID];
        }
    }
}
- (id)tableViewCellClass {
    return objc_getAssociatedObject(self, tableViewKeyForTableViewCell);
}

//注册 多个tableviewCell 传入是数组
- (void)setTableViewCellArray:(NSArray *)tableViewCellArray{
    if(tableViewCellArray != nil){
        objc_setAssociatedObject(self, tableViewKeyForTableViewCellArray, tableViewCellArray, OBJC_ASSOCIATION_COPY_NONATOMIC);
        for (NSInteger i = 0; i< tableViewCellArray.count; i++) {
            id cell = tableViewCellArray[i];
            //生成cellid
            NSString *cellID = [_cellID stringByAppendingFormat:@"_%ld",(long)i];
            if([cell isKindOfClass:[UINib class]]){
                [self registerNib:cell forCellReuseIdentifier:cellID];
            }else{
                [self registerClass:cell forCellReuseIdentifier:cellID];
            }
        }
    }
}
- (NSArray *)tableViewCellArray {
    return objc_getAssociatedObject(self, tableViewKeyForTableViewCellArray);
}

#pragma mark 构造数据集合  数据源
- (void)setItemsArray:(NSMutableArray *)itemsArray{
    objc_setAssociatedObject(self, tableViewKeyForItemsArray, itemsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)itemsArray{
    return objc_getAssociatedObject(self, tableViewKeyForItemsArray);
}

- (void)setAutoLayout:(BOOL)autoLayout{
    objc_setAssociatedObject(self, tableViewKeyForAutoLayout, @(autoLayout), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)autoLayout {
    return [objc_getAssociatedObject(self, tableViewKeyForAutoLayout) boolValue];
}


@end


#pragma mark 编辑能力

static const void *tableViewKeyForEditable = &tableViewKeyForEditable;
static const void *tableViewKeyForSingleLineDeleteAction = &tableViewKeyForSingleLineDeleteAction;
static const void *tableViewKeyForMultiLineDeleteAction = &tableViewKeyForMultiLineDeleteAction;
static const void *tableViewKeyForCanEditable = &tableViewKeyForCanEditable;
static const void *tableViewKeyForDeleteConfirmationButtonTitle = &tableViewKeyForDeleteConfirmationButtonTitle;

@implementation UITableView (editable)

- (BOOL)editable{
    return [objc_getAssociatedObject(self, tableViewKeyForEditable) boolValue];
}
- (void)setEditable:(BOOL)editable {
     objc_setAssociatedObject(self, tableViewKeyForEditable, @(editable), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)setSingleLineDeleteAction:(SingleLineDeleteAction)singleLineDeleteAction{
    objc_setAssociatedObject(self, tableViewKeyForSingleLineDeleteAction, singleLineDeleteAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if(singleLineDeleteAction != nil){
        self.editable = YES;
    }else{
        self.editable = NO;
    }
}
- (SingleLineDeleteAction)singleLineDeleteAction{
    return objc_getAssociatedObject(self, tableViewKeyForSingleLineDeleteAction);
}

- (void)setMultiLineDeleteAction:(MultiLineDeleteAction)multiLineDeleteAction{
    objc_setAssociatedObject(self, tableViewKeyForMultiLineDeleteAction,multiLineDeleteAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if(multiLineDeleteAction != nil){
        self.editable = YES;
    }else{
        self.editable = NO;
    }
}
- (MultiLineDeleteAction)multiLineDeleteAction{
    return objc_getAssociatedObject(self, tableViewKeyForMultiLineDeleteAction);
}
- (void)setCanEditable:(CanEditable)canEditable {
     objc_setAssociatedObject(self, tableViewKeyForCanEditable, canEditable, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (CanEditable)canEditable{
    return objc_getAssociatedObject(self, tableViewKeyForCanEditable);
}
- (void)setDeleteConfirmationButtonTitle:(NSString *)deleteConfirmationButtonTitle {
     objc_setAssociatedObject(self, tableViewKeyForDeleteConfirmationButtonTitle, deleteConfirmationButtonTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)deleteConfirmationButtonTitle {
    return objc_getAssociatedObject(self, tableViewKeyForDeleteConfirmationButtonTitle);
}


- (void)setMultiLineEditing:(BOOL)editing animated:(BOOL)animated {
    if(!editing){
        NSArray *array = [self indexPathsForSelectedRows];
        self.multiLineDeleteAction(array);
    }
    [self setEditing:editing animated:animated];
   
}

@end

#pragma mark -------------------------------------------------------------

@interface UITableView (_implement)
@end

@implementation UITableView (_implement)

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
            @selector(tableView:cellForRowAtIndexPath:),
            @selector(numberOfSectionsInTableView:),
            @selector(tableView:numberOfRowsInSection:),
            
            /***************************************************/
            @selector(tableView:titleForHeaderInSection:),
            @selector(sectionIndexTitlesForTableView:),
            /*************************edit**************************/
            @selector(tableView:canEditRowAtIndexPath:),
            @selector(tableView:editingStyleForRowAtIndexPath:),
            @selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:),
            @selector(tableView:commitEditingStyle:forRowAtIndexPath:),
            @selector(tableView:canMoveRowAtIndexPath:)
        };
        Class kClass = [dataSource class];
        BOOL ignoreIsRespond = NO;
        if([dataSource isKindOfClass:[UITableViewController class]]){
            ignoreIsRespond = YES;
        }
        Class dClass = [SMTableViewSimplifyModel class];
        for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
            SEL originalSelector = selectors[index];
            SEL swizzleSelector = originalSelector;
            if(ignoreIsRespond||![kClass instancesRespondToSelector:originalSelector]){
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
            @selector(tableView:heightForRowAtIndexPath:),
            @selector(tableView:didSelectRowAtIndexPath:)
        };
        //如果你设置了rowHeight，则不需要我们来处理heightForRowAtIndexPath，当然你需要在setDelegate之前设置rowHeight，否则我们当做没看到
        if(self.rowHeight > 0){
            selectors[0] = NULL;
        }
        Class kClass = [delegate class];
        BOOL ignoreIsRespond = NO;
        if([delegate isKindOfClass:[UITableViewController class]]){
            ignoreIsRespond = YES;
        }
        Class dClass = [SMTableViewSimplifyModel class];
        for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
            SEL originalSelector = selectors[index];
            if(originalSelector == NULL){
                continue;
            }
            SEL swizzleSelector = originalSelector;
            if(ignoreIsRespond || ![kClass instancesRespondToSelector:originalSelector]){
                Method method = class_getInstanceMethod(dClass, swizzleSelector);
                IMP imp = class_getMethodImplementation(dClass, swizzleSelector);
                const char *type =  method_getTypeEncoding(method);
                class_addMethod(kClass, originalSelector, imp,type);
            }
        }
    }
}

@end

