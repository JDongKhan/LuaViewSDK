//
//  LuaViewController.h
//  LuaView
//
//  Created by 王金东 on 17/1/16.
//  Copyright © 2017年 wangjindong. All rights reserved.
//

#import "LSCObjectClass.h"
#import "LuaNavigationController.h"
#import "LuaView.h"

@interface LuaViewController : LSCObjectClass

//导航控制器
@property (nonatomic,weak) LuaNavigationController *navigationController;

//初始化
- (instancetype)initWithViewController:(UIViewController *)viewController;

@property(nonatomic,strong) NSDictionary *params;

//lua文件名称
@property(nonatomic,strong) NSString *luaName;

//背景颜色
@property(nonatomic,strong) NSString *backgroundColor;


- (void)setTitle:(NSString *)title;

/**
 * 添加subview
 *
 */
- (void)addSubView:(LuaView *)subView;

/**
 * 移除subview
 *
 */
- (void)removeSubView:(LuaView *)subView;


//跳转
- (void)pushLuaView:(NSString *)luaName param:(NSDictionary *)params;

//NavigationBar 显隐
- (void)hideNavigationBar;
- (void)showNavigationBar;




@end
