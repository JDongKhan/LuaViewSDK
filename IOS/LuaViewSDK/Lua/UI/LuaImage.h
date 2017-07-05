//
//  LuaImage.h
//  LuaViewSDK
//
//  Created by zhaotian on 2017/1/23.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "LuaView.h"

@interface LuaImage : LuaView

@property (nonatomic, copy) NSString *image;
// contentMode
@property (nonatomic, assign) NSInteger scaleType;

@property (nonatomic, assign, readonly) BOOL isAnimating;

// 停止加载帧动画
- (void)stopAnimating;

@end
