//
//  WeChatPayUtil.h
//  eFreshMall
//
//  Created by zlp on 16/4/22.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WeChatProduct.h"

#import "WXApi.h"

@interface WeChatPayUtil : NSObject

+ (NSString *)md5:(NSString *)input;

/* 获取终端ip */
+ (NSString*)getIPAddress;

/* 随机订单号 */
+ (NSString *)generateTradeNO;

/* 获取统一支付签名 */
+ (NSString*)getUnifiedOrderSign:(WeChatProduct*)product;

/* 查询订单签名 */
+ (NSString*)getOrderQuerySign:(WeChatProduct*)product;

/* 支付订单签名 */
+ (NSString*)getPayReqestSign:(PayReq*)request;

/* 时间戳 */
+ (UInt32)getTimeStamp;

/* 随机字符串 */
+ (NSString*)getNonceString;

@end
