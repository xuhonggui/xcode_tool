//
//  AppFunction.m
//  eFreshMall
//
//  Created by apple on 16/5/5.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "AppFunction.h"

@implementation AppFunction

/// 从元转化为分，保留两位
+ (NSString *)getYuanFromFen:(NSString *)fenStr {
    if (!fenStr || fenStr.length == 0) {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%.2f", [fenStr doubleValue] * 10.0 / 1000.0];
}

/// 转化年利率，前面一位
+ (NSString *)getRate:(NSString *)rateStr {
    if (!rateStr || rateStr.length == 0) {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%f", [rateStr doubleValue] / 1000000];
}

/// 不足三位前面补0
+ (NSString *)getThreeNum:(NSString *)str {
    if (!str || str.length == 0) {
        return @"";
    }
    
    return [NSString stringWithFormat:@"%.3d", [str intValue]];
}

/// 获取手机唯一标示，手机重置后会不一样
+ (NSString *)getPhoneId {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

/// 拨打电话号码，直接拨打
+ (void)telWithPhoneNumber:(NSString *)phoneNumber {
    NSString * str = [NSString stringWithFormat:@"tel:%@", phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

/// 拨打电话号码，弹出提示框
+ (void)telWithPhoneNumber:(NSString *)phoneNumber view:(UIView *)view {
    NSString *str = [NSString stringWithFormat:@"tel:%@", phoneNumber];
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [view addSubview:callWebview];
}


/// 判断是否为整形
+ (BOOL)isPureInt:(NSString *)string {
    NSScanner *scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

/// 判断是否为浮点型
+ (BOOL)isPureFloat:(NSString *)string {
    NSScanner *scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}


/// 将 num 四舍五入
+ (NSString *)round:(float)num afterPoint:(int)position {
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumber *ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:num];
    NSDecimalNumber *roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@", roundedOunces];
}


/// 格式化小数 四舍五入类型
+ (NSString *)decimalwithFormat:(NSString *)format floatV:(float)floatV {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}


+ (void)validateAppWithName:(NSString *)name
{
    void (^GetDataFinishBlock) (NSData *data) = ^(NSData *data)
    {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString *result = [dic objectForKey:@"result"];
        if([result intValue] != 0)
            return;
        
        //    NSLog(@"app result type: %@", [dic objectForKey:@"type"]);
        if([[dic objectForKey:@"type"] intValue] == 1)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"当前版本即将不可用，请联系您的软件供应商" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else if([[dic objectForKey:@"type"] intValue] == 2)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"当前版本已不可用，请联系您的软件供应商" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alert show];
            //            #define kBlueColor
            // 延迟5秒执行：
            double delayInSeconds = 5.0;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                // code to be executed on the main queue after delay
                exit(0);
            });
        }
    };
    
    //  后台执行：
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *urlStr = [NSString stringWithFormat:@"http://121.199.61.107/AppValidate/findByName.action?name=%@", name];
        NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlStr]];
        if(!data)
            return;
        
        // 主线程执行：
        dispatch_async(dispatch_get_main_queue(), ^{
            // something
            GetDataFinishBlock(data);
        });
    });
}


#pragma mark - // 手机号 邮箱 车牌号 身份证 验证方法

/// 根据比例（0...1）在min和max中取值
+ (float)lerp:(float)percent min:(float)nMin max:(float)nMax {
    /*0--1 : lerp( float percent, float x, float y ){ return x + ( percent * ( y - x ) ); };*/
    float result = nMin;
    
    result = nMin + percent * (nMax - nMin);
    
    return result;
}


#pragma mark - // 其它

/// 获取 标准的json对象
+ (NSDictionary *)getJsonDicFromData:(NSData *)data
{
    return [self getJsonDicFromData:data hasNewLine:YES];
}

/// 获取 标准的json对象，指定是否含有换行符
+ (NSDictionary *)getJsonDicFromData:(NSData *)data hasNewLine:(BOOL)hasNewLine
{
    // 如果有换行符，先替换掉
    if (data && data.length > 0 && hasNewLine) {
        NSString *tmpStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        tmpStr = [tmpStr stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
        data = [tmpStr dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if(error)
    {
        NSLog(@"json转换错误：%@", error.description);
        return nil;
    }
    
    return dic;
}


// 设置状态栏文字的样式（要在plist文件中禁用viewController对状态栏的操作）
/// 2.1 隐藏电池栏
+ (void)setStatusBarHidden:(BOOL)isHide
{
    [[UIApplication sharedApplication] setStatusBarHidden:isHide];
}

/// 2.2 设置电池状态栏为默认样式 黑字
+ (void)setStatusBarStyleDefault
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}

/// 2.3. 设置电池状态栏为高亮样式 白字
+ (void)setStatusBarStyleLightContent
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}

/// 4. 通过button找到它所在的cell
+ (NSIndexPath *)getIndexPathForView:(UIView *)view
{
    UITableViewCell *cell = (UITableViewCell *)[view superview];
    
    while (![cell isKindOfClass:[UITableViewCell class]])
    {
        cell = (UITableViewCell *)[cell superview];
    }
    
    if(cell == nil)
    {
        NSLog(@"error");
        return nil;
    }
    
    UITableView *tableView = (UITableView *)[cell superview];
    while (![tableView isKindOfClass:[UITableView class]])
    {
        tableView = (UITableView *)[tableView superview];
    }
    
    if(tableView == nil)
    {
        NSLog(@"error");
        return nil;
    }
    
    NSIndexPath *indexPath = [tableView indexPathForCell:cell];
    
    return indexPath;
}

/// 5. 手动打开或关闭闪光灯   要导入：#import <AVFoundation/AVFoundation.h>
//+ (void)turnTorchOn:(BOOL)on
//{
//    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
//    if (captureDeviceClass != nil) {
//        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//        if ([device hasTorch] && [device hasFlash])
//        {
//            [device lockForConfiguration:nil];
//            if (on)
//            {
//                [device setTorchMode:AVCaptureTorchModeOn];
//                [device setFlashMode:AVCaptureFlashModeOn];
//            }
//            else
//            {
//                [device setTorchMode:AVCaptureTorchModeOff];
//                [device setFlashMode:AVCaptureFlashModeOff];
//            }
//            [device unlockForConfiguration];
//        }
//    }
//}



// #pragma mark 文本数据进行DES加密
// #import <CommonCrypto/CommonDigest.h>
// #import <CommonCrypto/CommonCryptor.h>
/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES加密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
/*
 + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 {
 char keyPtr[kCCKeySizeAES256+1];
 bzero(keyPtr, sizeof(keyPtr));
 
 [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
 
 NSUInteger dataLength = [data length];
 
 size_t bufferSize = dataLength + kCCBlocCGSizeMakeAES128;
 void *buffer = malloc(bufferSize);
 
 size_t numBytesEncrypted = 0;
 CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
 kCCOptionPKCS7Padding | kCCOptionECBMode,
 keyPtr, kCCBlocCGSizeMakeDES,
 NULL,
 [data bytes], dataLength,
 buffer, bufferSize,
 &numBytesEncrypted);
 if (cryptStatus == kCCSuccess)
 {
 return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
 }
 
 free(buffer);
 return nil;
 }
 */

/******************************************************************************
 函数名称 : + (NSData *)DESEncrypt:(NSData *)data WithKey:(NSString *)key
 函数描述 : 文本数据进行DES解密
 输入参数 : (NSData *)data
 (NSString *)key
 输出参数 : N/A
 返回参数 : (NSData *)
 备注信息 : 此函数不可用于过长文本
 ******************************************************************************/
/*
 + (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
 {
 char keyPtr[kCCKeySizeAES256+1];
 bzero(keyPtr, sizeof(keyPtr));
 
 [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
 
 NSUInteger dataLength = [data length];
 
 size_t bufferSize = dataLength + kCCBlocCGSizeMakeAES128;
 void *buffer = malloc(bufferSize);
 
 size_t numBytesDecrypted = 0;
 CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
 kCCOptionPKCS7Padding | kCCOptionECBMode,
 keyPtr, kCCBlocCGSizeMakeDES,
 NULL,
 [data bytes], dataLength,
 buffer, bufferSize,
 &numBytesDecrypted);
 
 if (cryptStatus == kCCSuccess) {
 return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
 }
 
 free(buffer);
 return nil;
 }
 
 */

//根据两经纬度计算两点距离
+ (double)distanceBetweenOrderBy:(double)lat1 :(double)lat2 :(double)lng1 :(double)lng2
{
    double dd = M_PI/180;
    double x1=lat1*dd,x2=lat2*dd;
    double y1=lng1*dd,y2=lng2*dd;
    double R = 6371004;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    //km  返回
    //     return  distance*1000;
    
    //返回 m
    
    NSLog(@"distance distance distance = %f",distance);
    
    return   distance;
}

//返回当前设备的握持姿势
+(UIDeviceOrientation) XSZ_DeviceOrientation
{
    UIDeviceOrientation orient = [UIDevice currentDevice].orientation;
    if (orient == UIDeviceOrientationUnknown)
    {
        return UIDeviceOrientationPortrait;
    }
    else
        return orient;
}

+(BOOL)XSZ_IsPad
{
#ifdef __IPHONE_3_2
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
#else
    return NO;
#endif
}

//判断当前的设备是否支持该手持姿势，IPad全支持，IPhone不允许倒立持握
+(BOOL)XSZ_IsSupportedOriention:(UIInterfaceOrientation) orientation
{
    if ([self XSZ_IsPad])
        return YES;
    else
    {
        switch (orientation)
        {
            case UIInterfaceOrientationPortrait:
            case UIInterfaceOrientationLandscapeLeft:
            case UIInterfaceOrientationLandscapeRight:
                return YES;
            default:
                return NO;
        }
    }
}

//判断旋转
+(CGAffineTransform) XSZ_RotateTransformForOrientTation:(UIInterfaceOrientation)orientation
{
    if (orientation == UIInterfaceOrientationLandscapeLeft)
    {
        return CGAffineTransformMakeRotation(M_PI*1.5);
    }
    else if(orientation == UIInterfaceOrientationLandscapeRight)
    {
        return CGAffineTransformMakeRotation(M_PI/2);
    }
    else if(orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        return CGAffineTransformMakeRotation(-M_PI);
    }
    else
        return CGAffineTransformIdentity;
}

// 获取当前处于activity状态的view controller
+ (UIViewController *)activityViewController
{
    UIViewController* activityViewController = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows)
        {
            if(tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0)
    {
        UIView *frontView = [viewsArray objectAtIndex:0];
        
        id nextResponder = [frontView nextResponder];
        
        if([nextResponder isKindOfClass:[UIViewController class]])
        {
            activityViewController = nextResponder;
        }
        else
        {
            activityViewController = window.rootViewController;
        }
    }
    
    return activityViewController;
}

/* 判断是否是新的版本 */
+ (BOOL)isNewVersion
{
    CGFloat oldVersion = [kUserDefaults floatForKey:kSystemVersion];
    CGFloat currentVersion = [kBundleVersion floatValue];
    NSLog(@"旧版本：%f，当前版本：%f", oldVersion, currentVersion);
    
    if (currentVersion > oldVersion)
    {
        [kUserDefaults setFloat:currentVersion forKey:kSystemVersion];
        [kUserDefaults synchronize];
        return YES;
    }
    
    return NO;
}

/* 对象序列化 */
+ (void)archiveObject:(id)object fileName:(NSString*)fileName
{
    NSString *path = [NSString stringWithFormat:@"%@/%@", kDocumentPath, fileName];
//    FMLog(@"序列化地址：%@", path);
    BOOL flag = [NSKeyedArchiver archiveRootObject:object toFile:path];
    FMLog(@"%@", flag == 1 ? @"序列化成功" : @"序列化失败");
}

/* 对象反序列化 */
+ (id)unArchiverObjectWithfileName:(NSString*)fileName
{
    NSString *path = [NSString stringWithFormat:@"%@/%@", kDocumentPath, fileName];
    id object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    return object;
}

/* 计算缓存大小 */
+ (CGFloat)getCacheFileSize
{
    /* 缓存目录 */
    CGFloat cacheSize = [AppFunction folderSizeAtPath:kCachesDirectoryPath];
    
    CGFloat documentSize = [AppFunction folderSizeAtPath:kDocumentPath];
    
    CGFloat size = cacheSize + documentSize;
    
    return size;
}

/* 计算单个文件大小 */
+ (CGFloat)fileSizeAtPath:(NSString*)path
{
    if ([kFileManager fileExistsAtPath:path])
    {
        CGFloat size = [kFileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

/* 计算目录大小 */
+ (CGFloat)folderSizeAtPath:(NSString*)path
{
    /* 修复计算缓存大小的值不准确，folderSize必须初始化(Bug ID：#5) */
    CGFloat folderSize = 0;
    
    if ([kFileManager fileExistsAtPath:path])
    {
        NSArray *childFiles = [kFileManager subpathsAtPath:path];
        
        for (NSString *fileName in childFiles)
        {
            NSString *absoluatePath = [path stringByAppendingPathComponent:fileName];
            
            folderSize += [AppFunction fileSizeAtPath:absoluatePath];
        }
        
        return folderSize;
    }
    return 0;
}

/* 清除缓存 */
+ (void)clearDisk
{
    /* 该目录下存放用户信息序列化文件、搜索历史数据库 */
    [AppFunction clearCache:kDocumentPath];
    
    /* 该目录下存放图片缓存 */
    [AppFunction clearCache:kCachesDirectoryPath];
    
}

/* 清除单个目录下文件 */
+ (void)clearCache:(NSString*)path
{
    if ([kFileManager fileExistsAtPath:path])
    {
        NSArray *childFiles = [kFileManager subpathsAtPath:path];
        
        for (NSString *fileName in childFiles)
        {
            NSString *absoultPath = [path stringByAppendingPathComponent:fileName];
            
            [kFileManager removeItemAtPath:absoultPath error:nil];
        }
    }
    
}

@end
