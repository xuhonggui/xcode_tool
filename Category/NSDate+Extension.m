//
//  NSDate+Extension.m
//  eFreshMall
//
//  Created by zlp on 16/3/28.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "NSDate+Extension.h"

#import "NSDateComponents+Extension.h"

@implementation NSDate (Extension)

+ (NSString*)getCurrentDateWithFormatter:(NSString*)formatter
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    
    NSString *systemTime = [dateFormatter stringFromDate:date];
    
    return systemTime;
}

+ (NSDate*)getDateWithString:(NSString*)dateStr formatter:(NSString*)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    
    NSDate *date = [dateFormatter dateFromString:dateStr];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    
    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    
    return localDate;
}

+ (NSString*)dateWithFormatter:(NSString*)formatter
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    NSString *dateStr = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)dateComponent.year, (long)dateComponent.month, (long)dateComponent.day];
    
    return dateStr;
}

+ (NSDateComponents*)getDateComponents:(NSUInteger)unitFlags
{
    NSDate *gmtDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:gmtDate];
    
    return components;
}

@end
