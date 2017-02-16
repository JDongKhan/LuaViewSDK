//
//  VerticalLayout.m
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/9.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "VerticalLayout.h"
#import "LuaView.h"

@implementation VerticalLayout

- (void)layout:(LuaViewGroup *)luaViewGroup {
    //CGFloat height = 0;
    CGFloat width = 0;
    CGFloat l = 0, t = 0,r = 0, b= 0,w = 0, h = 0;
    CGFloat cl = 0, ct = 0,cr = 0, cb = 0;
    for (int i = 0 ;i < luaViewGroup.subLuaViews.count;i++ ) {
        LuaView *view = luaViewGroup.subLuaViews[i];
        if(!view.hidden){
            Margin margin = view._margin;
            CGRect frame = [view _resize];
            l = margin.l+r;
            t = margin.t+b;
            r = margin.r;
            b = margin.b;
            w = frame.size.width;
            h = frame.size.height;
        }else{
            l = 0;
            t = 0;
            w = 0;
            h = 0;
        }
        cl = l;
        ct = t+cb;
        cr = cl+w;
        cb = ct+h;
        width = MAX(width, w+l);
        view._luaRect = LuaRectMake(cl+luaViewGroup.leftPadding, ct+luaViewGroup.topPadding, cr+luaViewGroup.leftPadding, cb+luaViewGroup.topPadding, w, h);
    }
    CGRect frame = luaViewGroup.frame;
    CGFloat totalWidth = frame.size.width;
    CGFloat totalHeight = frame.size.height;
    if(luaViewGroup.autoresizeWidth){
        totalWidth = width+luaViewGroup.leftPadding+luaViewGroup.rightPadding;
    }
    if (luaViewGroup.autoresizeHeight) {
        totalHeight = cb+luaViewGroup.topPadding+luaViewGroup.bottomPadding;
    }
    frame = CGRectMake(frame.origin.x, frame.origin.y, totalWidth, totalHeight);
    luaViewGroup.frame = frame;
    
    //处理权重
    [self resizeWithWeight:luaViewGroup];

}

- (void)resizeWithWeight:(LuaViewGroup *)luaViewGroup{
    if (luaViewGroup.weight != nil && luaViewGroup.weight.count > 0) {
        CGFloat height = luaViewGroup.frame.size.height;
        NSAssert(height > 0, @"height必须大于0");
        CGFloat remainHeight = height;
        int index = 0;
        for (int i = 0 ;i < luaViewGroup.subLuaViews.count;i++ ) {
            LuaView *view = luaViewGroup.subLuaViews[i];
            if (!view.hidden) {
                LuaRect rect = view._luaRect;
                Margin margin = view._margin;
                if(index > luaViewGroup.weight.count-1){
                    remainHeight = remainHeight-margin.t-margin.b-rect.h;
                }else{
                    remainHeight = remainHeight - margin.t-margin.b;
                }
                index++;
            }
        }
        remainHeight = remainHeight-luaViewGroup.topPadding-luaViewGroup.bottomPadding;
        double totalWeight = 0.0;
        NSMutableArray<NSNumber *> *heightArray = [NSMutableArray array];
        for(NSNumber *n in luaViewGroup.weight){
            totalWeight += n.doubleValue;
            [heightArray addObject:@(remainHeight*n.doubleValue)];
        }
        NSAssert(((int)totalWeight) == 1, @"权重之和必须为1");
        
        index = 0;
        CGFloat l = 0, t = 0,r = 0,b = 0,w = 0, h = 0;
        CGFloat cl = 0, ct = 0,cr = 0, cb = 0;
        
        for (int i = 0 ;i < luaViewGroup.subLuaViews.count;i++ ) {
            LuaView *view = luaViewGroup.subLuaViews[i];
            if (!view.hidden) {
                Margin margin = view._margin;
                LuaRect rect = view._luaRect;
                l = margin.l+r;
                t = margin.t+b;
                r = margin.r;
                b = margin.b;
                w = rect.w;
                if (index <= heightArray.count-1) {
                    h = [heightArray objectAtIndex:index].floatValue;
                }else{
                    h = rect.h;
                }
                index ++;
                
            }else{
                l = 0;
                t = 0;
                r = 0;
                b = 0;
                w = 0;
                h = 0;
            }
            cl = l;
            ct = t+cb;
            cr = cl+w;
            cb = ct+h;
            view._luaRect = LuaRectMake(cl+luaViewGroup.leftPadding, ct+luaViewGroup.topPadding, cr+luaViewGroup.leftPadding, cb+luaViewGroup.topPadding, w, h);
        }
    }
}
@end
