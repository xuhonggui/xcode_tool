//
//  UILabel+LH.m
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UILabel+LH.h"

@implementation UILabel (LH)

/// 标准实例化
+ (UILabel *)labelTextCenterWithFrame:(CGRect)rect text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)alignment backColor:(UIColor *)backColor
{
    UILabel *label        = [[UILabel alloc] initWithFrame:rect];
    label.text            = text;
    label.textColor       = textColor;
    label.font            = font;
    label.textAlignment   = alignment;
    label.backgroundColor = backColor;
    
    return label;
}

/**
 *  创建自适应高度的label，frame的高度将会被忽略
 */
+ (UILabel *)labelAdaptionWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)alignment {
    // 测量高度
    CGSize measureSize = [text getSizeWithFont:font constrainedToSize:CGSizeMake(frame.size.width, MAXFLOAT)];
    frame.size.height = measureSize.height;
    
    UILabel *label = [self labelTextCenterWithFrame:frame text:text textColor:textColor font:font textAlignment:alignment backColor:[UIColor clearColor]];
    label.numberOfLines = 0;
    
    return label;
}

@end


#pragma mark - VerticalAlign

@implementation UILabel (VerticalAlign)

/**
 *  顶部对齐
 */
-(void)alignTop {
    CGSize fontSize =[self.text sizeWithFont:self.font];
    double finalHeight = fontSize.height *self.numberOfLines;
    double finalWidth =self.frame.size.width;//expected width of label
    CGSize theStringSize =[self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad =(finalHeight - theStringSize.height)/ fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text =[self.text stringByAppendingString:@"\n "];
}

/**
 *  底部对齐
 */
-(void)alignBottom {
    CGSize fontSize =[self.text sizeWithFont:self.font];
    double finalHeight = fontSize.height *self.numberOfLines;
    double finalWidth =self.frame.size.width;//expected width of label
    CGSize theStringSize =[self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad =(finalHeight - theStringSize.height)/ fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text =[NSString stringWithFormat:@" \n%@",self.text];
}

@end
