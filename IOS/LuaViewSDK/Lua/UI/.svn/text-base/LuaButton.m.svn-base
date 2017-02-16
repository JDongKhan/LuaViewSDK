//
//  LuaButton.m
//  LuaView
//
//  Created by 王金东 on 17/1/16.
//  Copyright © 2017年 wangjindong. All rights reserved.
//

#import "LuaButton.h"
#import "LSCValue.h"
#import <SDWebImage/UIButton+WebCache.h>
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
    NSNumber *x = self.frame[0];
    NSNumber *y = self.frame[1];
    NSNumber *width = self.frame[2];
    NSNumber *height = self.frame[3];
    CGFloat w = width.floatValue;
    CGFloat h = height.floatValue;
    if (w == -1 || h == -1) {
        CGFloat maxW = (w == -1)?MAXFLOAT:w;
        CGFloat maxH = (h == -1)?MAXFLOAT:h;
        CGSize size = [self.button.currentTitle boundingRectWithSize:CGSizeMake(maxW,maxH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.button.titleLabel.font} context:nil].size;
        return CGRectMake(x.floatValue, y.floatValue, size.width+10, size.height+10);
    }
    return CGRectMake(x.floatValue, y.floatValue, w, h);
}

#pragma mark --------------- setter && getter

- (void)setBackgroundImage:(NSString *)backgroundImage {
    [self setBackgroundImageUrl:backgroundImage forState:UIControlStateNormal];
}

- (void)setImage:(NSString *)image {
    [self setImageUrl:image forState:UIControlStateNormal];
}

- (void)setText:(NSString *)text {
    [self.button setTitle:text forState:UIControlStateNormal];
}
- (NSString *)text {
    return [self.button currentTitle];
}

- (void)setTextColor:(NSString *)textColor {
    [self setButtonTitleColor:textColor forState:UIControlStateNormal];
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

#pragma mark --------------- privateFunction

- (void)setBackgroundImageUrl:(NSString*)url forState:(UIControlState) state {
    if (url) {
        if ([PublicUtil isExternalUrl:url]) {
            [self setBackgroundImageUrl:url forState:state];
        } else {
            [self.button setBackgroundImage:[UIImage imageNamed:url] forState:state];
        }
    }
}
-(void) setWebBackgroundImageUrl:(NSString*)url forState:(UIControlState) state {
    [self.button sd_setBackgroundImageWithURL:[NSURL URLWithString:url] forState:state placeholderImage:nil];
}


-(void) setImageUrl:(NSString*)url forState:(UIControlState) state{
    if (url) {
        if ([PublicUtil isExternalUrl:url]) {
            [self setWebImageUrl:url forState:state];
        } else {
            [self.button setImage:[UIImage imageNamed:url] forState:state];
        }
    }
}
-(void) setWebImageUrl:(NSString*)url forState:(UIControlState) state {
    [self.button sd_setImageWithURL:[NSURL URLWithString:url] forState:state placeholderImage:nil];
}

- (void)setButtonTitle:(NSString *)title forState:(UIControlState) state {
    if (title) {
        [self.button setTitle:title forState:state];
    }
}

- (void)setButtonTitleColor:(NSString *)titleColor forState:(UIControlState)state {
    if (titleColor) {
        [self.button setTitleColor:[UIColorUtil colorWithHexString:titleColor] forState:state];
    }
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
