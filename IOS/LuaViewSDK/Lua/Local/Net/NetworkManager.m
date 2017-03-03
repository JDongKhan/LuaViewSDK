//
//  NetworkManager.m
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/6.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "NetworkManager.h"


static id<NetworkDelegate> netWorkDelegate;

@implementation NetworkManager

+ (void)register:(id<NetworkDelegate>) delegate {
    netWorkDelegate = delegate;
}

+ (void)post:(NSString *)url
      params:(NSDictionary *)params
    callBack:(LuaCallBack)callBack {
    [netWorkDelegate post:url params:params callBack:callBack];
}

+ (void)downImage:(NSString *)url callBack:(LuaImageCallBack)callBack {
    [netWorkDelegate downImage:url callBack:callBack];
}

@end
