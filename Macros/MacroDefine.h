//
//  MacroDefine.h
//  eFreshMall
//
//  Created by zlp on 16/4/28.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#ifndef MacroDefine_h
#define MacroDefine_h

/// 常用宏定义
#define kUserDefaults       [NSUserDefaults standardUserDefaults]

#define kNotificationCenter [NSNotificationCenter defaultCenter]

#define kApplication        [UIApplication sharedApplication]

#define kAppDelegate        (AppDelegate *)[[UIApplication sharedApplication] delegate]

#define kFileManager        [NSFileManager defaultManager]

#define kBundle             [NSBundle mainBundle]

#define kDevice             [UIDevice currentDevice]

#define kWindow             [[UIApplication sharedApplication] keyWindow]

#define kInfoDictionary     [[NSBundle mainBundle] infoDictionary]

#define kBundleVersion      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define kDocumentPath       [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define kCachesDirectoryPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define kBundleLoadNibName(name) [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] lastObject]

#define kDispatch_Global(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

#define KDispatch_Main(block) dispatch_async(dispatch_get_main_queue(),block)

#define kFMUser [FMUserInfo sharedInstance].user

#define kNetWorkingTool [FMNetWorkingTool sharedInstance]

#define kNetworkReachability [AFNetworkReachabilityManager sharedManager]

#define WEAK_SELF()  __weak __typeof(self) weakSelf = self;

#define kYUmengBeginPage(page) [MobClick beginLogPageView:page]

#define kYUmengEndPage(page) [MobClick endLogPageView:page]

//UIImage
#define FMImage(name) [UIImage imageNamed:name]

//屏幕的宽、高
#define SCREEN_W ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_H ([UIScreen mainScreen].bounds.size.height)
#define NAVIGATION_H 44
#define TABBAR_H 49
#define STATUSBAR_H 20
#define MARGIN 10

//判断iPhone型号
#define isiPhone4  (SCREEN_H == 480)
#define isiPhone5  (SCREEN_H == 568)
#define isiPhone6  (SCREEN_H == 667)
#define isiPhone6P (SCREEN_H == 736)


//判断系统版本
#define IOS_VERSION_6_OR_ABOVE ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IOS_VERSION_7_OR_ABOVE ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS_VERSION_8_OR_ABOVE ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

//类型转换
#define kIntToString(_i) [NSString stringWithFormat:@"%d", _i]
#define kFloatToString(_f) [NSString stringWithFormat:@"%f", _f]
#define kDoubleToString(_g) [NSString stringWithFormat:@"%g", _g]

//包装
#define NSNumWithUnsignedInteger(u)             ([NSNumber numberWithUnsignedInteger:u])
#define NSNumWithInt(i)                         ([NSNumber numberWithInt:i])
#define NSNumWithInteger(i)                     ([NSNumber numberWithInteger:i])
#define NSNumWithFloat(f)                       ([NSNumber numberWithFloat:f])
#define NSNumWithBool(b)                        ([NSNumber numberWithBool:b])

/* 
 打印
 __func__ 打印方法名 c字符串
 __LINE__ 打印行数
 ## "##"放在","和参数之间，那么如果参数留空的话，那么"##"前面的","就会删掉，从而防止编译错误。
 ((void)0) 在C、C++中表示无任何操作（详见http://stackoverflow.com/questions/2198950/why-is-void-0-a-no-operation-in-c-and-c）
 */
#ifdef DEBUG
//#define FMLog(...) NSLog(__VA_ARGS__)/* 不打印方法名、行数 */
#define FMLog(format, ...) NSLog((@"%s(%d)"format), __func__, __LINE__, ##__VA_ARGS__)
#else
#define FMLog(...) ((void)0)
#endif


#endif /* MacroDefine_h */
