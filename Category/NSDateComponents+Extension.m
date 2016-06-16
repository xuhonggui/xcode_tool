//
//  NSDateComponents+Extension.m
//  XBJob
//
//  Created by xuru on 15/12/9.
//  Copyright © 2015年 cnmobi. All rights reserved.
//

#import "NSDateComponents+Extension.h"

@implementation NSDateComponents (Extension)


+ (NSDateComponents *)dateComponentsWithdateFormartter:(NSString *)dateFormatter dateString:(NSString *)dateString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = dateFormatter;
    
    NSDate *date = [formatter dateFromString:dateString];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];

    
    return dateComponent;
}

+ (NSDateComponents *)dateComponents {
    
    NSDate *date = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    return dateComponent;
}

@end
