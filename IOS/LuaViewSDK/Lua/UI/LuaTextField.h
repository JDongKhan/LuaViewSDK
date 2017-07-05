//
//  LuaTextField.h
//  LuaViewSDK
//
//  Created by zhaotian on 2017/1/19.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "LuaView.h"

@interface LuaTextField : LuaView

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *textColor;
//等待文字
@property (nonatomic, copy) NSString *placeholder;
//等待文字
@property (nonatomic, copy) NSString *hint;

//最大高
@property (nonatomic, assign) CGFloat maxHeight;

@end
