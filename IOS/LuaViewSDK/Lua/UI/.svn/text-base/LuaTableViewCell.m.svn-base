//
//  LuaTableViewCell.m
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/3.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "LuaTableViewCell.h"
#import "LuaScriptCoreManager.h"
#import "LuaLabel.h"
#import "Bundle.h"

@interface LuaTableViewCell ()

@property (nonatomic,strong) LSCFunction *loadView;
@property (nonatomic,strong) LSCFunction *loadData;
@property (nonatomic,strong) LSCFunction *cellHeight;
@property (nonatomic,strong) LuaLabel *lable;

@end
@implementation LuaTableViewCell


- (void)_onCreate {
    self.contentView = [[LuaView alloc] init];
    self.contentView.tag = @"cell_contentView";
    [self.contentView setBackgroundColor:@"#00000000"];
    [self.contentView setLayoutType:Relative_layout];
    if (self.luaName == nil) {
        self.lable = [[LuaLabel alloc] init];
        [self.lable setFrame:@[@10,@0,@320,@44]];
        [self.lable setTextColor:@"#000000"];
        [self.contentView addSubView:self.lable];
    }else{
        NSString *fileString = [Bundle luaScript:self.luaName];
        NSString *methodName = [NSString stringWithFormat:@"%@_%ld",[[self.luaName lastPathComponent] stringByDeletingPathExtension],[self hash]];
        NSString *luaScript = [NSString stringWithFormat:@"function %@(this) %@  return loadView,loadData,cellHeight end",methodName,fileString];
        [[LuaScriptCoreManager shareInstance] evalScriptFromString:luaScript];

        NSMutableArray *param = [NSMutableArray array];
        [param addObject:[LSCValue objectValue:self]];
        LSCValue *value =  [[LuaScriptCoreManager shareInstance] callMethodWithName:methodName arguments:param];
        LSCTuple *tuple = [value toTuple];
        self.loadView = [tuple returnValueForIndex:0];
        self.loadData = [tuple returnValueForIndex:1];
        self.cellHeight = [tuple returnValueForIndex:2];
        NSAssert(![self.loadView isKindOfClass:[NSNull class]], @"loadView 不能为空");
        NSAssert(![self.loadData isKindOfClass:[NSNull class]], @"loadData 不能为空");
        NSAssert(![self.cellHeight isKindOfClass:[NSNull class]], @"cellHeight 不能为空");
        
        NSMutableArray *v = [NSMutableArray array];
        [v addObject:[LSCValue objectValue:self.contentView]];
        [self.loadView invokeWithArguments:v];
    }
}


- (void)setBackgroundColor:(NSString *)backgroundColor {
    _backgroundColor = backgroundColor;
    self.contentView.backgroundColor = backgroundColor;
}

- (void)addSubView:(LuaView *)view {
    [self.contentView addSubView:view];
}
- (void)removeSubView:(LuaView *)view {
    [self.contentView removeSubView:view];
}

- (void)reLayout {
    [self.contentView reLayout];
}
- (CGFloat)tableViewCellHeight:(id)dataSource{
    if (![self.cellHeight isKindOfClass:[NSNull class]]) {
        NSMutableArray *v = [NSMutableArray array];
        [v addObject:[LSCValue objectValue:dataSource]];
        LSCValue *value =  [self.cellHeight invokeWithArguments:v];
        return [value toNumber].floatValue;
    }
    return 44.0f;
}

- (void)setDataSource:(id)dataSource {
    _dataSource = dataSource;
    if (self.lable != nil) {
        [self.lable setText:dataSource];
    }else{
        NSMutableArray *v = [NSMutableArray array];
        [v addObject:[LSCValue objectValue:dataSource]];
        [self.loadData invokeWithArguments:v];
    }
    [self reLayout];
}

- (void)pushLuaView:(NSString *)luaName param:(NSDictionary *)params {
    [self.vc pushLuaView:luaName param:params];
}


@end
