//
//  LuaImageView.m
//  LuaViewSDK
//
//  Created by zhaotian on 2017/1/23.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "LuaImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface LuaImageView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation LuaImageView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _imageView = [[UIImageView alloc]init];
        super._view = _imageView;
    }
    return self;
}

#pragma mark ----------------- getter && setter ----------

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    [self imageName:imageName placeholderImage:nil];
}
- (NSString *)image {
    return _imageName;
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
    if ([PublicUtil isExternalUrl:imageName]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:placeholder]];
    }
    else {
        [self.imageView setImage:[UIImage imageNamed:imageName]];
    }
}
#pragma mark ------------------ API -------------------------
- (void)startAnimationImages:(NSArray *)images duration:(float)duration repeatCount:(float)repeatCount {
    NSMutableArray *imagesArray = [NSMutableArray array];
    UIImage *image;
    if (images.count > 1) {
        for (NSString *imageName in images) {
            NSArray *array = [imageName componentsSeparatedByString:@"."];
            if (array.count > 1) {
                image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:array[0] ofType:array[1]]];
            } else {
                image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:nil]];
            }
            [imagesArray addObject:image];
        }
        self.imageView.animationImages = imagesArray;
        self.imageView.animationDuration = duration;
        self.imageView.animationRepeatCount = repeatCount;
        [self.imageView startAnimating];
    }
}

- (void)stopAnimating {
    if (self.imageView.isAnimating) {
        [self.imageView stopAnimating];
    }
}

@end
