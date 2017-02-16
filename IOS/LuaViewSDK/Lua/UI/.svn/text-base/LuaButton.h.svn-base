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
@property (strong, nonatomic) NSString *text;
//设置按钮图片
@property (strong, nonatomic) NSString *image;
//设置按钮背景图片
@property (strong, nonatomic) NSString *backgroundImage;
//设置标题颜色
@property (strong, nonatomic) NSString *textColor;
//设置字号
@property (strong, nonatomic) NSString *fontSize;
@property (strong, nonatomic) NSString *textSize;

//适配android
@property (assign, nonatomic) BOOL focusable;

//设置选中状态
@property (assign, nonatomic) BOOL selected;
//设置是否可用
@property (assign, nonatomic) BOOL enable;

- (void)click:(LSCFunction *)callBack;
@end
