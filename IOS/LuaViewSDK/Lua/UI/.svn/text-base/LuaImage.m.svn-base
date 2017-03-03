//
//  LuaImage.m
//  LuaViewSDK
//
//  Created by zhaotian on 2017/1/23.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "LuaImage.h"
#import "NetworkManager.h"

@interface LuaImage ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LuaImage{
    NSString *_image;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        _imageView = [[UIImageView alloc]init];
        super._view = _imageView;
    }
    return self;
}

#pragma mark ----------------- getter && setter ----------

- (void)setImage:(NSString *)image {
    _image = image;
    [self imageName:image placeholderImage:nil];
}
- (NSString *)image {
    return _image;
}

- (void)setScaleType:(NSInteger)scaleType {
    _scaleType = scaleType;
    self.imageView.contentMode = scaleType;
}

- (BOOL)isAnimating {
    return self.imageView.isAnimating;
}

#pragma mark ------------------ private --------------------
- (void)imageName:(NSString *)imageName placeholderImage:(NSString *)placeholder{
    __weak LuaImage *weakSelf = self;
    [NetworkManager downImage:imageName callBack:^(UIImage *image) {
        weakSelf.imageView.image = image;
    }];
}
#pragma mark ------------------ API -------------------------

- (void)stopAnimating {
    if (self.imageView.isAnimating) {
        [self.imageView stopAnimating];
    }
}

@end
