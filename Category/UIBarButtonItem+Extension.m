//
//  UIBarButtonItem+Extension.m
//  eFreshMall
//
//  Created by zlp on 15/12/22.
//  Copyright © 2015年 cnmobi. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+(void)adjustForLeftBarButtonItem:(UIBarButtonItem*)leftBarBtnItem andWidth:(CGFloat)width viewController:(UIViewController*)viewController
{
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
    {
        /* 空格 */
        UIBarButtonItem *negativeSpacer =
            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:
             UIBarButtonSystemItemFixedSpace target:nil action:nil];
        
        /* 向左偏移像素点 */
        negativeSpacer.width = width;
        
        viewController.navigationItem.leftBarButtonItems =
            @[negativeSpacer, leftBarBtnItem];
        
    }
    else
    {
        viewController.navigationItem.leftBarButtonItem = leftBarBtnItem;
    }
}

+(void)adjustForRightBarButtonItem:(UIBarButtonItem*)rightBarBtnItem andWidth:(CGFloat)width viewController:(UIViewController*)viewController
{
    
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
    {
        /* 空格 */
        UIBarButtonItem *negativeSpacer =
        [[UIBarButtonItem alloc]initWithBarButtonSystemItem:
         UIBarButtonSystemItemFixedSpace target:nil action:nil];
        
        /* 向左偏移像素点 */
        negativeSpacer.width = width;
        
        viewController.navigationItem.rightBarButtonItems =
        @[negativeSpacer, rightBarBtnItem];
        
    }
    else
    {
        viewController.navigationItem.rightBarButtonItem = rightBarBtnItem;
    }
}


@end
