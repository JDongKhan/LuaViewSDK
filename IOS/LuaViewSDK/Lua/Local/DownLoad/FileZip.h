//
//  FileZip.h
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/13.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileZip : NSObject

+ (void)zipFile:(NSString *)zip_path targetPath:(NSString *)target_path;
+ (void)unZipFile:(NSString *)zip_path targetPath:(NSString *)target_path;

@end
