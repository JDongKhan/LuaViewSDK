//
//  UITableView+simplify.m
//  HsCore
//
//  Created by 王金东 on 14/7/28.
//  Copyright (c) 2015年 王金东. All rights reserved.
//

#import "UITableView+simplify.h"
#import "UITableViewCell+simplify.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>
#import <objc/runtime.h>
#import "HsBaseRefreshManager.h"

static NSString *const _cellID = @"baseCellID";
NSString *const HsBaseTableViewKeyTypeForRow = @"typeForRow";

//数据委托
static const void *tableViewKeyForBaseDelegate = &tableViewKeyForBaseDelegate;
static const void *tableViewKeyForBaseDataSource = &tableViewKeyForBaseDataSource;

//属性
static const void *tableViewKeyForKeyOfItemArray = &tableViewKeyForKeyOfItemArray;
static const void *tableViewKeyForSectionable = &tableViewKeyForSectionable;
static const void *tableViewKeyForTitleView = &tableViewKeyForTitleView;
static const void *tableViewKeyForImageView = &tableViewKeyForImageView;
static const void *tableViewKeyForDetailView = &tableViewKeyForDetailView;
static const void *tableViewKeyForkeyOfHeadTitle = &tableViewKeyForkeyOfHeadTitle;
static const void *tableViewKeyForIndexPath = &tableViewKeyForIndexPath;
static const void *tableViewKeyForTableView = &tableViewKeyForTableView;
static const void *tableViewKeyForBaseViewController= &tableViewKeyForBaseViewController;
static const void *tableViewKeyForTableViewCellStyle= &tableViewKeyForTableViewCellStyle;
static const void *tableViewKeyForFirstSectionHeaderHeight = &tableViewKeyForFirstSectionHeaderHeight;
static const void *tableViewKeyForSectionIndexTitles = &tableViewKeyForSectionIndexTitles;
static const void *tableViewKeyForClearsSelectionDelay = &tableViewKeyForClearsSelectionDelay;
static const void *tableViewKeyForTableViewCell = &tableViewKeyForTableViewCell;
static const void *tableViewKeyForTableViewCellArray = &tableViewKeyForTableViewCellArray;
static const void *tableViewKeyForItemArray = &tableViewKeyForItemArray;
static const void *tableViewKeyForAutoLayout = &tableViewKeyForAutoLayout;

//category
static const void *tableViewKeyForRefreshDelegate = &tableViewKeyForRefreshDelegate;
static const void *tableViewKeyForHeaderRefresh = &tableViewKeyForHeaderRefresh;
static const void *tableViewKeyForFooterRefresh = &tableViewKeyForFooterRefresh;
static const void *tableViewKeyForEditeable = &tableViewKeyForEditeable;
static const void *tableViewKeyForSigleLineEdite = &tableViewKeyForSigleLineEdite;
static const void *tableViewKeyForMultiLineEdite = &tableViewKeyForMultiLineEdite;
static const void *tableViewKeyForCanEditable = &tableViewKeyForCanEditable;
static const void *tableViewKeyForEnableSimplify = &tableViewKeyForEnableSimplify;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprotocol"
@implementation UITableView (simplify)
#pragma clang diagnostic pop

//刷新数据 与界面，如没有数据，就清空界面
- (void)reloadDataWithEmptyView{
    [self reloadData];
    if(self.itemsArray.count == 0){
      //  [self showEmptyView];   //清空，加载一张默认图
    }
}


#pragma mark -----------------------------set方法----------------------------------
- (void)setEnableSimplify:(BOOL)enableSimplify{
    objc_setAssociatedObject(self, tableViewKeyForEnableSimplify, @(enableSimplify), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)enableSimplify {
    return  [objc_getAssociatedObject(self, tableViewKeyForEnableSimplify) boolValue];
}
//委托
- (void)setBaseDelegate:(id<HsBaseTableViewDelegate>)baseDelegate{
    objc_setAssociatedObject(self, tableViewKeyForBaseDelegate, baseDelegate, OBJC_ASSOCIATION_ASSIGN);
}
- (id<HsBaseTableViewDelegate>)baseDelegate {
    return  objc_getAssociatedObject(self, tableViewKeyForBaseDelegate);
}
- (void)setBaseDataSource:(id<HsBaseTableViewDataSource>)baseDataSource{
    objc_setAssociatedObject(self, tableViewKeyForBaseDataSource, baseDataSource, OBJC_ASSOCIATION_ASSIGN);
}
- (id<HsBaseTableViewDataSource>)baseDataSource {
    return  objc_getAssociatedObject(self, tableViewKeyForBaseDataSource);
}

//默认cell中title的key
- (void)setKeyForTitleView:(NSString *)keyForTitleView {
    objc_setAssociatedObject(self, tableViewKeyForTitleView, keyForTitleView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)keyForTitleView {
    NSString *title =   objc_getAssociatedObject(self, tableViewKeyForTitleView);
    if (title == nil) {
        return HsCellKeyForTitleView;
    }
    return title;
}
//默认cell中image的key
- (void)setKeyForImageView:(NSString *)keyForImageView{
    objc_setAssociatedObject(self, tableViewKeyForImageView, keyForImageView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)keyForImageView {
    NSString *image = objc_getAssociatedObject(self, tableViewKeyForImageView);
    if (image == nil) {
        return HsCellKeyForImageView;
    }
    return image;
}
//默认cell中detail的key
- (void)setKeyForDetailView:(NSString *)keyForDetailView{
    objc_setAssociatedObject(self, tableViewKeyForDetailView, keyForDetailView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)keyForDetailView {
    NSString *detail = objc_getAssociatedObject(self, tableViewKeyForDetailView);
    if (detail == nil) {
        return HsCellKeyForDetailView;
    }
    return detail;
}

//分组的标题key
- (void)setKeyOfHeadTitle:(NSString *)keyOfHeadTitle {
    objc_setAssociatedObject(self, tableViewKeyForkeyOfHeadTitle, keyOfHeadTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)keyOfHeadTitle {
    return  objc_getAssociatedObject(self, tableViewKeyForkeyOfHeadTitle);
}

//二级数组里第二级数组的key
- (void)setKeyOfItemArray:(NSString *)keyOfItemArray{
    objc_setAssociatedObject(self, tableViewKeyForKeyOfItemArray, keyOfItemArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)keyOfItemArray {
    NSString *image = objc_getAssociatedObject(self, tableViewKeyForKeyOfItemArray);
    if (image == nil) {
        return @"items";
    }
    return image;
}

//baseviewcontroller
- (void)setBaseViewController:(UIViewController *)baseViewController  {
    objc_setAssociatedObject(self, tableViewKeyForBaseViewController, baseViewController, OBJC_ASSOCIATION_ASSIGN);
}
- (UIViewController *)baseViewController {
    return  objc_getAssociatedObject(self, tableViewKeyForBaseViewController);
}
//tableview的类型
- (void)setTableViewCellStyle:(UITableViewCellStyle)tableViewCellStyle {
    objc_setAssociatedObject(self, tableViewKeyForTableViewCellStyle, @(tableViewCellStyle), OBJC_ASSOCIATION_ASSIGN);
}
- (UITableViewCellStyle)tableViewCellStyle {
    return  [objc_getAssociatedObject(self, tableViewKeyForTableViewCellStyle) integerValue];
}

//第一块的head高
- (void)setFirstSectionHeaderHeight:(CGFloat)firstSectionHeaderHeight {
    objc_setAssociatedObject(self, tableViewKeyForFirstSectionHeaderHeight, @(firstSectionHeaderHeight), OBJC_ASSOCIATION_ASSIGN);
}
- (CGFloat)firstSectionHeaderHeight {
    return  [objc_getAssociatedObject(self, tableViewKeyForFirstSectionHeaderHeight) floatValue];
}
//右侧索引的数组
- (void)setSectionIndexTitles:(NSArray *)sectionIndexTitles {
    objc_setAssociatedObject(self, tableViewKeyForSectionIndexTitles, sectionIndexTitles, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSArray *)sectionIndexTitles {
    return  objc_getAssociatedObject(self, tableViewKeyForSectionIndexTitles);
}
//开启延迟取消选中的背景
- (void)setClearsSelectionDelay:(BOOL)clearsSelectionDelay {
    objc_setAssociatedObject(self, tableViewKeyForClearsSelectionDelay, @(clearsSelectionDelay), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)clearsSelectionDelay {
    return  [objc_getAssociatedObject(self, tableViewKeyForClearsSelectionDelay) boolValue];
}
//是否分块
- (void)setSectionable:(BOOL)sectionable {
    objc_setAssociatedObject(self, tableViewKeyForSectionable, @(sectionable), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)sectionable {
    return  [objc_getAssociatedObject(self, tableViewKeyForSectionable) boolValue];
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
         objc_setAssociatedObject(self, tableViewKeyForTableViewCellArray, tableViewCellArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
    NSMutableArray *array = itemsArray;
    if([itemsArray isMemberOfClass:[NSArray class]]){
        array = [NSMutableArray arrayWithArray:itemsArray];
    }
    if (self.enableSimplify) {
        self.dataSource = self;
        self.delegate = self;        //委托事件
    }
    objc_setAssociatedObject(self, tableViewKeyForItemArray, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)itemsArray{
   NSMutableArray *array = objc_getAssociatedObject(self, tableViewKeyForItemArray);
    if (array == nil) {
        array = [NSMutableArray array];
        self.itemsArray = array;
    }
    return array;
}
- (void)setAutoLayout:(BOOL)autoLayout{
    objc_setAssociatedObject(self, tableViewKeyForAutoLayout, @(autoLayout), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)autoLayout {
    return [objc_getAssociatedObject(self, tableViewKeyForAutoLayout) boolValue];
}


@end



#pragma mark ---------------------我是分割线------------------------------
#pragma mark ----------下面是重写TableView的dataSource-------------------------
@interface  UITableView (baseDataSource)
@end

@implementation UITableView (baseDataSource)

// HsBaseTableViewDataSource  返回的是cell  Array的索引位置
- (NSInteger)tableView:(UITableView *)tableView typeForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.tableViewCellArray != nil){
        if (tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(tableView:typeForRowAtIndexPath:)]) {
            return [tableView.baseDataSource tableView:tableView typeForRowAtIndexPath:indexPath];
        }else{
            id dataInfo = [self dataInfoforCellatTableView:tableView IndexPath:indexPath];
            if([dataInfo isKindOfClass:[NSDictionary class]]){
                NSInteger type = [dataInfo[HsBaseTableViewKeyTypeForRow] integerValue];
                if(type >= self.tableViewCellArray.count){//如果得到的type大于数组的长度 则默认等于0位置的type
                    type = 0;
                }
                return type;
            }
        }
    }
    return 0;
}

#pragma mark - UITableView DataSource
//分组数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //自定义
    if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]){
        return [tableView.baseDataSource numberOfSectionsInTableView:tableView];
    }
    if(tableView.sectionable){//分块 二维数组
        return tableView.itemsArray.count;
    }
    return 1;
}

//加enableForSearchTableView这个判断 是因为处于查询的时候tableview变了 每组中有几条数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //自定义
    if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]){
        return [tableView.baseDataSource tableView:tableView numberOfRowsInSection:section];
    }
    if(tableView.sectionable && tableView.itemsArray.count > 0){//分块 二维数组
        id cellInfo = tableView.itemsArray[section];
        if([cellInfo isKindOfClass:[NSArray class]]){
            return [(NSArray *)cellInfo count];
        }else{
            NSArray *array = [cellInfo valueForKey:tableView.keyOfItemArray];
            if(array != nil && [array isKindOfClass:[NSArray class]]){
                return  [array count];
            }
        }
        return 0;
    }
    return tableView.itemsArray.count;
}


//加入右侧索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    //自定义
    if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(sectionIndexTitlesForTableView:)]){
        return [tableView.baseDataSource sectionIndexTitlesForTableView:tableView];
    }
    return tableView.sectionIndexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    if (self.baseDataSource && [self.baseDataSource respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)]) {
        return [self.baseDataSource tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
    }
    return -1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //自定义
    if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]){
        return [tableView.baseDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    id dataInfo = [self dataInfoforCellatTableView:tableView IndexPath:indexPath];
    //HSLog(@"渲染第%d块，第%d行",indexPath.section,indexPath.row);
    //生成cellid
    NSInteger type = [self tableView:tableView typeForRowAtIndexPath:indexPath];
    if([dataInfo isKindOfClass:[NSDictionary class]] && [dataInfo objectForKey:HsBaseTableViewKeyTypeForRow]){
        type = [dataInfo[HsBaseTableViewKeyTypeForRow] integerValue];
    }
    NSString *cellID = [_cellID stringByAppendingFormat:@"_%ld",(long)type];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil){
        //给个默认的class
        cell = [[UITableViewCell alloc] initWithStyle:self.tableViewCellStyle reuseIdentifier:cellID];
    }
    NSAssert([cell isKindOfClass:[UITableViewCell class]], @"cell必须是UITableViewCell的子类");
    //把行信息也传递给cell 方便后者使用
    cell.indexPath = indexPath;
    cell.baseViewController = self.baseViewController; //传入顶层的 HsBaseViewController
    cell.keyForTitleView = self.keyForTitleView;   //传入 健的title
    cell.keyForDetailView = self.keyForDetailView; //传入详情 健的detail
    cell.keyForImageView = self.keyForImageView;   //传入图片健的 image图片
    
    if(tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(tableView:accessoryTypeForRowWithIndexPath:)]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        cell.accessoryType = [tableView.baseDelegate tableView:tableView accessoryTypeForRowWithIndexPath:indexPath];
#pragma clang diagnostic pop
    }
    cell.tableView = self;
    cell.dataInfo = dataInfo; //传入当前数据源
    //设置行样式
    [self tableView:tableView cellStyleForRowAtIndexPath:cell];
    return cell;
}


// 可根据行设置行样式  可自定义
- (void)tableView:(UITableView *)tableView cellStyleForRowAtIndexPath:(UITableViewCell *)cell{
    if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(tableView:cellStyleForRowAtIndexPath:)]){
        [tableView.baseDataSource tableView:tableView cellStyleForRowAtIndexPath:cell];
    }
}


//头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]){
        return [tableView.baseDataSource tableView:tableView titleForHeaderInSection:section];
    }else{
        if(self.keyOfHeadTitle.length > 0){
            return self.itemsArray[section][self.keyOfHeadTitle];
        }
    }
    return nil;
}
//脚部标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(tableView:titleForFooterInSection:)]){
        return [tableView.baseDataSource tableView:tableView titleForFooterInSection:section];
    }
    return nil;
}

//获取当前数据，分组与不分组的数据
- (id)dataInfoforCellatTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath{
    if(self.itemsArray.count == 0){
        return nil;
    }
    id dataInfo = nil;
    //设置数据源给tableviewcell
    if(tableView.sectionable){//分块
        id cellInfo = tableView.itemsArray[indexPath.section];
        if([cellInfo isKindOfClass:[NSArray class]]){
            dataInfo = cellInfo[indexPath.row];
        }else {
            NSArray *array = [cellInfo valueForKey:tableView.keyOfItemArray];
            if(array != nil && [array isKindOfClass:[NSArray class]]){
                dataInfo = array[indexPath.row];
            }
        }
    }else{
        dataInfo = tableView.itemsArray[indexPath.row];
    }
    return dataInfo;
}

@end

#pragma mark ---------------------我是分割线------------------------------
#pragma mark ----------下面是重写TableView的delegate-------------------------
@interface UITableView (baseDelegate)
@end
@implementation UITableView (baseDelegate)
//选中cell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.clearsSelectionDelay){
      //  [tableView deselectCurrentRow];
    }
    //自定义
    if(tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]){
        return [tableView.baseDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }else{
        id dataInfo = [self dataInfoforCellatTableView:tableView IndexPath:indexPath];
        if ([dataInfo isKindOfClass:[NSDictionary class]]) {
            OnSelectedRowBlock block = dataInfo[HsCellKeySelectedBlock];
            if(block != nil){
                block(indexPath);
            }
        }
    }
}

//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.autoLayout) {
        id dataInfo = [self dataInfoforCellatTableView:tableView IndexPath:indexPath];
        NSInteger type = [self tableView:tableView typeForRowAtIndexPath:indexPath];
        if([dataInfo isKindOfClass:[NSDictionary class]] && [dataInfo objectForKey:HsBaseTableViewKeyTypeForRow]){
            type = [dataInfo[HsBaseTableViewKeyTypeForRow] integerValue];
        }
        NSString *cellID = [_cellID stringByAppendingFormat:@"_%ld",(long)type];
        __weak UITableView *weakSelf = self;
        return [tableView fd_heightForCellWithIdentifier:cellID cacheByIndexPath:indexPath configuration:^(UITableViewCell *cell) {
            cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
            cell.indexPath = indexPath;
            cell.keyForTitleView = weakSelf.keyForTitleView;
            cell.keyForDetailView = weakSelf.keyForDetailView;
            cell.keyForImageView = weakSelf.keyForImageView;
            cell.dataInfo = dataInfo;
        }];
        return  -1.0f;
    }
    //HSLog(@"计算第%d块，第%d行行高",indexPath.section,indexPath.row);
    if(tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]){
        return [tableView.baseDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }else{
        //将计算高度的方法交给cell来处理
        //生成cellid
        id dataInfo = [self dataInfoforCellatTableView:tableView IndexPath:indexPath];
        //HSLog(@"渲染第%d块，第%d行",indexPath.section,indexPath.row);
        //生成cellid
        NSInteger type = [self tableView:tableView typeForRowAtIndexPath:indexPath];
        if([dataInfo isKindOfClass:[NSDictionary class]] && [dataInfo objectForKey:HsBaseTableViewKeyTypeForRow]){
            type = [dataInfo[HsBaseTableViewKeyTypeForRow] integerValue];
        }
        
        NSString *cellID = [_cellID stringByAppendingFormat:@"_%ld",(long)type];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if(cell != nil){
            cell.indexPath = indexPath;
            cell.keyForTitleView = self.keyForTitleView;
            cell.keyForDetailView = self.keyForDetailView;
            cell.keyForImageView = self.keyForImageView;
            //给cell的dataInfo赋值,并计算高度
            return [cell tableView:tableView cellInfo:dataInfo];
        }else{
            return 44.0f;
        }
    }
}

//头的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]){
        return [tableView.baseDelegate tableView:tableView heightForHeaderInSection:section];
    }else if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]){
        NSString *title = [tableView.baseDataSource tableView:tableView titleForHeaderInSection:section];
        if(title != nil){
            return -1.0f;
        }
    }else{
        if(self.keyOfHeadTitle.length > 0){
            return -1.0f;
        }
    }
    if(section == 0){
        return self.firstSectionHeaderHeight;
    }
    return -1.0f;
}
//脚的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]){
        return [tableView.baseDelegate tableView:tableView heightForFooterInSection:section];
    }else if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(tableView:titleForFooterInSection:)]){
        NSString *title = [tableView.baseDataSource tableView:tableView titleForFooterInSection:section];
        if(title != nil){
            return -1.0f;
        }
    }
    return -1.0f;
}
//组的头 view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]){
        return [tableView.baseDelegate tableView:tableView viewForHeaderInSection:section];
    }else if(tableView.baseDataSource && [tableView.baseDataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]){
        //如果设置了 title，则不重写head
        return nil;
    }else{//如果不自定义headview并且也没设置title，则给个透明的headview 不然设置了firstSectionHeaderHeight后第一块headview会出现被挡住的效果
        if(self.keyOfHeadTitle == nil){
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, self.firstSectionHeaderHeight)];
            view.backgroundColor = [UIColor clearColor];
            return view;
        }
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]){
        return [tableView.baseDelegate tableView:tableView viewForFooterInSection:section];
    }
    return nil;
}


// Display customization
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]){
        return [tableView.baseDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0) {
    if(tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]){
        return [tableView.baseDelegate tableView:tableView willDisplayHeaderView:view forSection:section];
    }
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0) {
    if(tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)]){
        return [tableView.baseDelegate tableView:tableView willDisplayFooterView:view forSection:section];
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0) {
    if(tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]){
        return [tableView.baseDelegate tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0) {
    if(tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)]){
        return [tableView.baseDelegate tableView:tableView didEndDisplayingHeaderView:view forSection:section];
    }
}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0) {
    if(tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)]){
        return [tableView.baseDelegate tableView:tableView didEndDisplayingFooterView:view forSection:section];
    }
}

#pragma mark  scrollview delegate

- (void)scrollViewDidScroll:(UITableView *)tableView{
    if([tableView isKindOfClass:[UITableView class]] && tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(scrollViewDidScroll:)]){
        [tableView.baseDelegate scrollViewDidScroll:tableView];
    }
}

- (void)scrollViewWillBeginDragging:(UITableView *)tableView {
    if([tableView isKindOfClass:[UITableView class]] && tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]){
        [tableView.baseDelegate scrollViewWillBeginDragging:tableView];
    }
}
- (void)scrollViewWillEndDragging:(UITableView *)tableView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0) {
    if([tableView isKindOfClass:[UITableView class]] && tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]){
        [tableView.baseDelegate scrollViewWillEndDragging:tableView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewDidEndDragging:(UITableView *)tableView willDecelerate:(BOOL)decelerate {
    if([tableView isKindOfClass:[UITableView class]] && tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]){
        [tableView.baseDelegate scrollViewDidEndDragging:tableView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDecelerating:(UITableView *)tableView {
    if([tableView isKindOfClass:[UITableView class]] && tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]){
        [tableView.baseDelegate scrollViewWillBeginDecelerating:tableView];
    }
}

- (void)scrollViewDidEndDecelerating:(UITableView *)tableView{
    if( [tableView isKindOfClass:[UITableView class]] && tableView.baseDelegate && [tableView.baseDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]){
        [tableView.baseDelegate scrollViewDidEndDecelerating:tableView];
    }
}

@end

#pragma mark ------------------------------------我是分割线------------------------------
#pragma mark ------------------------------------下面是拓展的功能-------------------------
#pragma mark 刷新功能
@implementation UITableView (refreshable)

- (void)setRefreshDelegate:(id<HsBaseTableViewRefreshDelegate>)refreshDelegate{
    objc_setAssociatedObject(self, tableViewKeyForRefreshDelegate, refreshDelegate, OBJC_ASSOCIATION_ASSIGN);
    self.refreshFooterable = self.refreshFooterable;
    self.refreshHeaderable = self.refreshHeaderable;
}

- (id<HsBaseTableViewRefreshDelegate>)refreshDelegate{
    id<HsBaseTableViewRefreshDelegate> delegate = objc_getAssociatedObject(self, tableViewKeyForRefreshDelegate);
    if (delegate == nil) {
        return self;
    }
    return delegate;
}

//设置下拉刷新
- (void)setRefreshHeaderable:(BOOL)refreshHeaderable{
    objc_setAssociatedObject(self, tableViewKeyForHeaderRefresh, @(refreshHeaderable), OBJC_ASSOCIATION_ASSIGN);
    if(refreshHeaderable){
        // 下拉刷新
        [[HsBaseRefreshManager shareInstance] scrollView:self addHeaderWithTarget:self.refreshDelegate action:@selector(headerRereshing)];
    }else{
        [[HsBaseRefreshManager shareInstance] removeHeaderFromScrollView:self];
    }
}
- (BOOL)refreshHeaderable{
    return [objc_getAssociatedObject(self, tableViewKeyForHeaderRefresh) boolValue];
}
- (BOOL)refreshFooterable{
    return [objc_getAssociatedObject(self, tableViewKeyForFooterRefresh) boolValue];
}
//设置上啦加载
- (void)setRefreshFooterable:(BOOL)refreshFooterable{
     objc_setAssociatedObject(self, tableViewKeyForFooterRefresh, @(refreshFooterable), OBJC_ASSOCIATION_ASSIGN);
    if(refreshFooterable){
        // 上拉加载更多
        [[HsBaseRefreshManager shareInstance] scrollView:self addFooterWithTarget:self.refreshDelegate action:@selector(footerRereshing)];
    }else{
        [[HsBaseRefreshManager shareInstance] removeFooterFromScrollView:self];
    }
}
/**
 **开始刷新数据
 **/
- (void)headerRereshing{
    [self didLoaded:HsBaseRefreshTableViewHeader];
}

/**
 **开始加载数据
 **/
- (void)footerRereshing{
    [self didLoaded:HsBaseRefreshTableViewFooter];
}
//加载完调用 子类调用
- (void)didLoaded:(HsBaseRefreshTableViewType)type{
    if(type == HsBaseRefreshTableViewHeader){
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [[HsBaseRefreshManager shareInstance] headerEndRefreshingFromScrollView:self];
    }else{
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [[HsBaseRefreshManager shareInstance] footerEndRefreshingFromScrollView:self];
    }
}

@end




#pragma mark 编辑能力
@implementation UITableView (editable)

- (BOOL)editable{
    return [objc_getAssociatedObject(self, tableViewKeyForEditeable) boolValue];
}
- (void)setEditable:(BOOL)editable {
     objc_setAssociatedObject(self, tableViewKeyForEditeable, @(editable), OBJC_ASSOCIATION_ASSIGN);
}
- (void)setSingleLineDeleteAction:(SingleLineDeleteAction)singleLineDeleteAction{
     objc_setAssociatedObject(self, tableViewKeyForSigleLineEdite, singleLineDeleteAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if(singleLineDeleteAction != nil){
        self.editable = YES;
    }else{
        self.editable = NO;
    }
}
- (SingleLineDeleteAction)singleLineDeleteAction{
    return objc_getAssociatedObject(self, tableViewKeyForSigleLineEdite);
}

- (void)setMultiLineDeleteAction:(MultiLineDeleteAction)multiLineDeleteAction{
    objc_setAssociatedObject(self, tableViewKeyForMultiLineEdite, multiLineDeleteAction, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if(multiLineDeleteAction != nil){
        self.editable = YES;
    }else{
        self.editable = NO;
    }
}
- (MultiLineDeleteAction)multiLineDeleteAction{
    return objc_getAssociatedObject(self, tableViewKeyForMultiLineEdite);
}
- (void)setCanEditable:(CanEditable)canEditable {
     objc_setAssociatedObject(self, tableViewKeyForCanEditable, canEditable, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (CanEditable)canEditable{
    return objc_getAssociatedObject(self, tableViewKeyForCanEditable);
}

#pragma mark 编辑模式

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.canEditable) {
        return self.canEditable(indexPath);
    }
    return self.editable;
}

//编缉按扭样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.multiLineDeleteAction != nil){
        return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.singleLineDeleteAction(indexPath);
    }
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end

