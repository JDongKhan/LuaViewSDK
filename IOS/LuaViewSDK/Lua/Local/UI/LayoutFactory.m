//
//  LayoutFactory.m
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/9.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "LayoutFactory.h"
#import "HorizontalLayout.h"
#import "VerticalLayout.h"
#import "RelativeLayout.h"
#import "HorizontalEqualWidthLayout.h"
#import "VerticalEqualHeightLayout.h"

@implementation LayoutFactory

+ (id<LuaLayout>)getFactory:(LAYOUT_STYLE)layout {
    if (layout == Horizontal_layout) {
        return [[HorizontalLayout alloc] init];
    }else if(layout == Vertical_layout){
        return [[VerticalLayout alloc] init];
    }else if(layout == Relative_layout){
        return [[RelativeLayout alloc] init];
    }else if(layout == Vertical_equal_height_layout){
        return [[VerticalEqualHeightLayout alloc] init];
    }else if(layout == Horizontal_equal_width_layout){
        return [[HorizontalEqualWidthLayout alloc] init];
    }
    return [[RelativeLayout alloc] init];
}
@end
