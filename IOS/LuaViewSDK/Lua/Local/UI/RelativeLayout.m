//
//  RelativeLayout.m
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/9.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "RelativeLayout.h"
#import "LuaView.h"

@implementation RelativeLayout

- (void)layout:(LuaViewGroup *)luaViewGroup {
    
    CGFloat lp = luaViewGroup.leftPadding,//left padding
    tp = luaViewGroup.topPadding,//top padding
    rp = luaViewGroup.rightPadding,//right padding
    bp = luaViewGroup.bottomPadding;//bottom padding
    CGFloat height = 0;
    CGFloat width = 0;
    CGFloat l = lp, t = tp,r = 0,b = 0,w = 0, h = 0;
    CGFloat cl = 0,ct = 0, cr = 0, cb = 0;
    for (int i = 0 ;i < luaViewGroup.subLuaViews.count;i++ ) {
        LuaView *view = luaViewGroup.subLuaViews[i];
        Margin margin = view._margin;
        if (!view.hidden) {
            CGRect frame = [view _resize];
            l = margin.l+r;
            t = margin.t+b;
            r = margin.r;
            b = margin.b;
            w = frame.size.width;
            h = frame.size.height;
        }else{
            margin = MarginMake(0,0,0,0,0,0);
            l = 0;
            t = 0;
            r = 0;
            b = 0;
            w = 0;
            h = 0;
        }
        cl = l+lp;
        ct = t+tp;
        if(view.leftView != nil && ![view.leftView isKindOfClass:[NSNull class]]){
            cl = l+view.leftView._luaRect.r;
        }
        if(view.topView != nil && ![view.topView isKindOfClass:[NSNull class]]){
            ct = t+view.topView._luaRect.b;
        }
        cr = cl+w;
        cb = ct+h;
        view._luaRect = LuaRectMake(cl,ct,cr,cb,w,h);
        width = MAX(width, cr+margin.r);
        height = MAX(height,cb+margin.b);
    }
    CGRect frame = luaViewGroup.frame;
    CGFloat totalWidth = frame.size.width;
    CGFloat totalHeight = frame.size.height;
    if (luaViewGroup._margin.w != MATCH_PARENT) {
        totalWidth = MAX(totalWidth, width+rp);
    }
    if(luaViewGroup._margin.h != MATCH_PARENT){
        totalHeight = MAX(totalHeight, height+bp);
    }
    frame = CGRectMake(frame.origin.x, frame.origin.y, totalWidth, totalHeight);
    luaViewGroup.frame = frame;
    
    //处理view在父view
    [self resizeViewAtParent:luaViewGroup];
    //处理right
    [self resizeViewAtRightView:luaViewGroup];
}

- (void)resizeViewAtParent:(LuaViewGroup *)luaViewGroup{
    CGFloat vw = luaViewGroup.frame.size.width;
    CGFloat vh = luaViewGroup.frame.size.height;
    for (int i = 0 ;i < luaViewGroup.subLuaViews.count;i++ ) {
        LuaView *view = luaViewGroup.subLuaViews[i];
        LAYOUT_GRAVITY gravity = view.layout_gravity;
        if (!view.hidden && gravity > 0) {
            LuaRect rect = view._luaRect;
            Margin margin = view._margin;
            if (gravity == Parent_right) {
                rect.r = vw - margin.r;
                rect.l = rect.r - rect.w;
            }else if(gravity == Parent_bottom){
                rect.b = vh-margin.b;
                rect.t = rect.b-rect.h;
            }else if(gravity == (Parent_bottom|Parent_right)){
                rect.r = vw - margin.r;
                rect.l = rect.r - rect.w;
                rect.b = vh-margin.b;
                rect.t = rect.b-rect.h;
            }else if(gravity == (Parent_left|Parent_center)){
                int y_middle = (vh-luaViewGroup.topPadding-luaViewGroup.bottomPadding-rect.h)/2;
                rect.l = luaViewGroup.leftPadding + margin.l;
                rect.t = rect.l + rect.w;
                rect.t = y_middle;
                rect.b = rect.t+rect.h;
            }else if(gravity == Parent_center){
                int x_middle = (vw-luaViewGroup.leftPadding-luaViewGroup.rightPadding-rect.w)/2;
                int y_middle = (vh-luaViewGroup.topPadding-luaViewGroup.bottomPadding-rect.h)/2;
                rect.l = x_middle;
                rect.t = rect.l + rect.w;
                rect.t = y_middle;
                rect.b = rect.t+rect.h;
            }else if(gravity == (Parent_right|Parent_center)){
                int y_middle = (vh-luaViewGroup.topPadding-luaViewGroup.bottomPadding-rect.h)/2;
                rect.r = vw - margin.r;
                rect.l = rect.r - rect.w;
                rect.t = y_middle;
                rect.b = rect.t+rect.h;
            }
            view._luaRect = rect;
        }
    }
}


- (void)resizeViewAtRightView:(LuaViewGroup *)luaViewGroup{
    for (int i = 0 ;i < luaViewGroup.subLuaViews.count;i++ ) {
        LuaView *view = luaViewGroup.subLuaViews[i];
        LuaRect rect = view._luaRect;
        Margin margin = view._margin;
        if(view.rightView != nil && ![view.rightView isKindOfClass:[NSNull class]]){
            rect.r = view.rightView._luaRect.l-view.rightView._margin.l-margin.r;
            rect.l = rect.r - rect.w;
        }
        if(view.bottomView != nil && ![view.bottomView isKindOfClass:[NSNull class]]){
            rect.b = view.bottomView._luaRect.t-view.bottomView._margin.t-margin.b;
            rect.t = rect.b - rect.h;
        }
        view._luaRect = rect;
    }
}
@end
