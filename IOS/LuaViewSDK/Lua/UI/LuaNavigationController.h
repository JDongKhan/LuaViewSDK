//
//  LuaNavigationController.h
//  LuaView
//
//  Created by 王金东 on 17/1/16.
//  Copyright © 2017年 wangjindong. All rights reserved.
//

#import "LSCObjectClass.h"
#import <UIKit/UIViewController.h>


@interface LuaNavigationController : LSCObjectClass

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController;

//push
- (void)pushLuaView:(NSString *)luaName;

- (void)pushLuaView:(NSString *)luaName param:(NSDictionary *)params;



@end
