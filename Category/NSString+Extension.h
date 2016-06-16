//
//  NSString+Extension.h
//  eFreshMall
//
//  Created by zlp on 15/12/29.
//  Copyright © 2015年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/* 计算字符串的高度 */
- (CGFloat)stringHeightWithFontsize:(CGFloat)size margin:(CGFloat)margin;

/* 获取字符串大小 */
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

/* 阿拉伯数字转中文 */
- (NSString*)getChineseNumberString;

/* 转换为圆圈数字 */
- (NSString*)convertToRoundFont;

/* 判断手机手机号码 */
+ (BOOL)checkPhoneNumber:(NSString*)phone;

/* 判断密码合法性 */
+ (BOOL)checkPassword:(NSString*)pwd;

/* 检查是否是数字 */
+ (BOOL)checkNumber:(NSString*)number;

/* 判断是否为0 */
+ (BOOL)checkZeroNumber:(NSString*)number;

/* 6位数字密码 */
+ (BOOL)checkPayPassword:(NSString*)number;

/* 获取安全账户名 */
+ (NSString*)getSafeAccountName:(NSString*)name;

/* 获取安全手机号 */
+ (NSString*)getSafePhone:(NSString*)phone;

/* 判断是否为空 */
- (BOOL)isNull;

@end
