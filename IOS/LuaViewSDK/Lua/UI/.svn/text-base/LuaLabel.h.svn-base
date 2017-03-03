//
//  LuaLabel.h
//  LuaViewSDK
//
//  Created by zhaotian on 2017/1/19.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "LuaView.h"

@interface LuaLabel : LuaView

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSString *textColor;

@property (nonatomic, assign) float fontSize;
//省略号
@property (nonatomic, assign) NSInteger ellipsis;
//文字排列
@property (nonatomic, assign) NSInteger textAlignment;
//行数
@property (nonatomic, assign) NSInteger lineCount;
//是否自适应
@property (nonatomic, assign) BOOL adjustFontSize;
@property (nonatomic, assign) BOOL bold;

//最大高
@property (nonatomic, assign) CGFloat maxHeight;

@property (nonatomic, assign) BOOL verticalScrollBarEnabled;

//指定字符串、宽、高、字体     label的自适应
- (void)stringSizeForString:(NSString *)string width:(float)width height:(float)height fontSize:(float)fontSize;

@end
