//
//  LuaViewGroup.m
//  LuaViewSDK
//
//  Created by 王金东 on 17/1/20.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "LuaViewGroup.h"
#import "LuaView.h"
#import "LuaLayout.h"
#import "RelativeLayout.h"
#import "LayoutFactory.h"

@interface LuaViewGroup()

@property (nonatomic,strong) id<LuaLayout> luaLayout;

@end

@implementation LuaViewGroup

- (instancetype)init {
    self = [super init];
    if (self) {
        _subLuaViews = [NSMutableArray array];
        self.layoutType = Relative_layout;
        self.luaLayout = [[RelativeLayout alloc] init];
    }
    return self;
}

- (void)setLayoutType:(LAYOUT_STYLE)layoutType {
    _layoutType = layoutType;
    self.luaLayout = [LayoutFactory getFactory:layoutType];
}

- (void)setPadding:(NSArray *)padding {
    _padding = padding;
    self.leftPadding = [padding[0] floatValue],//left padding
    self.topPadding = [padding[1] floatValue],//top padding
    self.rightPadding = [padding[2] floatValue],//right padding
    self.bottomPadding = [padding[3] floatValue];//bottom padding
}

- (void)addLuaView:(LuaView *)view {
    [_subLuaViews addObject:view];
    [view _layout];
    [self addSubview:view._view];
}
- (void)removeLuaView:(LuaView *)view {
    [_subLuaViews removeObject:view];
    for (UIView *v in self.subviews) {
        if (v == view._view) {
            [v removeFromSuperview];
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews {
    [self.luaLayout layout:self];
    [self startLayout];
}

- (void)startLayout{
    for (int i = 0 ;i < self.subLuaViews.count;i++ ) {
        LuaView *view = self.subLuaViews[i];
        view._view.frame = CGRectMake(view._luaRect.l, view._luaRect.t, view._luaRect.w, view._luaRect.h);
    }
}

@end
