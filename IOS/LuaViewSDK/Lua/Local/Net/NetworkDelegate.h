//
//  NetworkDelegate.h
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/6.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIImage.h>


typedef void(^LuaCallBack)(BOOL success,NSDictionary *result);
typedef void(^LuaImageCallBack)(UIImage *image);

@protocol NetworkDelegate <NSObject>

- (void)post:(NSString *)url params:(NSDictionary *)params callBack:(LuaCallBack)callBack;

- (void)downImage:(NSString *)url callBack:(LuaImageCallBack)callBack;

@end
