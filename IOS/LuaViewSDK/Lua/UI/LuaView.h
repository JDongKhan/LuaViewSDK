//
//  LuaView.h
//  LuaView
//
//  Created by 王金东 on 17/1/16.
//  Copyright © 2017年 wangjindong. All rights reserved.
//

#import "LSCObjectClass.h"
#import "UIColorUtil.h"
#import "LuaHeader.h"
#import <UIKit/UIKit.h>

#define WRAP_CONTENT  -2
#define MATCH_PARENT  -1


@class LuaViewController;
@interface LuaView : LSCObjectClass

/*****************************private**********************************/
@property (nonatomic, weak) LuaViewController *vc;
@property (nonatomic, assign) Margin _margin;
@property (nonatomic, assign) LuaRect _luaRect;
@property (nonatomic, strong) UIView *_view;


- (void)_layout;

//重新计算frame
- (CGRect)_resize;

/*********************** view group *******************************/

@property (nonatomic, copy) NSArray *padding;
@property (nonatomic, assign) LAYOUT_STYLE layoutType;
@property (nonatomic, assign) LAYOUT_GRAVITY layout_gravity;

/************************* view ****************************/

//设置frame
@property (nonatomic, copy) NSArray *frame;

@property (nonatomic, strong) LuaView *leftView;
@property (nonatomic, strong) LuaView *topView;
@property (nonatomic, strong) LuaView *rightView;
@property (nonatomic, strong) LuaView *bottomView;
@property (nonatomic, copy) NSArray *weight;
@property (nonatomic, copy) NSString *tag;

//设置背景颜色
@property (nonatomic, copy) NSString *backgroundColor;
//设置显隐
@property (nonatomic, assign) BOOL hidden;
//是否打开用户交互
@property (nonatomic, assign) BOOL userInteractionEnabled;
//是否裁剪
@property (nonatomic, assign) BOOL clipsToBounds;
//圆角
@property (nonatomic, assign) float cornerRadius;

@property (nonatomic, weak) LuaView *superLuaView;

- (void)reLayout;

- (void)addSubView:(LuaView *)subView;

- (void)removeSubView:(LuaView *)subView;




@end
