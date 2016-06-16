//
//  AppFunction.h
//  eFreshMall
//
//  Created by apple on 16/5/5.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppFunction : NSObject

/// 从元转化为分，保留两位
+ (NSString *)getYuanFromFen:(NSString *)fenStr;
/// 转化年利率，前面一位
+ (NSString *)getRate:(NSString *)rateStr;
/// 不足三位前面补0
+ (NSString *)getThreeNum:(NSString *)str;
/// 获取手机唯一标示，手机重置后会不一样
+ (NSString *)getPhoneId;

/// 拨打电话号码，直接拨打
+ (void)telWithPhoneNumber:(NSString *)phoneNumber;
/// 拨打电话号码，弹出提示框
+ (void)telWithPhoneNumber:(NSString *)phoneNumber view:(UIView *)view;


/// 判断是否为整形
+ (BOOL)isPureInt:(NSString *)string;
/// 判断是否为浮点型
+ (BOOL)isPureFloat:(NSString *)string;

/// 将 num 四舍五入
+ (NSString *)round:(float)num afterPoint:(int)position;
/// 格式化小数 四舍五入类型
+ (NSString *)decimalwithFormat:(NSString *)format floatV:(float)floatV;



//  ///////////////// 常用方法 /////////////////////

+ (void)validateAppWithName:(NSString *)name;

#pragma mark - // 手机号 邮箱 验证方法

/// 根据比例（0...1）在min和max中取值
+ (float)lerp:(float)percent min:(float)nMin max:(float)nMax;


#pragma mark - // 其它

/// 获取 标准的json对象
+ (NSDictionary *)getJsonDicFromData:(NSData *)data;

/// 获取 标准的json对象，指定是否含有换行符
+ (NSDictionary *)getJsonDicFromData:(NSData *)data hasNewLine:(BOOL)hasNewLine;

/// 2.1 隐藏电池栏
+ (void)setStatusBarHidden:(BOOL)isHide;

/// 2.2 设置电池状态栏为默认样式 黑字
+ (void)setStatusBarStyleDefault;

/// 2.3. 设置电池状态栏为高亮样式 白字
+ (void)setStatusBarStyleLightContent;

///4. 通过button找到它所在的cell
+ (NSIndexPath *)getIndexPathForView:(UIView *)view;

/// 5. 手动打开或关闭闪光灯
//+ (void)turnTorchOn:(BOOL)on;

// 获取当前处于activity状态的view controller
+ (UIViewController *)activityViewController;

/* 判断是否是新版本 */
+ (BOOL)isNewVersion;

/* 对象序列化 */
+ (void)archiveObject:(id)object fileName:(NSString*)fileName;

/* 对象反序列化 */
+ (id)unArchiverObjectWithfileName:(NSString*)fileName;

/* 计算缓存大小 */
+ (CGFloat)getCacheFileSize;

/* 清除缓存 */
+ (void)clearDisk;

@end
