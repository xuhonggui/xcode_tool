//
//  NSMutableAttributedString+Extension.m
//  eFreshMall
//
//  Created by zlp on 16/1/11.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "NSMutableAttributedString+Extension.h"

@implementation NSMutableAttributedString (Extension)

- (void)addAttributesWithString:(NSString*)string attributes:(NSDictionary*)dict
{
    /* 获取原始的字符串 */
    NSString *originalString = self.mutableString;
    
    /* 防止闪退 */
    if (string.length == 0)
    {
        return;
    }
    
    /* 计算范围 */
    NSRange range = [originalString rangeOfString:string];
    
    /* 添加属性 */
    [self addAttributes:dict range:range];
    
}


+ (NSMutableAttributedString*)createWithItem:(NSString*)item note:(NSString*)note
{
    NSString *originalString;
    
    /* 如果注释不为nil */
    if (note != nil)
    {
        originalString = [NSString stringWithFormat:@"%@%@", item, note];
    }
    else
    {
        originalString = [NSString stringWithFormat:@"%@", item];
    }
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:originalString];
    
    /* 如果注释不为nil */
    if (note != nil)
    {
        [attributedString addAttributesWithString:item attributes:@{NSFontAttributeName : kFont_14, NSForegroundColorAttributeName : [UIColor blackColor]}];
        [attributedString addAttributesWithString:note attributes:@{NSFontAttributeName : kFont_12, NSForegroundColorAttributeName : FMGreyColor}];
    }
    else
    {
        [attributedString addAttributesWithString:item attributes:@{NSFontAttributeName : kFont_14, NSForegroundColorAttributeName : [UIColor blackColor]}];
    }
    
    
    return attributedString;
}

+ (NSMutableAttributedString*)createWithItem:(NSString*)item {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:item];
    
    [attributedString addAttributesWithString:item attributes:@{NSFontAttributeName : kFont_12, NSForegroundColorAttributeName : FMGreyColor}];

    return attributedString;

}


@end
