//
//  Bundle.m
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/13.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "Bundle.h"
#import "LuaConsole.h"

@implementation Bundle

+ (NSString *)luaScript:(NSString *)luaName {
    if (![luaName hasSuffix:@"lua"]) {
        luaName = [luaName stringByAppendingPathExtension:@"lua"];
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:[luaName stringByDeletingPathExtension] ofType:[luaName pathExtension]];
    NSString *fileString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    if (fileString.length == 0) {
        [LuaConsole log:[NSString stringWithFormat:@"%@ 文件不存在或内容为空",luaName]];
        NSString *desc = [NSString stringWithFormat:@"%@文件不存在或长度为0",luaName];
        NSAssert(fileString.length > 0, desc);
    }
    return fileString;
}

+ (NSString *)cachePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    return cachesDir;
}


@end
