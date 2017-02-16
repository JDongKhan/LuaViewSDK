//
//  LuaTableViewCell.h
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/3.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "LSCObjectClass.h"
#import "LuaView.h"
#import "LuaViewController.h"

@interface LuaTableViewCell : LSCObjectClass

@property (nonatomic,strong) LuaView *contentView;

@property (nonatomic,weak) LuaViewController *vc;

@property (nonatomic,strong) NSString *luaName;

@property (nonatomic,strong) id dataSource;

- (CGFloat)tableViewCellHeight:(id)dataSource;
- (void)reLayout;

- (void)_onCreate;
- (void)addSubView:(LuaView *)view;
- (void)removeSubView:(LuaView *)view;
- (void)pushLuaView:(NSString *)luaName param:(NSDictionary *)params;

@end
