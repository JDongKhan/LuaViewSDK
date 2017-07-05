//
//  LuaButton.h
//  LuaView
//
//  Created by 王金东 on 17/1/16.
//  Copyright © 2017年 wangjindong. All rights reserved.
//

#import "LuaView.h"
#import "LuaViewProtocol.h"
#import "LSCFunction.h"

@interface LuaButton : LuaView
//设置标题
@property (nonatomic, copy) NSString *text;
//设置按钮图片
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *leftImage;
@property (nonatomic, copy) NSString *topImage;
@property (nonatomic, copy) NSString *rightImage;
@property (nonatomic, copy) NSString *bottomImage;

//设置按钮背景图片
@property (nonatomic, copy) NSString *backgroundImage;
//设置标题颜色
@property (nonatomic, copy) NSString *textColor;
//设置字号
@property (nonatomic, copy) NSString *fontSize;
@property (nonatomic, copy) NSString *textSize;

//适配android
@property (nonatomic, assign) BOOL focusable;

//设置选中状态
@property (nonatomic, assign) BOOL selected;
//设置是否可用
@property (nonatomic, assign) BOOL enable;

- (void)click:(LSCFunction *)callBack;
@end
