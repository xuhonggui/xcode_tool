//
//  UILabel+LH.h
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LH)

/// 标准实例化
+ (UILabel *)labelTextCenterWithFrame:(CGRect)rect text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)alignment backColor:(UIColor *)backColor;

/**
 *  创建自适应高度的label，frame的高度将会被忽略
 */
+ (UILabel *)labelAdaptionWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)alignment;

@end

#pragma mark - VerticalAlign

@interface UILabel (VerticalAlign)

/**
 *  顶部对齐
 */
-(void)alignTop;

/**
 *  底部对齐
 */
-(void)alignBottom;

@end
