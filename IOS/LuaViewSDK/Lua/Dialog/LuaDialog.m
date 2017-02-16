//
//  LuaDialog.m
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/10.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "LuaDialog.h"
#import <UIKit/UIKit.h>

@implementation LuaDialog

+ (void)show:(NSString *)message {
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
    [alertview show];
}
@end
