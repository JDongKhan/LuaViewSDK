//
//  UIColorUtil.h
//  LuaView
//
//  Created by 王金东 on 17/1/16.
//  Copyright © 2017年 wangjindong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIColor.h>

@interface UIColorUtil : NSObject

/**
 *  16进制转color
 *
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (UIColor *)clearColor;

@end
