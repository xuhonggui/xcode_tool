//
//  NSMutableAttributedString+Extension.h
//  eFreshMall
//
//  Created by zlp on 16/1/11.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Extension)

/* 为字符串添加不同的属性 */
- (void)addAttributesWithString:(NSString*)string attributes:(NSDictionary*)dict;

/* 商家资料专用 */
+ (NSMutableAttributedString*)createWithItem:(NSString*)item note:(NSString*)note;

+ (NSMutableAttributedString*)createWithItem:(NSString*)item;

@end
