//
//  LuaTableView.h
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/3.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "LSCObjectClass.h"
#import "LuaView.h"
#import "LSCFunction.h"

@interface LuaTableView : LuaView

- (void)setCell:(NSString *)luaName;
- (void)setCells:(NSArray *)luaNames;

- (void)setItems:(NSArray *)items;

- (void)setItemClick:(LSCFunction *)itemClick;

- (void)setLayoutIndex:(LSCFunction *)layoutIndex;

@end
