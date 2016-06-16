//
//  UINavigationController+Extension.h
//  eFreshMall
//
//  Created by apple on 16/5/5.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Extension)

/**
 * 获取对象
 * isClearColor 导航条是否透明 
 */
+ (UINavigationController*)setRootController:(id)rootVC isBarClearColor:(BOOL)isClearColor;

@end
