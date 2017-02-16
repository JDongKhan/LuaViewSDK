//
//  NetworkManager.h
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/6.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkDelegate.h"

@interface NetworkManager : NSObject


+ (void)register:(id<NetworkDelegate>) delegate;


+ (void)post:(NSString *)url
      params:(NSDictionary *)params
    callBack:(LuaCallBack)callBack;


@end
