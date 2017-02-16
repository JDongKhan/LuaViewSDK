//
//  LuaViewGroup.h
//  LuaViewSDK
//
//  Created by 王金东 on 17/1/20.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LuaHeader.h"

@class LuaView;
@interface LuaViewGroup : UIView

@property (nonatomic,assign) CGFloat leftPadding;
@property (nonatomic,assign) CGFloat topPadding;
@property (nonatomic,assign) CGFloat rightPadding;
@property (nonatomic,assign) CGFloat bottomPadding;

@property (nonatomic,strong) NSMutableArray *subLuaViews;


@property (nonatomic,assign) LAYOUT_STYLE layoutType;

@property (nonatomic,strong) NSArray *padding;
@property (nonatomic, strong) NSArray *weight;

@property (nonatomic,assign) BOOL autoresizeWidth;
@property (nonatomic,assign) BOOL autoresizeHeight;

- (void)addLuaView:(LuaView *)view;

- (void)removeLuaView:(LuaView *)view;

@end
