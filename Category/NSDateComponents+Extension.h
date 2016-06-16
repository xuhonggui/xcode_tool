//
//  NSDateComponents+Extension.h
//  XBJob
//
//  Created by xuru on 15/12/9.
//  Copyright © 2015年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDateComponents (Extension)

//取出固定字符串时间的时分秒
+ (NSDateComponents *)dateComponentsWithdateFormartter:(NSString *)dateFormatter dateString:(NSString *)dateString;

//取出当前时间的时分秒
+ (NSDateComponents *)dateComponents;

@end
