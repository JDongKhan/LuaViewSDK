//
//  LayoutFactory.h
//  LuaViewSDK
//
//  Created by 王金东 on 17/2/9.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LuaHeader.h"
#import "LuaLayout.h"

@interface LayoutFactory : NSObject

+ (id<LuaLayout>)getFactory:(LAYOUT_STYLE)layout;

@end
