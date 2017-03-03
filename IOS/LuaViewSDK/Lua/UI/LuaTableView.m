//
//  LuaTableView.m
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/3.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "LuaTableView.h"
#import <tableViewSimplify/UITableView+simplify.h>
#import <tableViewSimplify/UITableViewCell+simplify.h>
#import "LSCTableViewCell.h"
#import "LSCValue.h"

static NSString *const _cellID = @"baseCellID";


@interface LuaTableView ()<HsBaseTableViewDelegate,HsBaseTableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *luaNames;
@property (nonatomic,strong) NSMutableDictionary *luaTableViewCellDic;

@property (nonatomic,strong) LSCFunction *itemClick;

@property (nonatomic,strong) LSCFunction *layoutIndex;

@end

@implementation LuaTableView

- (instancetype)init {
    if (self == [super init]) {
        self.luaTableViewCellDic = [NSMutableDictionary dictionary];
        self.tableView = [[UITableView alloc] init];
        self.tableView.baseDelegate = self;
        self.tableView.baseDataSource = self;
        super._view = self.tableView;
        self.tableView.enableSimplify = YES;
    }
    return self;
}


- (void)setCell:(NSString *)luaName {
    NSArray *ls = @[luaName];
    self.luaNames = ls;
    LSCTableViewCell *cell = [[LSCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellID luaName:luaName luaViewController:self.vc];
    [self.luaTableViewCellDic setObject:cell forKey:luaName];
}
- (void)setCells:(NSArray *)luaNames {
    self.luaNames = luaNames;
    for (NSString *luaName in luaNames) {
        LSCTableViewCell *cell = [[LSCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellID luaName:luaName luaViewController:self.vc];
        [self.luaTableViewCellDic setObject:cell forKey:luaName];
    }
}
- (void)setItems:(NSArray *)items {
    NSMutableArray *array = [NSMutableArray arrayWithArray:items];
    self.tableView.itemsArray = array;
   
    [self.tableView reloadData];
}
- (void)setItemClick:(LSCFunction *)itemClick {
    _itemClick = itemClick;
}
- (void)setLayoutIndex:(LSCFunction *)layoutIndex{
    _layoutIndex = layoutIndex;
}

- (void)setHiddenDivider:(BOOL)hidden {
    if (hidden) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }else{
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}




/****************************************************************/

//获取当前数据，分组与不分组的数据
- (id)dataInfoforCellatTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath{
    if(tableView.itemsArray.count == 0){
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id dataInfo = [self dataInfoforCellatTableView:tableView IndexPath:indexPath];
    //HSLog(@"渲染第%d块，第%d行",indexPath.section,indexPath.row);
    //生成cellid
    NSInteger type = [self tableView:tableView typeForRowAtIndexPath:indexPath];
    if(self.layoutIndex != nil && ![self.layoutIndex isKindOfClass:[NSNull class]]){
        LSCValue *v = [self.layoutIndex invokeWithArguments:@[[LSCValue integerValue:indexPath.row]]];
        type = v.toInteger;
    }
    NSString *luaName = [self.luaNames objectAtIndex:type];
    LSCTableViewCell *cell = [self.luaTableViewCellDic valueForKey:luaName];
    if(cell != nil){
        cell.indexPath = indexPath;
        //给cell的dataInfo赋值,并计算高度
        return [cell tableView:tableView cellInfo:dataInfo];
    }else{
        return 44.0f;
    }    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id dataInfo = [self dataInfoforCellatTableView:tableView IndexPath:indexPath];
    //HSLog(@"渲染第%d块，第%d行",indexPath.section,indexPath.row);
    //生成cellid
    NSInteger type = [self tableView:tableView typeForRowAtIndexPath:indexPath];
    if(self.layoutIndex != nil && ![self.layoutIndex isKindOfClass:[NSNull class]]){
        LSCValue *v = [self.layoutIndex invokeWithArguments:@[[LSCValue integerValue:indexPath.row]]];
        type = v.toInteger;
    }
    NSString *luaName = [self.luaNames objectAtIndex:type];
    NSString *cellID = [_cellID stringByAppendingFormat:@"_%ld",(long)type];
    LSCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil){
        //给个默认的class
        cell = [[LSCTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID luaName:luaName luaViewController:self.vc];
    }
    
    //把行信息也传递给cell 方便后者使用
    cell.indexPath = indexPath;
    //cell.baseViewController = self.baseViewController; //传入顶层的 HsBaseViewController
    //cell.keyForTitleView = self.keyForTitleView;   //传入 健的title
    //cell.keyForDetailView = self.keyForDetailView; //传入详情 健的detail
    //cell.keyForImageView = self.keyForImageView;   //传入图片健的 image图片
    cell.tableView = self.tableView;
    cell.dataInfo = dataInfo; //传入当前数据源
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_itemClick) {
        NSMutableArray *v = [[NSMutableArray alloc] init];
        [v addObject:[LSCValue integerValue:indexPath.row]];
        [_itemClick invokeWithArguments:v];
    }
}

// HsBaseTableViewDataSource  返回的是cell  Array的索引位置
- (NSInteger)tableView:(UITableView *)tableView typeForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView.tableViewCellArray != nil){
        id dataInfo = [self dataInfoforCellatTableView:tableView IndexPath:indexPath];
        if([dataInfo isKindOfClass:[NSDictionary class]]){
            NSInteger type = [dataInfo[HsBaseTableViewKeyTypeForRow] integerValue];
            if(type >= tableView.tableViewCellArray.count){//如果得到的type大于数组的长度 则默认等于0位置的type
                type = 0;
            }
            return type;
        }
    }
    return 0;
}
@end
