//
//  LuaView.m
//  LuaView
//
//  Created by 王金东 on 17/1/16.
//  Copyright © 2017年 wangjindong. All rights reserved.
//

#import "LuaView.h"
#import "LuaViewGroup.h"


@interface LuaView ()


@end


@implementation LuaView{
    NSArray *_frame;
}

- (instancetype)init {
    if (self == [super init]) {
        __view = [[LuaViewGroup alloc] init];
    }
    return self;
}

- (void)_layout {

}
#pragma mark --------------- setter && getter
- (void)setFrame:(NSArray *)frame {
    _frame  = frame;
    if (frame.count == 2) {
        NSNumber *width = frame[0];
        NSNumber *height = frame[1];
        self._margin = MarginMake(0, 0, 0, 0, width.floatValue, height.floatValue);
    }else if(frame.count == 4){
        NSNumber *x = frame[0];
        NSNumber *y = frame[1];
        NSNumber *width = frame[2];
        NSNumber *height = frame[3];
        self._margin = MarginMake(x.floatValue, y.floatValue, 0, 0, width.floatValue, height.floatValue);
    }else if(frame.count == 6){
        NSNumber *l = frame[0];
        NSNumber *t = frame[1];
        NSNumber *r = frame[2];
        NSNumber *b = frame[3];
        NSNumber *width = frame[4];
        NSNumber *height = frame[5];
        self._margin = MarginMake(l.floatValue, t.floatValue, r.floatValue, b.floatValue, width.floatValue, height.floatValue);
    }
    CGRect f = CGRectMake(self._margin.r, self._margin.t, self._margin.w,self._margin.h);
    if ([__view isKindOfClass:[LuaViewGroup class]]) {
        if (f.size.width == -1) {
            ((LuaViewGroup *)__view).autoresizeWidth = YES;
        }
        if (f.size.height == -1) {
            ((LuaViewGroup *)__view).autoresizeHeight = YES;
        }
    }
    self._view.frame = f;
}

- (void)setWeight:(NSArray *)weight {
    _weight = weight;
    if ([__view isKindOfClass:[LuaViewGroup class]]) {
        ((LuaViewGroup *)__view).weight = weight;
    }
}
- (NSArray *)frame {
    return _frame;
}
//重新计算frame
- (CGRect)_resize {
    NSNumber *x = _frame[0];
    NSNumber *y = _frame[1];
    NSNumber *width = _frame[2];
    NSNumber *height = _frame[3];
    return CGRectMake(x.floatValue, y.floatValue, width.floatValue, height.floatValue);
}

- (void)reLayout {
    [self._view setNeedsLayout];
}
- (void)setBackgroundColor:(NSString *)backgroundColor{
    _backgroundColor = backgroundColor;
    if ([backgroundColor isEqualToString:@"clearColor"]) {
        self._view.backgroundColor = [UIColorUtil clearColor];
    } else {
        self._view.backgroundColor = [UIColorUtil colorWithHexString:backgroundColor];
    }
}

- (void)setHidden:(BOOL)hidden {
    self._view.hidden = hidden;
}
- (BOOL)hidden {
    return self._view.hidden;
}

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled {
    self._view.userInteractionEnabled = userInteractionEnabled;
}
- (BOOL)userInteractionEnabled {
    return self._view.userInteractionEnabled;
}

- (void)setClipsToBounds:(BOOL)clipsToBounds {
    self._view.clipsToBounds = clipsToBounds;
}
- (BOOL)clipsToBounds {
    return self._view.clipsToBounds;
}

- (void)setCornerRadius:(float)cornerRadius {
    self._view.layer.cornerRadius = cornerRadius;
}
- (float)cornerRadius {
    return self._view.layer.cornerRadius;
}


- (void)addSubView:(LuaView *)subView {
    subView.vc = self.vc;
    if ([self._view isKindOfClass:[LuaViewGroup class]]) {
        LuaViewGroup *group = (LuaViewGroup *)self._view;
        [group addLuaView:subView];
    }
}

- (void)removeSubView:(LuaView *)subView{
    if ([self._view isKindOfClass:[LuaViewGroup class]]) {
        LuaViewGroup *group = (LuaViewGroup *)self._view;
        [group removeLuaView:subView];
    }
}

- (void)setLayoutType:(LAYOUT_STYLE)layoutType {
    if ([self._view isKindOfClass:[LuaViewGroup class]]) {
        LuaViewGroup *group = (LuaViewGroup *)self._view;
        group.layoutType = layoutType;
    }
}
- (LAYOUT_STYLE)layoutType {
    if ([self._view isKindOfClass:[LuaViewGroup class]]) {
        LuaViewGroup *group = (LuaViewGroup *)self._view;
        return group.layoutType;
    }
    return Relative_layout;
}
- (void)setPadding:(NSArray *)padding {
    if ([self._view isKindOfClass:[LuaViewGroup class]]) {
        LuaViewGroup *group = (LuaViewGroup *)self._view;
        group.padding = padding;
    }
}
- (NSArray *)padding {
    if ([self._view isKindOfClass:[LuaViewGroup class]]) {
        LuaViewGroup *group = (LuaViewGroup *)self._view;
        return group.padding;
    }
    return nil;
}

#pragma mark --------------- privateFunction
#pragma mark --------------- API
@end
