//
//  LuaButton.m
//  LuaView
//
//  Created by 王金东 on 17/1/16.
//  Copyright © 2017年 wangjindong. All rights reserved.
//

#import "LuaButton.h"
#import "LSCValue.h"
#import "NetworkManager.h"
@interface LuaButton ()

@property (nonatomic,strong) UIButton *button;

@end


@implementation LuaButton{
    LSCFunction *_callBack;
}


- (instancetype)init {
    if (self == [super init]) {
        _button = [[UIButton alloc] init];
        _button.titleLabel.numberOfLines = 0;
        super._view = _button;
    }
    return self;
}

- (CGRect)_resize {
    CGFloat w = self._margin.w;
    CGFloat h = self._margin.h;
    if (w == MATCH_PARENT || h == MATCH_PARENT) {
        CGFloat maxW = (w == MATCH_PARENT)?MAXFLOAT:w;
        CGFloat maxH = (h == MATCH_PARENT)?MAXFLOAT:h;
        CGSize size = [self.button.currentTitle boundingRectWithSize:CGSizeMake(maxW,maxH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.button.titleLabel.font} context:nil].size;
        return CGRectMake(self._margin.l, self._margin.t, size.width+10, size.height+10);
    }
    return CGRectMake(self._margin.l, self._margin.t, w, h);
}

#pragma mark --------------- setter && getter

- (void)setBackgroundImage:(NSString *)backgroundImage {
    _backgroundImage = backgroundImage;
    __weak LuaButton *weakSelf = self;
    [NetworkManager downImage:backgroundImage callBack:^(UIImage *image) {
        [weakSelf.button setBackgroundImage:image forState:UIControlStateNormal];
    }];
}

- (void)setImage:(NSString *)image {
    _image = image;
    __weak LuaButton *weakSelf = self;
    [NetworkManager downImage:image callBack:^(UIImage *image) {
        [weakSelf.button setImage:image forState:UIControlStateNormal];
    }];
}
- (void)setLeftImage:(NSString *)leftImage {
    _leftImage = leftImage;
    __weak LuaButton *weakSelf = self;
    [NetworkManager downImage:leftImage callBack:^(UIImage *image) {
        [weakSelf.button setImage:image forState:UIControlStateNormal];
    }];
}
- (void)setTopImage:(NSString *)topImage {
    _topImage = topImage;
    __weak LuaButton *weakSelf = self;
    [NetworkManager downImage:topImage callBack:^(UIImage *image) {
        [weakSelf.button setImage:image forState:UIControlStateNormal];
        weakSelf.button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        [weakSelf.button setTitleEdgeInsets:UIEdgeInsetsMake(weakSelf.button.imageView.frame.size.height+10 ,-weakSelf.button.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [weakSelf.button setImageEdgeInsets:UIEdgeInsetsMake(-10, 0.0,0.0, -weakSelf.button.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
    }];
}
- (void)setRightImage:(NSString *)rightImage {
    _rightImage = rightImage;
    __weak LuaButton *weakSelf = self;
    [NetworkManager downImage:rightImage callBack:^(UIImage *image) {
        [weakSelf.button setImage:image forState:UIControlStateNormal];
        [weakSelf.button setTitleEdgeInsets:UIEdgeInsetsMake(0, -weakSelf.button.imageView.bounds.size.width, 0, weakSelf.button.imageView.bounds.size.width)];
        [weakSelf.button setImageEdgeInsets:UIEdgeInsetsMake(0, weakSelf.button.titleLabel.bounds.size.width, 0, -weakSelf.button.titleLabel.bounds.size.width)];
    }];
}
- (void)setBottomImage:(NSString *)bottomImage {
    _bottomImage = bottomImage;
    __weak LuaButton *weakSelf = self;
    [NetworkManager downImage:bottomImage callBack:^(UIImage *image) {
        [weakSelf.button setImage:image forState:UIControlStateNormal];
    }];
}

- (void)setText:(NSString *)text {
    [self.button setTitle:text forState:UIControlStateNormal];
}
- (NSString *)text {
    return [self.button currentTitle];
}

- (void)setTextColor:(NSString *)textColor {
    [self.button setTitleColor:[UIColorUtil colorWithHexString:textColor] forState:UIControlStateNormal];
}

- (void)setFontSize:(NSString *)fontSize {
    [self.button.titleLabel setFont:[UIFont systemFontOfSize:fontSize.floatValue]];
}
- (void)setTextSize:(NSString *)textSize {
    [self setFontSize:textSize];
}

- (void)setEnable:(BOOL)enable {
    self.button.enabled = enable;
}
- (BOOL)enable {
    return self.button.enabled;
}

- (void)setSelected:(BOOL)selected {
    self.button.selected = selected;
}
- (BOOL)selected {
    return self.button.selected;
}

#pragma mark --------------- API

- (void)click:(LSCFunction *)callBack {
    _callBack = callBack;
    [self.button addTarget:self action:@selector(_click:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)_click:(id)sender{
    [_callBack invokeWithArguments:@[[LSCValue objectValue:self]]];
}

- (void)dealloc {
    
}


@end
