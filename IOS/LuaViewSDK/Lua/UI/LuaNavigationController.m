//
//  LuaNavigationController.m
//  LuaView
//
//  Created by 王金东 on 17/1/16.
//  Copyright © 2017年 wangjindong. All rights reserved.
//

#import "LuaNavigationController.h"
#import "LuaViewController.h"
#import "LuaScriptCoreManager.h"
#import "LSCViewController.h"

@implementation LuaNavigationController{
    UIViewController *_rootViewController;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        _rootViewController = rootViewController;
    }
    return self;
}

- (void)pushLuaView:(NSString *)luaName {
    [self pushLuaView:luaName param:nil];
}

- (void)pushLuaView:(NSString *)luaName param:(NSDictionary *)params {
    LSCViewController *vc = [[LSCViewController alloc] init];
    vc.luaNavigationController = self;
    vc.params = params;
    vc.luaName = luaName;
    [_rootViewController.navigationController pushViewController:vc animated:YES];
}


@end
