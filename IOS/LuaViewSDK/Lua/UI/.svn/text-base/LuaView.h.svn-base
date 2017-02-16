//
//  LuaView.h
//  LuaView
//
//  Created by 王金东 on 17/1/16.
//  Copyright © 2017年 wangjindong. All rights reserved.
//

#import "LSCObjectClass.h"
#import "PublicUtil.h"
#import "UIColorUtil.h"
#import "LuaHeader.h"

@class LuaViewController;
@interface LuaView : LSCObjectClass

/*****************************private**********************************/
@property (nonatomic,weak) LuaViewController *vc;
@property (nonatomic,assign) Margin _margin;
@property (nonatomic,assign) LuaRect _luaRect;
@property (nonatomic,strong) UIView *_view;


- (void)_layout;

//重新计算frame
- (CGRect)_resize;

/*********************** view group *******************************/

@property (nonatomic,strong) NSArray *padding;
@property (nonatomic,assign) LAYOUT_STYLE layoutType;
@property (nonatomic,assign) LAYOUT_GRAVITY layout_gravity;

/************************* view ****************************/

//设置frame
@property (nonatomic,strong) NSArray *frame;

@property (nonatomic, strong) LuaView *leftView;
@property (nonatomic, strong) LuaView *topView;
@property (nonatomic, strong) LuaView *rightView;
@property (nonatomic, strong) LuaView *bottomView;
@property (nonatomic, strong) NSArray *weight;
@property (nonatomic, strong) NSString *tag;

//设置背景颜色
@property (nonatomic,strong) NSString *backgroundColor;
//设置显隐
@property (nonatomic, assign) BOOL hidden;
//是否打开用户交互
@property (nonatomic, assign) BOOL userInteractionEnabled;
//是否裁剪
@property (nonatomic, assign) BOOL clipsToBounds;
//圆角
@property (nonatomic, assign) float cornerRadius;


- (void)reLayout;

- (void)addSubView:(LuaView *)subView;

- (void)removeSubView:(LuaView *)subView;




@end
