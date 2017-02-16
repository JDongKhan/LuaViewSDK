//
//  PublicUtil.m
//  LuaViewSDK
//
//  Created by zhaotian on 2017/1/17.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "PublicUtil.h"

@implementation PublicUtil

+ (BOOL)isExternalUrl:(NSString *)url {
    return [url hasPrefix:@"https://"] || [url hasPrefix:@"http://"];
}

+ (UIControlState)stringToState:(NSString *)stateString {
    if ([stateString isEqualToString:@"normal"]) {
        return UIControlStateNormal;
    }
    else if ([stateString isEqualToString:@"highlighted"]) {
        return UIControlStateHighlighted;
    }
    else if ([stateString isEqualToString:@"disabled"]) {
        return UIControlStateDisabled;
    }
    else if ([stateString isEqualToString:@"selected"]) {
        return UIControlStateSelected;
    }
    return UIControlStateNormal;
}


@end
