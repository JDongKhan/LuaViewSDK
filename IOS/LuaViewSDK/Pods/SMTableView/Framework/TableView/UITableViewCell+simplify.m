//
//  UITableViewCell+simplify.m
//  SMCore
//
//  Created by 王金东 on 15/7/28.
//  Copyright (c) 2015年 王金东. All rights reserved.
//

#import "UITableViewCell+simplify.h"
#import <objc/runtime.h>

NSString *const SMCellKeyForImageView = @"image";
NSString *const SMCellKeyForTitleView = @"title";
NSString *const SMCellKeyForDetailView = @"detail";
NSString *const SMCellKeyAccessoryType = @"accessoryType";
NSString *const SMCellKeyAccessoryView = @"accessoryView";

NSString *const SMCellColorForTitleView = @"titleColor";
NSString *const SMCellFontForTitleView = @"titleFont";

NSString *const SMCellColorForDetailView = @"detailColor";
NSString *const SMCellFontForDetailView = @"detailFont";



NSString *const SMCellKeySelectedBlock = @"onSelected";

CGFloat SMCellDefaultFontForTitleView;
CGFloat SMCellDefaultFontForDetailView;

static const void *tableKeyForTitleView = &tableKeyForTitleView;
static const void *tableKeyForImageView = &tableKeyForImageView;
static const void *tableKeyForDetailView = &tableKeyForDetailView;
static const void *tableKeyForIndexPath = &tableKeyForIndexPath;
static const void *tableKeyForTableView = &tableKeyForTableView;
static const void *tableKeyForBaseViewController= &tableKeyForBaseViewController;
static const void *tableKeyForEnforceFrameLayout = &tableKeyForEnforceFrameLayout;
static const void *tableKeyForDataInfo = &tableKeyForDataInfo;

@implementation UITableViewCell (simplify)


+ (void)initialize {
    SMCellDefaultFontForTitleView = 15;
    SMCellDefaultFontForDetailView = 14;
}


#pragma mark -----------------------------set方法----------------------------------
- (void)setKeyForTitleView:(NSString *)keyForTitleView {
    objc_setAssociatedObject(self, tableKeyForTitleView, keyForTitleView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)keyForTitleView {
    NSString *title =   objc_getAssociatedObject(self, tableKeyForTitleView);
    if (title == nil) {
        return SMCellKeyForTitleView;
    }
    return title;
}

- (void)setKeyForImageView:(NSString *)keyForImageView{
    objc_setAssociatedObject(self, tableKeyForImageView, keyForImageView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)keyForImageView {
    NSString *image = objc_getAssociatedObject(self, tableKeyForImageView);
    if (image == nil) {
        return SMCellKeyForImageView;
    }
    return image;
}

- (void)setKeyForDetailView:(NSString *)keyForDetailView{
    objc_setAssociatedObject(self, tableKeyForDetailView, keyForDetailView, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)keyForDetailView {
    NSString *detail = objc_getAssociatedObject(self, tableKeyForDetailView);
    if (detail == nil) {
        return SMCellKeyForDetailView;
    }
    return detail;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    objc_setAssociatedObject(self, tableKeyForIndexPath, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSIndexPath *)indexPath {
    return  objc_getAssociatedObject(self, tableKeyForIndexPath);
}
- (void)setTableView:(UITableView *)tableView {
    objc_setAssociatedObject(self, tableKeyForTableView, tableView, OBJC_ASSOCIATION_ASSIGN);
}
- (UITableView *)tableView {
    return  objc_getAssociatedObject(self, tableKeyForTableView);
}

- (void)setViewController:(UIViewController *)viewController {
    objc_setAssociatedObject(self, tableKeyForBaseViewController, viewController, OBJC_ASSOCIATION_ASSIGN);
}
- (UIViewController *)viewController {
    return  objc_getAssociatedObject(self, tableKeyForBaseViewController);
}

- (void)setEnforceFrameLayout:(BOOL)enforceFrameLayout {
    objc_setAssociatedObject(self, tableKeyForEnforceFrameLayout, @(enforceFrameLayout), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)enforceFrameLayout {
    return  [objc_getAssociatedObject(self, tableKeyForEnforceFrameLayout) boolValue];
}


#pragma mark ---------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView cellInfo:(id)dataInfo{
    return 44.0f;
}

- (id)dataInfo {
    return  objc_getAssociatedObject(self, tableKeyForDataInfo);
}
- (void)setDataInfo:(id)dataInfo {
    objc_setAssociatedObject(self, tableKeyForDataInfo,dataInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)render:(id)dataInfo{
    if(dataInfo != nil){
        //渲染数据源
        if([dataInfo isKindOfClass:[NSString class]]){
            self.textLabel.text = dataInfo;
            self.textLabel.font = [UIFont systemFontOfSize:SMCellDefaultFontForTitleView];
        }else if([dataInfo isKindOfClass:[NSDictionary class]]){
            NSDictionary *dic = dataInfo;
            id image = dic[self.keyForImageView];
            if([image isKindOfClass:[NSString class]]){
                self.imageView.image = [UIImage imageNamed:image];
            }else if([image isKindOfClass:[UIImage class]]){
                self.imageView.image = image;
            }else{
                self.imageView.image = nil;
            }
            NSString *title = dic[self.keyForTitleView];
            if(title.length > 0){
                self.textLabel.text = title;
            }else{
                self.textLabel.text = nil;
            }
            NSString *detail = dic[self.keyForDetailView];
            if(detail.length > 0){
                self.detailTextLabel.text = detail;
            }else{
                self.detailTextLabel.text = nil;
            }
            //样式设置
            UIColor *titleColor = dic[SMCellColorForTitleView];
            UIFont *titleFont = dic[SMCellFontForTitleView];
            if(titleColor != nil){
                self.textLabel.textColor = titleColor;
            }
            if(titleFont != nil){
                self.textLabel.font = titleFont;
            }else{
                self.textLabel.font = [UIFont systemFontOfSize:SMCellDefaultFontForTitleView];
            }
            
            UIColor *detailColor = dic[SMCellColorForDetailView];
            UIFont *detailfont = dic[SMCellFontForDetailView];
            if(detailColor != nil){
                self.detailTextLabel.textColor = detailColor;
            }
            if(detailfont != nil){
                self.detailTextLabel.font = detailfont;
            }else{
                self.detailTextLabel.font = [UIFont systemFontOfSize:SMCellDefaultFontForDetailView];
            }
            NSInteger type = [dataInfo[SMCellKeyAccessoryType] integerValue];
            if (type > 0) {
                self.accessoryType = type;
            }
            UIView *view = dataInfo[SMCellKeyAccessoryView];
            self.accessoryView = view;
        }else if([dataInfo isKindOfClass:[NSArray class]]){
            //TODO 暂不处理
        }else{
            id image = [dataInfo valueForKey:self.keyForImageView];
            if([image isKindOfClass:[NSString class]]){
                self.imageView.image = [UIImage imageNamed:image];
            }else if([image isKindOfClass:[UIImage class]]){
                self.imageView.image = image;
            }else{
                self.imageView.image = nil;
            }
            NSString *title = [dataInfo valueForKey:self.keyForTitleView];
            if(title.length > 0){
                self.textLabel.text = title;
            }else{
                self.textLabel.text = nil;
            }
            NSString *detail = [dataInfo valueForKey:self.keyForDetailView];
            if(detail.length > 0){
                self.detailTextLabel.text = detail;
            }else{
                self.detailTextLabel.text = nil;
            }
            self.textLabel.font = [UIFont systemFontOfSize:SMCellDefaultFontForTitleView];
            self.detailTextLabel.font = [UIFont systemFontOfSize:SMCellDefaultFontForDetailView];
        }
    }
}

@end


/**
 ** 为了cell构造数据源方便 增加NSDictionary的Category
 **/
@implementation NSDictionary (_cellDatainfo)

+ (instancetype)title:(NSString *)title imageName:(NSString *)imageName detail:(NSString *)detail selected:(OnSelectedRowBlock)block{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:title forKey:SMCellKeyForTitleView];
    [dic setValue:imageName forKey:SMCellKeyForImageView];
    [dic setValue:detail forKey:SMCellKeyForDetailView];
    [dic setValue:block forKey:SMCellKeySelectedBlock];
    return dic;
}

+ (instancetype)title:(NSString *)title imageName:(NSString *)imageName detail:(NSString *)detail{
    return [self title:title imageName:imageName detail:detail selected:nil];
}

+ (instancetype)title:(NSString *)title imageName:(NSString *)imageName{
    return [self title:title imageName:imageName detail:nil];
}

+ (instancetype)title:(NSString *)title imageName:(NSString *)imageName selected:(OnSelectedRowBlock)block{
    return [self title:title imageName:imageName detail:nil selected:block];
}

+ (instancetype)title:(NSString *)title detail:(NSString *)detail selected:(OnSelectedRowBlock)block{
    return [self title:title imageName:nil detail:detail selected:block];
}

+ (instancetype)title:(NSString *)title selected:(OnSelectedRowBlock)block{
    return [self title:title imageName:nil detail:nil selected:block];
}

+ (instancetype)title:(NSString *)title detail:(NSString *)detail{
    return [self title:title imageName:nil detail:detail];
}

+ (instancetype)title:(NSString *)title{
    return [self title:title imageName:nil];
}

@end

