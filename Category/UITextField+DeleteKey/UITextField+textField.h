//
//  UITextField+textField.h
//  XBJob
//
//  Created by user on 15/10/31.
//  Copyright © 2015年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (textField)


/// 标准实例化
+ (UITextField *)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder font:(UIFont *)font textAlignment:(NSTextAlignment)alignment backColor:(UIColor *)backColor;

/// 标准实例化：keyboardType
+ (UITextField *)textFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment keyboardType:(UIKeyboardType)keyboardType;
@end
