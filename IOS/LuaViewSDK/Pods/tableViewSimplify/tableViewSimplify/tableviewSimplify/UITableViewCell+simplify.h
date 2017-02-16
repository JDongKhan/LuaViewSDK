//
//  UITableViewCell+simplify.h
//  HsCore
//
//  Created by 王金东 on 14/7/28.
//  Copyright (c) 2015年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *@brief 3个控件的文本key
 **/
extern NSString *const HsCellKeyForImageView;
extern NSString *const HsCellKeyForTitleView;
extern NSString *const HsCellKeyForDetailView;
extern NSString *const HsCellKeyAccessoryType;
extern NSString *const HsCellKeyAccessoryView;

/**
 *@brief 样式设置key
 **/
extern NSString *const HsCellColorForTitleView;
extern NSString *const HsCellFontForTitleView;

extern NSString *const HsCellColorForDetailView;
extern NSString *const HsCellFontForDetailView;

extern CGFloat  HsCellDefaultFontForTitleView;
extern CGFloat  HsCellDefaultFontForDetailView;

//用于点击事件
extern NSString *const HsCellKeySelectedBlock;

/**
 *@brief 可以将block放入到cell的数据源中
 **/
typedef void(^OnSelectedRowBlock)(NSIndexPath *indexPath);


@interface UITableViewCell (simplify)


/**
 *@brief 行数据
 **/
@property (nonatomic,strong) id dataInfo;

/**
 *@brief 行数
 **/
@property (nonatomic,strong) NSIndexPath *indexPath;

/**
 *@brief 获取tableview
 **/

@property (nonatomic,weak) UITableView *tableView;

/**
 *@brief 上层的viewcontroller
 **/
@property (nonatomic,weak) UIViewController *baseViewController;

/**
 *@brief 设置默认三个控件取值的key
 *@brief 设置imageView 取值的key
 **/
@property (nonatomic,strong) NSString *keyForImageView;

/**
 *@brief 设置textLabel 取值的key
 **/
@property (nonatomic,strong) NSString *keyForTitleView;

/**
 *@brief 设置detailLabel 取值的key
 **/
@property (nonatomic,strong) NSString *keyForDetailView;

//开启framelayout布局后会根据cell的sizeThatFits方法来得到高度
@property (nonatomic, assign) BOOL enforceFrameLayout;
/**
 *  @author wangjindong
 *
 *  @brief  计算行高 如果你的tableview设置了autoLayout=YES 并且cell是约束布局,则cell的高度不需要你来计算
 *          如果cell是frame布局则需要重写 - (CGSize)sizeThatFits:(CGSize)size 并设置cell的enforceFrameLayout=YES
 *
 *  @param tableView tableview
 *  @param dataInfo
 *
 *  @return
 *
 *  @since
 */
- (CGFloat)tableView:(UITableView *)tableView cellInfo:(id)dataInfo;

@end



/**
 *@brief 为了cell构造数据源方便 增加NSDictionary的Category
 **/
@interface NSDictionary (celldatainfo)

/**
 * 构造数据源
 ** title：对应textLable
 ** imageName：对应imageView
 ** detail：对应detailLabel
 ** block：对应点击行
 **/
+ (instancetype)title:(NSString *)title imageName:(NSString *)imageName  detail:(NSString *)detail selected:(OnSelectedRowBlock)block;

+ (instancetype)title:(NSString *)title imageName:(NSString *)imageName detail:(NSString *)detail;

+ (instancetype)title:(NSString *)title imageName:(NSString *)imageName;

+ (instancetype)title:(NSString *)title imageName:(NSString *)imageName selected:(OnSelectedRowBlock)block;

+ (instancetype)title:(NSString *)title detail:(NSString *)detail;
+ (instancetype)title:(NSString *)title detail:(NSString *)detail selected:(OnSelectedRowBlock)block;


+ (instancetype)title:(NSString *)title;
+ (instancetype)title:(NSString *)title selected:(OnSelectedRowBlock)block;

@end



