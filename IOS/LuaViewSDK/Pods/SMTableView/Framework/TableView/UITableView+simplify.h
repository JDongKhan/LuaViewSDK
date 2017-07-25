//
//  UITableView+simplify.h
//  SMCore
//
//  Created by 王金东 on 15/7/28.
//  Copyright (c) 2015年 王金东. All rights reserved.
//
//
// 1)、数据源使用
// 1、先给self.itemsArray赋值 （如果你不想定制cell，想用系统的cell，那么不用再看2、3、4步骤）
// 2、设置tableViewCellClass，设置cell类
// 3、建立cell类，需要继承SMBaseTableViewCell
// 4、重写SMTableViewCell的dataInfo的set方法 ，传递过去的数据源可以用于渲染视图
// 5、也可自己实现其他delegate事件，比如点击行

// 以上是基本使用步骤

// 设置多种cell步骤
// 1、先给self.itemsArray赋值
// 2、建立cell类，需要继承SMBaseTableViewCell
// 3、设置self.tableViewCellArray 数组可以是Class 也可以是UInib类
// 4、实现 - (NSUInteger)tableView:(UITableView *)tableView typeForRowAtIndexPath:(NSIndexPath *)indexPath; 返回值是self.tableViewCellArray的索引
// 5、实现 - (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath;
//  可设置cell的AccessoryType
//

// 通过设置self.sectionIndexTitles 可定制右侧索引
//
// 如果你想自定义行 完全可以按照系统默认的写法 ，注意使用self.itemsArray当做数据源即可
// 具体的一些设置参数可以查看下面的头文件中变量的定义

// 如果你是二维数组 则开启sectionable=YES即可
// 其他步骤于上面一样
// 注意如果是数组里面不是NSArray类（比如是NSDictionary ，则我们将NSDictionary中的items字段取出来作为第二级数据）这个key也可以自定义 参看keyOfItemArray的注释

//2)、 下拉刷新\上拉加载
// 开启下拉刷新 参照<SMTableViewRefreshDelegate> 协议
// self.refreshHeaderable = YES; 实现headerRereshing即可
// 开启上拉加载
// self.refreshFooterable = YES; 实现footerRereshing即可
// 刷新完调用  [super didLoaded:SMRefreshTableViewHeader];
//

// 3)、查询功能
// self.searchable = YES;即可开启查询
// 可通过设置searchTableViewCellClass来定制查询界面的cell 步奏同 1）
// 不设置则默认和tableViewCellClass一样
//
// 4)、编辑删除功能
// 多行编辑 self.multiLineDeleteAction = ^(NSArray *indexPaths){}
// 单行编辑 self.singleLineDeleteAction = ^(NSIndexPath *indexPath){}:



#import <UIKit/UIKit.h>
#import "SMTableViewSimplifyModel.h"

extern NSString *const SMTableViewKeyTypeForRow;
extern NSString *const SMTableViewLayoutForRow;
extern NSString *const SMTableViewKeyOfItemArray;

typedef void    (^DidSelectCellBlock)(NSIndexPath *indexPath, id dataInfo) ;
typedef CGFloat (^CellHeightBlock)(NSIndexPath *indexPath, id dataInfo) ;
typedef NSInteger (^CellTypeBlock)(NSIndexPath *indexPath, id dataInfo) ;

typedef void (^TableViewCellConfigureBlock)(UITableViewCell *cell,NSIndexPath *indexPath, id dataInfo) ;

#define UN_IMP_DELEGATE(target) (return (id)target)


//私有
extern NSString *const _cellID;
@interface UITableView (simplify)

@property (nonatomic, assign) BOOL enableSimplify;

/**
 * 通过block对tableview进行配置
 */
@property (nonatomic, copy) DidSelectCellBlock didSelectCellBlock;
@property (nonatomic, copy) CellHeightBlock cellHeightBlock;
@property (nonatomic, copy) CellTypeBlock cellTypeBlock;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;
/**
 *@brief cell的类名或xib'名称
 **/
@property (nonatomic, assign) id tableViewCellClass;

/**
 *@brief cel的类名或xib'名称组成的数组
 **/
@property (nonatomic, strong) NSArray  *tableViewCellArray;

/**
 *@brief 数据源
 */
@property (nonatomic, strong) NSMutableArray *itemsArray;


/**
 *@brief 是否分块
 **/
@property (nonatomic, assign) BOOL sectionable;

@property (nonatomic, assign) BOOL supportHeightCache;

/**
 *@brief 如果itemsArray里面是NSDictionary 则第二级的数组按照keyOfItemArray来取
 * 默认是 items
 **/

@property (nonatomic, strong) NSString *keyOfItemArray;


/**
 *@brief 用取head'title得key
 * 默认是 nil
 **/

@property (nonatomic, strong) NSString *keyOfHeadTitle;

/**
 *@brief 设置默认三个控件取值的key
 * 设置imageView 取值的key
 * 默认是 image
 **/
@property (nonatomic,strong) NSString *keyForImageView;

/**
 *@brief 设置textLabel 取值的key 
 * 默认是 title
 **/
@property (nonatomic,strong) NSString *keyForTitleView;

/**
 *@brief 设置detailLabel 取值的key
 * 默认是 detail
 **/
@property (nonatomic,strong) NSString *keyForDetailView;


//是否支持自动布局,使用UITableView+FDTemplateLayoutCell 自动计算高， 默认不支持
@property (nonatomic,assign) BOOL autoLayout;

/**
 *@brief 延迟一会取消选中状态
 **/
@property(nonatomic) BOOL clearsSelectionDelay;


/**
 *@brief  TableView右边的IndexTitles数据源
 **/
@property (nonatomic, strong) NSArray *sectionIndexTitles;

/**
 *@brief 设置第一个section的的head高度
 **/
@property (nonatomic,assign) CGFloat firstSectionHeaderHeight;

/**
 *@brief 不传cell类型时，可通过设置cell的style来初始化cell
 **/
@property (nonatomic,assign) UITableViewCellStyle tableViewCellStyle;

/**
 *@brief controler
 **/
@property (nonatomic,weak) UIViewController *viewController;

@end




typedef void(^SingleLineDeleteAction) (NSIndexPath *indexPath);
typedef void(^MultiLineDeleteAction) (NSArray *indexPaths);
typedef BOOL(^CanEditable) (NSIndexPath *indexPath);

@interface UITableView (editable)

@property (nonatomic,assign,readonly) BOOL editable;

@property (nonatomic,assign) CanEditable canEditable;

//删除按钮在标题
@property (nonatomic, strong) NSString *deleteConfirmationButtonTitle;

/**
 *@brief 开启多行删除block
 **/
@property(nonatomic,assign) MultiLineDeleteAction multiLineDeleteAction;

/**
 *@brief 设置删除的block后就可以开启编辑部模式
 **/
@property(nonatomic,assign) SingleLineDeleteAction singleLineDeleteAction;

- (void)setMultiLineEditing:(BOOL)editing animated:(BOOL)animated;

@end

