//
//  ProjectSetting.m
//  eFreshMall
//
//  Created by apple on 16/5/5.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "ProjectSetting.h"

#import <IQKeyboardManager.h>

#import <AFNetworking.h>

@implementation ProjectSetting

+ (void)setUp
{
    /* 设置键盘 */
    [self setKeyBoard];
    
    /* 开始友盟统计 */
    [self setUMengAnalytics];
}

+ (void)setKeyBoard
{
    [IQKeyboardManager sharedManager].shouldShowTextFieldPlaceholder = NO;
}

+ (void)clearCache
{
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
}

+ (void)setUMengAnalytics
{
    [MobClick setAppVersion:kBundleVersion];
    [MobClick startWithAppkey:UMENG_APPKEY];
}

@end
