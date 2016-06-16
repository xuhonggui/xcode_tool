//
//  UINavigationController+Extension.m
//  eFreshMall
//
//  Created by apple on 16/5/5.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "UINavigationController+Extension.h"

@implementation UINavigationController (Extension)

+ (UINavigationController*)setRootController:(id)rootVC isBarClearColor:(BOOL)isClearColor
{
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:rootVC];
    
    if (isClearColor)
    {
        /* 设置导航条透明 */
        [nav.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
        [nav.navigationBar setShadowImage:[[UIImage alloc]init]];
    }
    
    return nav;
}

@end
