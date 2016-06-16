//
//  NSDate+Extension.h
//  eFreshMall
//
//  Created by zlp on 16/3/28.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/* 获取系统时间 */
+ (NSString*)getCurrentDateWithFormatter:(NSString*)formatter;

/* 获取系统时间 */
+ (NSString*)dateWithFormatter:(NSString*)formatter;

/* 将日期由NSString转换为NSDate */
+ (NSDate*)getDateWithString:(NSString*)dateStr formatter:(NSString*)formatter;

/* 获取时间组件 */
+ (NSDateComponents*)getDateComponents:(NSUInteger)unitFlags;

@end
