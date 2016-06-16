//
//  NSString+Extension.m
//  eFreshMall
//
//  Created by zlp on 15/12/29.
//  Copyright © 2015年 cnmobi. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

/* 计算字符串的高度 */
- (CGFloat)stringHeightWithFontsize:(CGFloat)size margin:(CGFloat)margin
{
    CGSize maxSize = CGSizeMake(SCREEN_W - 2 * margin, MAXFLOAT);
    
    CGFloat height = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:size]} context:nil].size.height;
    
    return height;
}

/// 获取字符串大小
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    CGSize newsize;
    if(IOS_VERSION_7_OR_ABOVE) {
        NSDictionary *attribute = @{ NSFontAttributeName: font };
        newsize = [self boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }else {
        newsize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    return newsize;
}


- (NSString*)getChineseNumberString
{
    NSArray *arabNumbers = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    
    NSArray *chineseNumbers = @[@"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十"];
    
    NSDictionary *numberDic = [NSDictionary dictionaryWithObjects:chineseNumbers forKeys:arabNumbers];
    
    return [numberDic valueForKey:self];
}

- (NSString*)convertToRoundFont
{
    NSArray *roundFonts = @[@"①", @"②", @"③", @"④", @"⑤", @"⑥", @"⑦", @"⑧", @"⑨", @"⑩"];
    NSArray *normalFonts = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    
    NSDictionary *fontDic = [NSDictionary dictionaryWithObjects:roundFonts forKeys:normalFonts];
    
    return [fontDic valueForKey:self];
}

/* 判断手机号码 */
+ (BOOL)checkPhoneNumber:(NSString*)phone
{
    NSString *phoneNum = phone;
    
    NSString *regular = @"^1+[3578]+\\d{9}";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    
    BOOL flag = [predicate evaluateWithObject:phoneNum];
    
    return flag;
}

/* 验证密码合法性（字母、数字、下划线） */
+ (BOOL)checkPassword:(NSString*)pwd
{
    NSString *password = pwd;
    
    NSString *regular = @"^[A-Za-z0-9_]{6,15}$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    
    BOOL flag = [predicate evaluateWithObject:password];
    
    return flag;
}

/* 检查是否是数字 */
+ (BOOL)checkNumber:(NSString*)number
{
    NSString *regular = @"^(0|[1-9][1-9]*)(.[0-9]{1,2})?$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    
    BOOL flag = [predicate evaluateWithObject:number];
    
    return flag;
}

/* 判断是否为0 */
+ (BOOL)checkZeroNumber:(NSString*)number
{
    NSString *regular = @"^[0]*(.[0]*)?$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    
    BOOL flag = [predicate evaluateWithObject:number];
    
    return flag;
}

/* 6位数字密码 */
+ (BOOL)checkPayPassword:(NSString*)number
{
    NSString *regular = @"^[0-9]{6}$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regular];
    
    return [predicate evaluateWithObject:number];
}

/* 获取安全账户名 */
+ (NSString*)getSafeAccountName:(NSString*)name
{
    if (name.length == 0)
    {
        return name;
    }
    
    if (name.length == 1)
    {
        return [name stringByAppendingString:@"***"];
    }
    
    if (name.length == 2)
    {
        return [name stringByReplacingCharactersInRange:NSMakeRange(1, 1) withString:@"***"];
    }
    
    return [name stringByReplacingCharactersInRange:NSMakeRange(1, name.length - 2) withString:@"***"];
}

+ (NSString*)getSafePhone:(NSString*)phone
{
    if (phone.length == 0
        || [phone isEqualToString:@""]
        || phone == nil) {
        return phone;
    }

    NSString *safePhone = [phone stringByReplacingCharactersInRange:NSMakeRange(4, 4) withString:@"****"];
    
    return safePhone;
}

- (BOOL)isNull
{
    if ([self isEqualToString:@""]
        || self.length == 0
        || self == nil)
    {
        return YES;
    }
    
    return NO;
}

@end
