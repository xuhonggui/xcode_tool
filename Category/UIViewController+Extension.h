//
//  UIViewController+Extension.h
//  eFreshMall
//
//  Created by zlp on 15/12/22.
//  Copyright © 2015年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

/* 左侧带logo返回按钮 */
- (UIImageView*)navigationLeftLogoButtonWithViewController:(UIViewController*)viewController;

/* 左边返回按钮 */
- (UIButton*)navigationLeftButtonWithTitle:(NSString*)title viewController:(UIViewController*)viewController;

/* 左边返回按钮--只有图片 */
- (UIButton*)navigationLeftButtonWithImage:(NSString*)image viewController:(UIViewController*)viewController;

/* 标题 */
- (UILabel*)navigationTitleViewWithTitle:(NSString*)title fontSize:(CGFloat)size viewController:(UIViewController*)viewController;

/* 标题 */
- (UILabel*)navigationTitleViewWithTitle:(NSString*)title fontSize:(CGFloat)size titleColor:(UIColor*)color viewController:(UIViewController*)viewController;

/* 右边按钮 */
- (UIButton*)navigationRightButtonWithTitle:(NSString*)title viewController:(UIViewController*)viewController;

/* 右边按钮--只有图片 */
- (UIButton*)navigationRightButtonWithImage:(NSString*)image viewController:(UIViewController*)viewController;

/* 背景图片 */
- (void)addBackgroundImageView:(NSString*)image viewController:(UIViewController*)viewController;

/* 搜索条 */
- (UISearchBar*)navigationSearchBarWithViewController:(UIViewController*)viewController;
//小红点
-(UIImageView *)navigationhotImage:(UIViewController *)controller;

/* 设置红点 */
- (void)setRedPoint:(UIImageView*)leftBtn;

/* 刷新头像 */
- (void)reSetLogo:(UIImageView*)leftBtn;

@end
