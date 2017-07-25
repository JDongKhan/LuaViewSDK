//
//  SMTableViewSimplifyModel.m
//  SMCore
//
//  Created by 王金东 on 16/1/22.
//  Copyright © 2016年 王金东. All rights reserved.
//

#import "SMTableViewSimplifyModel.h"
#import "SMBlockDescription.h"
#import "UITableViewCell+simplify.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "UITableView+simplify.h"

#define respondsSel(target,sel)  (target && [target respondsToSelector:sel])
#define isTableView(tableView) ([tableView isKindOfClass:[UITableView class]])


@implementation SMTableViewSimplifyModel

static NSString *sm_cellid(NSUInteger type) {
    return [_cellID stringByAppendingFormat:@"_%ld",(long)type];
}

#pragma mark ----------下面是重写TableView的dataSource-------------------------
// SMTableViewDataSource  返回的是cell  Array的索引位置
+ (NSUInteger)tableView:(UITableView *)tableView
 typeForRowAtIndexPath:(NSIndexPath *)indexPath delegate:(id)delegate{
    NSUInteger type = 0;
    if(tableView.tableViewCellArray != nil){
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wundeclared-selector"
        //用户最大，你如果实现了该方法，你说了算
        if(delegate && [delegate respondsToSelector:@selector(tableView:typeForRowAtIndexPath:)]){
            SEL typeFunc = @selector(tableView:typeForRowAtIndexPath:);
            //为什么用objc_msgSend来调用（其实为了装逼），因为Invocation和performSelector代码太长了，毕竟objc_msgSend是基础嘛
            int t = ((int(*)(id,SEL, id,id))objc_msgSend)(delegate, typeFunc, tableView, indexPath);
            return t;
        }
        #pragma clang diagnostic pop
        //你不想做？
        //那剩下的都交给我来做吧，但是还是要你配合
        
        id dataInfo = [SMTableViewSimplifyModel dataInfoforCellatTableView:tableView indexPath:indexPath];
        
        //先去tableView的全局配置
        if(tableView.cellTypeBlock){
            type =  tableView.cellTypeBlock(indexPath,dataInfo);
        }
        //如果section里面配置过，则以section配置为主
        if(tableView.sectionable){
            id sectionData = tableView.itemsArray[indexPath.section];
            if([sectionData isKindOfClass:[NSDictionary class]] && [sectionData objectForKey:SMTableViewKeyTypeForRow]){
                type = [sectionData[SMTableViewKeyTypeForRow] integerValue];
            }
        }
        //如果row里面配置过，则以row为主 其实我不想只处理NSDictionary，还想处理model，但是model里面加这个字段好像不太好
        if([dataInfo isKindOfClass:[NSDictionary class]] && [dataInfo objectForKey:SMTableViewKeyTypeForRow]){
            type = [dataInfo[SMTableViewKeyTypeForRow] integerValue];
        }
        //但是你不能超过cell的种类
        if(type >= tableView.tableViewCellArray.count){//如果得到的type大于数组的长度 则默认等于0位置的type
            type = 0;
        }
    }
    return type;
}

#pragma mark - UITableView DataSource
//分组数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(tableView.sectionable){//分块 二维数组
        return tableView.itemsArray.count;
    }
    return 1;
}

//每组中有几条数据
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //自定义
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
    return tableView.sectionIndexTitles;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //分析数据
    id dataInfo = [SMTableViewSimplifyModel dataInfoforCellatTableView:tableView indexPath:indexPath];
    UITableViewCell *cell = nil;
    //如果你的数据源里面放了一个cell，那么以你的为主，你最大
    if([dataInfo isKindOfClass:[NSDictionary class]] && [dataInfo objectForKey:SMTableViewLayoutForRow]){
        cell = dataInfo[SMTableViewLayoutForRow];
    }else{
        //SMLog(@"渲染第%d块，第%d行",indexPath.section,indexPath.row);
        //生成cellid
        NSUInteger type = [SMTableViewSimplifyModel tableView:tableView typeForRowAtIndexPath:indexPath delegate:self];
        NSString *cellID = sm_cellid(type);
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        //取不到，你竟然没有配置该类型的cell，不过我保你不奔溃
        if(cell == nil){
            //给个默认的class
            cell = [[UITableViewCell alloc] initWithStyle:tableView.tableViewCellStyle reuseIdentifier:cellID];
        }
    }
    NSAssert([cell isKindOfClass:[UITableViewCell class]], @"cell必须是UITableViewCell的子类");
    //下面都是我苦心为你提供的，方便你在cell里面使用，反正你看着用
    cell.indexPath = indexPath;
    cell.viewController = tableView.viewController; //传入顶层的 ViewController
    cell.tableView = tableView;
    cell.dataInfo = dataInfo; //传入当前数据源
    
    //这是你在外面配置的，不过放心都有默认值
    cell.keyForTitleView = tableView.keyForTitleView;   //传入 健的title
    cell.keyForDetailView = tableView.keyForDetailView; //传入详情 健的detail
    cell.keyForImageView = tableView.keyForImageView;   //传入图片健的 image图片
    
    //虽然废弃的方法，但是你不要，我要，我用着舒心就可以，
    //但是你还可以在dataInfo里面指定accessoryType样式哦 ,偷偷告诉你key只要是SMCellKeyAccessoryType就可以了
    if(respondsSel(tableView.delegate,@selector(tableView:accessoryTypeForRowWithIndexPath:))){
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        cell.accessoryType = [tableView.delegate tableView:tableView accessoryTypeForRowWithIndexPath:indexPath];
    #pragma clang diagnostic pop
    }
    //我来帮你处理数据
    [cell render:dataInfo];
    //给你一次自己处理的机会
    if(tableView.configureCellBlock){
        tableView.configureCellBlock(cell,indexPath,dataInfo);
    }
    return cell;
}

//头部标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(tableView.keyOfHeadTitle.length > 0){
        return tableView.itemsArray[section][tableView.keyOfHeadTitle];
    }
    return nil;
}

//获取当前数据，分组与不分组的数据
+ (id)dataInfoforCellatTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
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
            //keyOfItemArray默认为items
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

#pragma mark ---------------------我是分割线------------------------------
+ (void)deselect:(UITableView *)tableView{
     [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}
#pragma mark ----------下面是重写TableView的delegate-------------------------
//选中cell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击过去就会帮你取消点击后的效果
    if(tableView.clearsSelectionDelay){
        [SMTableViewSimplifyModel performSelector:@selector(deselect:) withObject:tableView afterDelay:0.5f];
    }
    
    id dataInfo = [SMTableViewSimplifyModel dataInfoforCellatTableView:tableView indexPath:indexPath];
    //好吧，你最大，你先处理
    if(tableView.didSelectCellBlock) {
        tableView.didSelectCellBlock(indexPath,dataInfo);
    }else{
        //还是以NSDictionary为主来分析，其它model情况太复杂
        if ([dataInfo isKindOfClass:[NSDictionary class]]) {
            id block = dataInfo[SMCellKeySelectedBlock];
            if(block != nil){
                //开始分析block的参数，你可随意设置1个或更多的参数，我来动态处理你的参数
                //不过不能超出[indexPath,tableView,dataInfo]的范围，因为我还在成长
                // allocating a block description
                SMBlockDescription *blockDescription = [[SMBlockDescription alloc] initWithBlock:block];
                // getting a method signature for this block
                NSMethodSignature *methodSignature = blockDescription.blockSignature;
                NSInteger cout = methodSignature.numberOfArguments;
                NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
                [invocation setTarget:[block copy]];
                //NSArray *arguments = @[indexPath,tableView,dataInfo];
                for (NSInteger i = 1; i < cout; i++) {
                    const char *type = [methodSignature getArgumentTypeAtIndex:i];
                    NSString *typeName = [NSString stringWithUTF8String:type];
                    void *arg = &dataInfo;
                    if([typeName isEqualToString:@"@\"NSIndexPath\""]){
                        arg = &indexPath;
                    }else if([typeName isEqualToString:@"@\"UITableView\""]){
                        arg = &tableView;
                    }
                    [invocation setArgument:arg atIndex:i];
                }
                [invocation invoke];
            }
        }
    }
}

//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id dataInfo = [SMTableViewSimplifyModel dataInfoforCellatTableView:tableView indexPath:indexPath];
    //我来看看你是不是要自动计算高
    if (tableView.autoLayout) {
        //
        NSUInteger type = [SMTableViewSimplifyModel tableView:tableView typeForRowAtIndexPath:indexPath delegate:self];
        if([dataInfo isKindOfClass:[NSDictionary class]] && [dataInfo objectForKey:SMTableViewKeyTypeForRow]){
            type = [dataInfo[SMTableViewKeyTypeForRow] integerValue];
        }
        NSString *cellID = sm_cellid(type);
        __weak UITableView *_t = tableView;
        //其实剩下的工作要感谢UITableView+FDTemplateLayoutCell这个作者了，不过我好像没咋实际应用过
        return [tableView fd_heightForCellWithIdentifier:cellID cacheByIndexPath:indexPath configuration:^(UITableViewCell *cell) {
            cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
            cell.indexPath = indexPath;
            cell.keyForTitleView = _t.keyForTitleView;
            cell.keyForDetailView = _t.keyForDetailView;
            cell.keyForImageView = _t.keyForImageView;
            cell.dataInfo = dataInfo;
        }];
    }
    //NSLog(@"计算第%d块，第%d行行高",indexPath.section,indexPath.row);
    //剩下的都是勤快人，自己来设置高度了，还没帮你把高度加入缓存，后续会加入,很抱歉
    if(tableView.cellHeightBlock){
       return tableView.cellHeightBlock(indexPath,dataInfo);
    }else{
        //将计算高度的方法交给cell来处理，cell来做，毕竟cell的高度cell来做不是应该的吗？ 顺便也瘦了vc的身，
        UITableViewCell *cell = nil;
        if([dataInfo isKindOfClass:[NSDictionary class]] && [dataInfo objectForKey:SMTableViewLayoutForRow]){
            cell = dataInfo[SMTableViewLayoutForRow];
        }else{
            //SMLog(@"渲染第%d块，第%d行",indexPath.section,indexPath.row);
            //生成cellid
            NSUInteger type = [SMTableViewSimplifyModel tableView:tableView typeForRowAtIndexPath:indexPath delegate:self];
            if([dataInfo isKindOfClass:[NSDictionary class]] && [dataInfo objectForKey:SMTableViewKeyTypeForRow]){
                type = [dataInfo[SMTableViewKeyTypeForRow] integerValue];
            }
            NSString *cellID = sm_cellid(type);
            cell = [SMTableViewSimplifyModel tableView:tableView templateCellForReuseIdentifier:cellID dataSource:self];
            
        }
        if(cell != nil){
            cell.indexPath = indexPath;
            cell.keyForTitleView = tableView.keyForTitleView;
            cell.keyForDetailView = tableView.keyForDetailView;
            cell.keyForImageView = tableView.keyForImageView;
            //我是来判断是否缓存了高度
            //缓存用的是UITableView+UITableView+FDIndexPathHeightCache,当然感谢作者帮我们做了这个，不然还要自己写缓存 /(ㄒoㄒ)/~~
            if (tableView.supportHeightCache && [tableView.fd_indexPathHeightCache existsHeightAtIndexPath:indexPath]) {
                return [tableView.fd_indexPathHeightCache heightForIndexPath:indexPath];
            }
            //给cell的dataInfo赋值,并计算高度
            CGFloat height =  [cell tableView:tableView cellInfo:dataInfo];
            if(tableView.supportHeightCache){
                [tableView.fd_indexPathHeightCache cacheHeight:height byIndexPath:indexPath];
            }
            return height;
        }
    }
    
    //默认44应该不难理解吧
    return 44.0f;
}



//根据identifier获取临时tableviewcell用于临时计算
+ (__kindof UITableViewCell *)tableView:(UITableView *)tableView templateCellForReuseIdentifier:(NSString *)identifier dataSource:(id)dataSource{
    NSAssert(identifier.length > 0, @"identifier:%@ is empty", identifier);
    
    NSMutableDictionary<NSString *, UITableViewCell *> *templateCellsByIdentifiers = objc_getAssociatedObject(dataSource, _cmd);
    if (!templateCellsByIdentifiers) {
        templateCellsByIdentifiers = @{}.mutableCopy;
        objc_setAssociatedObject(dataSource, _cmd, templateCellsByIdentifiers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    UITableViewCell *templateCell = templateCellsByIdentifiers[identifier];
    [templateCell prepareForReuse];//放回重用池
    if (!templateCell) {
        templateCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (templateCell) {
           templateCellsByIdentifiers[identifier] = templateCell;
        }
    }
    return templateCell;
}


//- (void)dealloc {
//    NSLog(@"SMTableViewSimplifyModel dealloc");
//}


@end



#pragma mark 编辑能力
@implementation SMTableViewSimplifyModel (editable)
#pragma mark 编辑模式

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    //依然你最大，你来决定是否能编辑
    if (tableView.canEditable) {
        return tableView.canEditable(indexPath);
    }
    return tableView.editable;
}

//编缉按扭样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置删除多行
    if(tableView.multiLineDeleteAction != nil){
        return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    //那个删除的text你不高兴可以自己来设置
    if(tableView.deleteConfirmationButtonTitle != nil){
        return tableView.deleteConfirmationButtonTitle;
    }
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        tableView.singleLineDeleteAction(indexPath);
    }
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
