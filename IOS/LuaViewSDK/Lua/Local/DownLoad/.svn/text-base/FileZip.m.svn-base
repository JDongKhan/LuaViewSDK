//
//  FileZip.m
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/13.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "FileZip.h"
#import <ZipArchive/ZipArchive.h>

@implementation FileZip

+ (void)zipFile:(NSString *)zip_path targetPath:(NSString *)target_path {
    ZipArchive* zip = [[ZipArchive alloc] init];
    BOOL result = [zip CreateZipFile2:zip_path];
    result = [zip addFileToZip:target_path newname:[target_path stringByDeletingLastPathComponent]];
    if( ![zip CloseZipFile2] ){
        NSLog(@"压缩失败");
    }
}
+ (void)unZipFile:(NSString *)zip_path targetPath:(NSString *)target_path {
    ZipArchive* zip = [[ZipArchive alloc] init];
    if( [zip UnzipOpenFile:zip_path] ){
        BOOL result = [zip UnzipFileTo:target_path overWrite:YES];
        if( NO==result ){
            //添加代码
        }
        [zip UnzipCloseFile];
    }
}

@end
