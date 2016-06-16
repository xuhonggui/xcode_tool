//
//  WeChatPayUtil.m
//  eFreshMall
//
//  Created by zlp on 16/4/22.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "WeChatPayUtil.h"

#import <CommonCrypto/CommonDigest.h>

#import <ifaddrs.h>
#import <arpa/inet.h>
#import "WeChatQueryResponse.h"

@implementation WeChatPayUtil

+ (NSString *)md5:(NSString *)input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    //X表示以十六进制形式输出02表示不足两位,前面补0输出;出过两位,不影响
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    FMLog(@"MD5加密：%@", output);
    
    return  output;
}

#pragma mark -手机ip地址
+ (NSString*)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    
    if (success == 0)
    {
        FMLog(@"获取ip地址成功");
        
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
//                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
//                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
//                    FMLog(@"address-->%@", address);
//                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    
    FMLog(@"获取手机ip地址：%@", address);
    
    return address;
}

#pragma mark - 统一支付签名
+ (NSString*)getUnifiedOrderSign:(WeChatProduct*)product
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"appid"] = product.appid;
    params[@"mch_id"] = product.mch_id;
    params[@"body"] = product.body;
    params[@"nonce_str"] = product.nonce_str;
    params[@"out_trade_no"] = product.out_trade_no;
    params[@"total_fee"] = product.total_fee;
    params[@"spbill_create_ip"] = product.spbill_create_ip;
    params[@"notify_url"] = product.notify_url;
    params[@"trade_type"] = product.trade_type;

    return [WeChatPayUtil getSign:params];
}

#pragma mark - 查询订单签名
+ (NSString*)getOrderQuerySign:(WeChatProduct*)product
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"appid"] = product.appid;
    params[@"mch_id"] = product.mch_id;
    params[@"nonce_str"] = product.nonce_str;
    params[@"out_trade_no"] = product.out_trade_no;
    
    return [WeChatPayUtil getSign:params];
}

#pragma mark - 支付订单签名
+ (NSString*)getPayReqestSign:(PayReq*)request
{
    /* 重新签名 */
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"appid"] = WXAPPID;
    params[@"partnerid"] = request.partnerId;
    params[@"prepayid"] = request.prepayId;
    params[@"package"] = request.package;
    params[@"noncestr"] = request.nonceStr;
    params[@"timestamp"] = [NSString stringWithFormat:@"%ld",request.timeStamp];
    
    return [WeChatPayUtil getSign:params];
}

#pragma mark - 签名
+ (NSString*)getSign:(NSDictionary*)params
{
    // 排序
    NSArray *keys = [params allKeys];
    
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    // 生成
    NSMutableString *sign = [NSMutableString string];
    for (NSString *key in sortedKeys)
    {
        [sign appendFormat:@"%@=%@&", key, [params objectForKey:key]];
    }
    
    NSString *signString = [sign stringByAppendingString:[NSString stringWithFormat:@"key=%@", WXAPPSECRET]];

    NSString *result = [WeChatPayUtil md5:signString];
    
    NSString *upperString = [result uppercaseString];
    
    FMLog(@"待签名字符串：%@", signString);
    FMLog(@"获取签名: %@", upperString);
    
    return upperString;
}

#pragma mark -产生随机订单号
+ (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    
    return resultStr;
}

#pragma mark - 时间戳
+ (UInt32)getTimeStamp
{
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    return [timeSp intValue];
}

#pragma mark - 随机字符串
+ (NSString*)getNonceString
{
    return [WeChatPayUtil md5:[NSString stringWithFormat:@"%d", arc4random() % 10000]];
}

@end
