//
//  LuaLabel.m
//  LuaViewSDK
//
//  Created by zhaotian on 2017/1/19.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "LuaLabel.h"

@interface LuaLabel ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIScrollView *scrollView;


@end
@implementation LuaLabel

- (instancetype)init {
    if (self == [super init]) {
        _label = [[UILabel alloc] init];
        _label.numberOfLines = 0;
        self.fontSize = 14;
        super._view = _label;
    }
    return self;
}
- (void)_layout {
    if (self.verticalScrollBarEnabled) {
        _scrollView = [[UIScrollView alloc] init];
        [_scrollView addSubview:_label];
        super._view = _scrollView;
    }
}


- (CGRect)_resize {
    CGFloat w = self._margin.w;
    CGFloat h = self._margin.h;
    if (w == MATCH_PARENT || h == MATCH_PARENT) {
        CGFloat maxW = (w == MATCH_PARENT)?MAXFLOAT:w;
        CGFloat maxH = (h == MATCH_PARENT)?MAXFLOAT:h;
        CGSize size = [self.text boundingRectWithSize:CGSizeMake(maxW,maxH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.label.font} context:nil].size;
        CGFloat height = size.height;
        if (self.maxHeight > 0 && height > self.maxHeight) {
            height = self.maxHeight;
        }
        _label.frame = CGRectMake(self._margin.l, self._margin.t, size.width+10,size.height+10);
        _scrollView.contentSize = _label.bounds.size;
        return CGRectMake(self._margin.l, self._margin.t, size.width+10,height+10);
    }
    return CGRectMake(self._margin.l, self._margin.t, w, h);
}
#pragma mark --------------- setter && getter
- (void)setText:(NSString *)text {
    _text = text;
    self.label.text = text;
}

- (void)setBold:(BOOL)bold {
    _bold = bold;
    self.label.font = [UIFont boldSystemFontOfSize:_fontSize];
}

- (void)setTextColor:(NSString *)textColor {
    self.label.textColor = [UIColorUtil colorWithHexString:textColor];
}

- (void)setFontSize:(float)fontSize {
    _fontSize = fontSize;
    self.label.font = [UIFont systemFontOfSize:fontSize];
}

- (void)setEllipsis:(NSInteger)ellipsis {
    _ellipsis = ellipsis;
    self.label.lineBreakMode = ellipsis;
}

- (void)setLineCount:(NSInteger)lineCount {
    _lineCount = lineCount;
    self.label.numberOfLines = lineCount;
}

- (void)setTextAlignment:(NSInteger)textAlignment {
    _textAlignment = textAlignment;
    self.label.textAlignment = textAlignment;
}

- (void)setAdjustFontSize:(BOOL)adjustFontSize {
    _adjustFontSize = adjustFontSize;
    self.label.adjustsFontSizeToFitWidth = adjustFontSize;
}

#pragma mark --------------- privateFunction
#pragma mark --------------- API
- (void)stringSizeForString:(NSString *)string width:(float)width height:(float)height fontSize:(float)fontSize {
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]} context:nil].size;
    CGRect frame = CGRectMake(self.label.frame.origin.x, self.label.frame.origin.y, size.width, size.height);
    self.label.frame = frame;
    self.label.text = string;
}

@end
