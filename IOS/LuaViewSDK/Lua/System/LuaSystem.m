//
//  System.m
//  LuaView
//
//  Created by 王金东 on 17/1/16.
//  Copyright © 2017年 wangjindong. All rights reserved.
//

#import "LuaSystem.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@implementation LuaSystem

+ (LSCTuple *)screenSize {
    CGSize size = [UIScreen mainScreen].bounds.size;
    LSCTuple *tuple = [[LSCTuple alloc]init];
    [tuple addReturnValue:@(size.width)];
    [tuple addReturnValue:@(size.height-64)];
    return tuple;
}


@end
