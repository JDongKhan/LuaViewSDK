//
//  LuaImageView.h
//  LuaViewSDK
//
//  Created by zhaotian on 2017/1/23.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "LuaView.h"

@interface LuaImageView : LuaView

@property (nonatomic, strong) NSString *imageName;
// contentMode
@property (nonatomic, assign) NSInteger scaleType;

@property (nonatomic, assign, readonly) BOOL isAnimating;

// 开始加载帧动画 图片数组 播放持续时长 重复次数
- (void)startAnimationImages:(NSArray *)images duration:(float)duration repeatCount:(float)repeatCount;
// 停止加载帧动画
- (void)stopAnimating;

@end
