//
//  UIColorUtil.m
//  LuaView
//
//  Created by 王金东 on 17/1/16.
//  Copyright © 2017年 wangjindong. All rights reserved.
//

#import "UIColorUtil.h"

#define DEFAULT_VOID_COLOR [UIColor whiteColor] 

@implementation UIColorUtil


+ (UIColor *)clearColor {
    return [UIColor clearColor];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    
    if(cString.length == 3){
        NSString *rString = [cString substringToIndex:1];
        NSString *gString = [cString substringWithRange:NSMakeRange(1, 1)];
        NSString *bString = [cString substringWithRange:NSMakeRange(2, 1)];
        cString = [NSString stringWithFormat:@"%@%@%@%@%@%@FF",rString,rString,gString,gString,bString,bString];
    }else if(cString.length == 6){
        cString = [NSString stringWithFormat:@"%@FF",cString];
    }
    if ([cString length] < 8)
        return DEFAULT_VOID_COLOR;
  
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    range.location = 6;
    NSString *aString = [cString substringWithRange:range];
    
    unsigned int r, g, b,a;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    [[NSScanner scannerWithString:aString] scanHexInt:&a];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:((float) a / 255.0f)];
}


@end
