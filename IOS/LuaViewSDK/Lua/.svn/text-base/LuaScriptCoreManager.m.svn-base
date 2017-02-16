//
//  LuaScriptCoreManager.m
//  LuaView
//
//  Created by 王金东 on 17/1/16.
//  Copyright © 2017年 wangjindong. All rights reserved.
//

#import "LuaScriptCoreManager.h"
#import <UIKit/UIKit.h>
#import "LuaViewController.h"
#import "LuaButton.h"
#import "LuaLabel.h"
#import "LuaTextField.h"
#import "LuaImageView.h"
#import "LuaTableView.h"
#import "LuaTableViewCell.h"
#import "LuaConsole.h"
#import "LuaSystem.h"
#import "LuaDialog.h"
#import "LuaBundle.h"
#import "LuaView.h"

@interface LuaScriptCoreManager ()

/**
 lua上下文
 */
@property(nonatomic, strong,readonly) LSCContext *context;

@end

@implementation LuaScriptCoreManager

+ (instancetype)shareInstance{
    static LuaScriptCoreManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LuaScriptCoreManager alloc] init];
    });
    return manager;
}

- (instancetype)init{
    if (self = [super init]) {
        _context = [[LSCContext alloc] init];
        //捕获异常
        [_context onException:^(NSString *message) {
            NSLog(@"-------------------------------------");
            NSLog(@"%@", message);
            NSLog(@"-------------------------------------");
        }];
        [self registerAllModule];
    }
    return self;
}

- (void)registerAllModule {
    
    NSArray *moduleClass = @[[LuaNavigationController class],
                             [LuaViewController class],
                             [LuaView class],
                             [LuaButton class],
                             [LuaLabel class],
                             [LuaTextField class],
                             [LuaImageView class],
                             [LuaTableView class],
                             [LuaTableViewCell class],
                             [LuaConsole class],
                             [LuaSystem class],
                             [LuaDialog class],
                             [LuaBundle class]];
    
    
    for(Class clazz in moduleClass){
        [self registerModule:clazz];
    }
    
    //注册方法
    [self.context
     registerMethodWithName:@"getDeviceInfo"
     block:^LSCValue *(NSArray *arguments) {
         
         NSMutableDictionary *info =
         [NSMutableDictionary dictionary];
         [info setObject:[UIDevice currentDevice].name
                  forKey:@"deviceName"];
         [info setObject:[UIDevice currentDevice].model
                  forKey:@"deviceModel"];
         [info setObject:[UIDevice currentDevice].systemName
                  forKey:@"systemName"];
         [info
          setObject:[UIDevice currentDevice].systemVersion
          forKey:@"systemVersion"];
         
         return [LSCValue dictionaryValue:info];
         
     }];
}


- (void)registerModule:(Class)clazz {
    [self.context registerModuleWithClass:clazz];
}


/**
 *  解析脚本
 *
 *  @param string 脚本字符串
 *
 *  @return 返回值，如果无返回值则为nil
 */
- (LSCValue *)evalScriptFromString:(NSString *)string {
    return [self.context evalScriptFromString:string];
}

/**
 *  调用方法
 *
 *  @param methodName 方法名称
 *  @param arguments  参数
 *
 *  @return 返回值
 */
- (LSCValue *)callMethodWithName:(NSString *)methodName arguments:(NSArray<LSCValue *> *)arguments {
    return [self.context callMethodWithName:methodName arguments:arguments];
}
- (void)addSearchPath:(NSString *)path {
    [self.context addSearchPath:path];
}

@end
