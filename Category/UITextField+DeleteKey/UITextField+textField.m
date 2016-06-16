//
//  UITextField+textField.m
//  XBJob
//
//  Created by user on 15/10/31.
//  Copyright © 2015年 cnmobi. All rights reserved.
//

#import "UITextField+textField.h"

@implementation UITextField (textField)



/// 标准实例化
+ (UITextField *)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment backColor:(UIColor *)backColor {
    UITextField *textField = [UITextField textFieldWithFrame:frame placeholder:placeholder font:font textAlignment:textAlignment keyboardType:UIKeyboardTypeDefault];
    textField.backgroundColor = backColor;
    
    return textField;
}

/// 标准实例化：keyboardType
+ (UITextField *)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType {
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.placeholder  = placeholder;
    textField.font = font;
    textField.textAlignment = textAlignment;
    textField.keyboardType = keyboardType;
    
    // default
//    textField.backgroundColor = [UIColor clearColor];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.text = @"";    // iOS6下text没有默认值，为nil
    
    return textField;
}
@end
