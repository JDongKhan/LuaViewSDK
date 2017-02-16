//
//  HorizontalEqualWidthLayout.m
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/9.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "HorizontalEqualWidthLayout.h"
#import "LuaView.h"

@implementation HorizontalEqualWidthLayout


- (void)layout:(LuaViewGroup *)luaViewGroup {
    
    CGFloat lp = [luaViewGroup.padding[0] floatValue],//left padding
    tp = [luaViewGroup.padding[1] floatValue],//top padding
    rp = [luaViewGroup.padding[2] floatValue],//right padding
    bp = [luaViewGroup.padding[3] floatValue];//bottom padding
    NSInteger count = luaViewGroup.subLuaViews.count;
    
    CGRect frame = luaViewGroup.frame;
    CGFloat totalWidth = frame.size.width;
    CGFloat totalHeight = frame.size.height;
    CGFloat height = totalHeight-tp-bp;
    CGFloat width = (totalWidth-lp-rp)/count;
    
    CGFloat l = 0, t = 0,r = 0,b = 0,w = 0, h = 0;
    CGFloat cl = 0, ct = 0,cr = 0, cb = 0;
    for (int i = 0 ;i < count;i++ ) {
        LuaView *view = luaViewGroup.subLuaViews[i];
        if (!view.hidden) {
            l = 0;
            t = 0;
            r = 0;
            b = 0;
            w = width;
            h = height;
        }else{
            l = 0;
            t = 0;
            r = 0;
            b = 0;
            w = 0;
            h = 0;
        }
        cl = l+cr;
        cr = cl+w;
        ct = t;
        cb = ct+h;
        view._luaRect = LuaRectMake(cl+lp, ct+tp, cr+lp, cb+tp, w, h);
    }
}

@end
