//
//  LSCViewController.h
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/9.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LuaNavigationController.h"

@interface LSCViewController : UIViewController

//导航控制器
@property (nonatomic, weak) LuaNavigationController *luaNavigationController;

@property (nonatomic, copy) NSString *luaName;

@property (nonatomic, copy) NSDictionary *params;

@end
