//
//  LuaScriptCoreManager.h
//  LuaView
//
//  Created by 王金东 on 17/1/16.
//  Copyright © 2017年 wangjindong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LuaScriptCore.h"
#import <UIKit/UIViewController.h>

@interface LuaScriptCoreManager : NSObject

+ (instancetype)shareInstance;

- (void)registerModule:(Class)clazz;


/**
 *  解析脚本
 *
 *  @param string 脚本字符串
 *
 *  @return 返回值，如果无返回值则为nil
 */
- (LSCValue *)evalScriptFromString:(NSString *)string;

/**
 *  调用方法
 *
 *  @param methodName 方法名称
 *  @param arguments  参数
 *
 *  @return 返回值
 */
- (LSCValue *)callMethodWithName:(NSString *)methodName arguments:(NSArray<LSCValue *> *)arguments;

/**
 *  添加搜索路径，如果执行的lua脚本不是放在默认目录（应用目录）内时，需要添加指定路径，否则会提示无法找到脚本从而运行出错
 *
 *  @param path 路径
 */
- (void)addSearchPath:(NSString *)path;

@end
