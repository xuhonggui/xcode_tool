//
//  SlideNavigationController+Extension.m
//  eFreshMall
//
//  Created by zlp on 16/5/6.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "SlideNavigationController+Extension.h"

@implementation SlideNavigationController (Extension)

+ (instancetype)setLeftMenu:(id)leftMenu childController:(id)childController
{
    /* 获取侧滑导航控制器 */
    SlideNavigationController *slideNC = [SlideNavigationController sharedInstance];
    
    /* 设置左边侧滑控制器 */
    slideNC.leftMenu = leftMenu;
    
    TabBarViewController *childVC = [slideNC.childViewControllers firstObject];
    if (childVC)
    {
        [childVC removeFromParentViewController];
    }
    
    [slideNC addChildViewController:childController];

    
    return slideNC;
}

@end
