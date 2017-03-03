//
//  ScriptNetwork.m
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/23.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "ScriptNetwork.h"
#import "Bundle.h"

@implementation ScriptNetwork

- (void)post:(NSString *)url params:(NSDictionary *)params callBack:(LuaCallBack)callBack {
    NSDictionary *result = @{};
    if (callBack) {
        callBack(true,result);
    }
}

- (void)downImage:(NSString *)url callBack:(LuaImageCallBack)callBack {
    if (callBack) {
        callBack([Bundle loadImage:url]);
    }
}

@end
