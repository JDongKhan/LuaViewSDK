//
//  LuaRequest.m
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/6.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "LuaRequest.h"
#import "NetworkManager.h"
#import "LSCValue.h"

@implementation LuaRequest

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(LSCFunction *)success fail:(LSCFunction *)fail {
    [NetworkManager post:url params:params callBack:^(BOOL s, NSDictionary *result) {
        NSMutableArray *luaArray = [NSMutableArray array];
        [luaArray addObject:[LSCValue objectValue:result]];
        if (s) {
            [success invokeWithArguments:luaArray];
        }else{
            [fail invokeWithArguments:luaArray];
        }
    }];
}
@end
