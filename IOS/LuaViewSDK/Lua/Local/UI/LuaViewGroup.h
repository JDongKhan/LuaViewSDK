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
@interface LuaViewGroup : UIView{
    @package
    Margin _margin;
}

@property (nonatomic, assign, readonly) CGFloat leftPadding;
@property (nonatomic, assign, readonly) CGFloat topPadding;
@property (nonatomic, assign, readonly) CGFloat rightPadding;
@property (nonatomic, assign, readonly) CGFloat bottomPadding;

@property (nonatomic, strong, readonly) NSMutableArray *subLuaViews;


@property (nonatomic, assign) LAYOUT_STYLE layoutType;

@property (nonatomic, copy) NSArray *padding;
@property (nonatomic, copy) NSArray *weight;

- (void)addLuaView:(LuaView *)view;

- (void)removeLuaView:(LuaView *)view;

@end
