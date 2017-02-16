//
//  LuaTextField.m
//  LuaViewSDK
//
//  Created by zhaotian on 2017/1/19.
//  Copyright © 2017年 王金东. All rights reserved.
//

#import "LuaTextField.h"

@interface LuaTextField ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;

@end
@implementation LuaTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        _textField = [[UITextField alloc]init];
        _textField.delegate = self;
        super._view = _textField;
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
        CGSize size = [self.text boundingRectWithSize:CGSizeMake(maxW,maxH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.textField.font} context:nil].size;
        CGFloat height = size.height;
        if (self.maxHeight > 0 && height > self.maxHeight) {
            height = self.maxHeight;
        }
        return CGRectMake(x.floatValue, y.floatValue, size.width+10, height+10);
    }
    return CGRectMake(x.floatValue, y.floatValue, w, h);
}

#pragma mark --------------- setter && getter

- (void)setText:(NSString *)text {
    _text = text;
    self.textField.text = text;
}
- (void)setTextColor:(NSString *)textColor {
    _textColor = textColor;
    self.textField.textColor = [UIColorUtil colorWithHexString:textColor];
}

- (void)setHint:(NSString *)hint {
    _hint = hint;
    _placeholder = hint;
    self.textField.placeholder = hint;
}

- (void)setPlaceholder:(NSString *)placeholder {
    [self setHint:placeholder];
}
#pragma mark --------------- delegate
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return YES;
}
@end
