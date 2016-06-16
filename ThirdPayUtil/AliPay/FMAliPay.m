//
//  FMAliPay.m
//  eFreshMall
//
//  Created by zlp on 16/3/1.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "FMAliPay.h"

#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

#import "APAuthV2Info.h"

#define PARTNER @""

#define PRIVATE_KEY @""

@implementation FMAliPay

+ (instancetype)sharedInstance
{
    static FMAliPay *aliPay;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
    
        aliPay = [[FMAliPay alloc] init];
        
    });
    return aliPay;
}


- (void)payForOrder
{

    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = PARTNER;
    NSString *seller = @"";//收款账号
    NSString *privateKey = PRIVATE_KEY;//pkcs8 格式
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.productName = self.product.subject; //商品标题（如未自定义，则显示商家信息）
    order.productDescription = self.product.body; //商品描述
    order.productDescription = @"测试数据";
    order.amount = [NSString stringWithFormat:@"%.2f",self.product.price]; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"eFreshMall";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    //
    self.order = order;
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            FMLog(@"reslut = %@",resultDic);
            
            NSString *resultStr = resultDic[@"result"];
            /* 返回码 */
            NSString *resultStatus = [NSString stringWithFormat:@"%ld", (long)[resultDic[@"resultStatus"] integerValue]];
            
            NSArray *stringArr = [resultStr componentsSeparatedByString:@"&"];
            
            
            /* 只有success = true 和 resultStatus = 9000才算支付成功 */
            if ([resultStatus isEqualToString:@"9000"])
            {
                /* 遍历数组，找到&success=\"true\"字符串 */
                for (NSString *subStr in stringArr)
                {
                    if ([subStr containsString:@"success"] && [subStr containsString:@"true"])
                    {
                        
                        /* 回调 */
                        if (self.successPayMentAction)
                        {
                            self.successPayMentAction();
                        }
                        
                    }
                }

            }
            else
            {
                /* 支付失败回调 */
                if (self.failurePayMentAction) {
                    
                    self.failurePayMentAction();
                }

            }
            
        }];
    }

}

#pragma mark   ==============产生随机订单号==============

- (NSString *)generateTradeNO
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

#pragma mark   ==============产生订单信息==============

- (void)generateData
{
    NSArray *subjects = @[@"1",
                          @"2",@"3",@"4",
                          @"5",@"6",@"7",
                          @"8",@"9",@"10"];
    NSArray *body = @[@"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据",
                      @"我是测试数据"];
    
    if (nil == self.productList)
    {
        self.productList = [[NSMutableArray alloc] init];
    }
    else
    {
        [self.productList removeAllObjects];
    }

    for (int i = 0; i < [subjects count]; ++i)
    {
        Product *product = [[Product alloc] init];
        product.subject = [subjects objectAtIndex:i];
        product.body = [body objectAtIndex:i];
        
        product.price = 0.01f+pow(10,i-2);
        [self.productList addObject:product];
    }
}


@end
