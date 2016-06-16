//
//  UIBarButtonItem+Extension.h
//  eFreshMall
//
//  Created by zlp on 15/12/22.
//  Copyright © 2015年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/* 调整ios 7.0及以上leftBarButtonItem的位置偏移 */
+ (void)adjustForLeftBarButtonItem:(UIBarButtonItem*)leftBarBtnItem andWidth:(CGFloat)width viewController:(UIViewController*)viewController;

/* 调整ios 7.0及以上rightBarButtonItem的位置偏移 */
+ (void)adjustForRightBarButtonItem:(UIBarButtonItem*)rightBarBtnItem andWidth:(CGFloat)width viewController:(UIViewController*)viewController;

@end
