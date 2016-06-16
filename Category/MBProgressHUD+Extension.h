//
//  MBProgressHUD+Extension.h
//  eFreshMall
//
//  Created by zlp on 16/3/8.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Extension)

+ (instancetype)showHudWithText:(NSString*)text view:(UIView*)view;

/* 显示菊花 */
- (void)singleShow;

/* 文本提示 */
- (void)showStatus:(NSString*)status;

/* 加载 */
- (void)showLoading;

/* 登录 */
- (void)showLogin;

/* 显示错误提示 */
- (void)showErrorWithStatus:(NSString*)status;

/* 显示成功提示 */
- (void)showSuccessWithStatus:(NSString*)status;

/* 显示警告 */
- (void)showInfoWithStatus:(NSString*)status;

@end
