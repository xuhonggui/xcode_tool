//
//  MBProgressHUD+Extension.m
//  eFreshMall
//
//  Created by zlp on 16/3/8.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "MBProgressHUD+Extension.h"

@implementation MBProgressHUD (Extension)

+ (instancetype)showHudWithText:(NSString*)text view:(UIView*)view
{
    /* 提示 */
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}

- (void)singleShow
{
    self.mode = MBProgressHUDModeIndeterminate;
    self.labelText = nil;
    self.detailsLabelText = nil;
    [self show:YES];
}

- (void)showStatus:(NSString*)status
{
    self.mode = MBProgressHUDModeText;
    self.detailsLabelFont = kFont_14;
    self.detailsLabelText = status;
    [self hide:YES afterDelay:1.0f];
}

- (void)showLoading
{
    self.mode = MBProgressHUDModeIndeterminate;
    self.detailsLabelText = @"正在加载...";
    self.detailsLabelFont = kFont_14;
    [self show:YES];
}

- (void)showLogin
{
    self.mode = MBProgressHUDModeIndeterminate;
    self.detailsLabelText = @"登录中，请稍等...";
    self.detailsLabelFont = kFont_14;
    [self show:YES];
}

- (void)showErrorWithStatus:(NSString*)status
{
    self.mode = MBProgressHUDModeCustomView;
    UIImage *img = [[UIImage imageNamed:@"错误"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.customView = [[UIImageView alloc] initWithImage:img];
    self.detailsLabelText = status;
    self.detailsLabelFont = kFont_14;
    [self show:YES];
    [self hide:YES afterDelay:2.0f];
}

- (void)showSuccessWithStatus:(NSString*)status
{
    self.mode = MBProgressHUDModeCustomView;
    UIImage *img = [[UIImage imageNamed:@"成功"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.customView = [[UIImageView alloc] initWithImage:img];
    self.detailsLabelText = status;
    self.detailsLabelFont = kFont_14;
    [self show:YES];
    [self hide:YES afterDelay:2.0f];
}

- (void)showInfoWithStatus:(NSString*)status
{
    self.mode = MBProgressHUDModeCustomView;
    UIImage *img = [[UIImage imageNamed:@"提示"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.customView = [[UIImageView alloc] initWithImage:img];
    self.detailsLabelText = status;
    self.detailsLabelFont = kFont_14;
    [self show:YES];
    [self hide:YES afterDelay:2.0f];
}

@end
