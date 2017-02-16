//
//  LuaScriptDownloadManager.m
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/13.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "LuaScriptDownloadManager.h"
#import "Bundle.h"
#import "FileDownload.h"
#import "FileZip.h"
#import "LuaScriptCoreManager.h"

#define zip_down_cache_path @"zipluadown"

@implementation LuaScriptDownloadManager

- (void)down:(NSString *)down_url {
    
    NSString *fileName = [down_url lastPathComponent];
    NSString *cachePath = [Bundle cachePath];
    NSString *zip_target_url = [cachePath stringByAppendingPathComponent:zip_down_cache_path];
    zip_target_url = [zip_target_url stringByAppendingPathComponent:fileName];
    
    
    NSString *files_target_url = [cachePath stringByAppendingPathComponent:down_cache_path];
    
    //下载文件
    FileDownload *fd = [[FileDownload alloc] init];
    [fd down:down_url target_url:zip_target_url];
    
    [FileZip unZipFile:zip_target_url targetPath:files_target_url];
    
    //加入lua搜索
    [[LuaScriptCoreManager shareInstance] addSearchPath:files_target_url];
    
}


@end
