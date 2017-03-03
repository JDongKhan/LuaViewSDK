//
//  LuaHeader.h
//  LuaViewSDK
//
//  Created by 王金东 on 17/1/20.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>

typedef NS_ENUM(NSInteger,LAYOUT_STYLE){
    Relative_layout = 1 << 0,
    Vertical_layout = 1 << 1,
    Horizontal_layout = 1 << 2,
    Vertical_equal_height_layout = 1 << 3,
    Horizontal_equal_width_layout = 1 << 4
};

typedef NS_ENUM(NSInteger,LAYOUT_GRAVITY) {
    Parent_top = 1<<0,
    Parent_center = 1<<1,
    Parent_right = 1<<2,
    Parent_left = 1<<3,
    Parent_bottom = 1 << 4
};

typedef struct {
    CGFloat l;
    CGFloat t;
    CGFloat r;
    CGFloat b;
    CGFloat w;
    CGFloat h;
}Margin;



CG_INLINE Margin
MarginMake(CGFloat l, CGFloat t, CGFloat r, CGFloat b,CGFloat w,CGFloat h)
{
    Margin margin;
    margin.l = l;
    margin.t = t;
    margin.r = r;
    margin.b = b;
    margin.w = w;
    margin.h = h;
    return margin;
}



typedef struct {
    CGFloat l;
    CGFloat t;
    CGFloat r;
    CGFloat b;
    CGFloat w;
    CGFloat h;
}LuaRect;

CG_INLINE LuaRect
LuaRectMake(CGFloat l, CGFloat t,CGFloat r,CGFloat b,CGFloat w, CGFloat h) {
    LuaRect rect;
    rect.l = l; rect.t = t;
    rect.r = r; rect.b = b;
    rect.w = w; rect.h = h;
    return rect;
}


