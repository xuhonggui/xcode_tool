//
//  FMWeChatPay.m
//  eFreshMall
//
//  Created by zlp on 16/4/22.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "FMWeChatPay.h"
#import <AFNetworking.h>

#import "NSString+Extension.h"
#import "WeChatPayUtil.h"

#import <CommonCrypto/CommonDigest.h>
#import <XMLDictionary.h>

#import "RePayOrder.h"

@interface FMWeChatPay ()

@property (nonatomic, strong) WeChatProduct *model;

@end

@implementation FMWeChatPay

+ (instancetype)sharedInstance
{
    static FMWeChatPay *weChatPay;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        
        weChatPay = [[FMWeChatPay alloc] init];
        
    });
    return weChatPay;
}

- (void)payForProduct:(WeChatProduct*)product out_trade_no:(NSString*)out_trade_no
{
    _model = product;
    
    _model.appid = WXAPPID;
    _model.mch_id = WXPARTNERID;//微信分配的商户号
    _model.nonce_str = [WeChatPayUtil getNonceString];//随机字符串
    _model.out_trade_no = out_trade_no;//商户订单号
    _model.spbill_create_ip = [WeChatPayUtil getIPAddress];//终端ip
    _model.notify_url = @"http://www.weixin.qq.com/wxpay/pay.php";//通知地址
    _model.trade_type = @"APP";//支付类型
    _model.sign = [WeChatPayUtil getUnifiedOrderSign:_model];//签名
    
    /* 发送请求 */
    [self requestForUnifiedOrder];
    
    /* 保存订单信息 */
    [AppFunction archiveObject:_model fileName:kWXArchiverFileName];
}

#pragma mark - 统一支付请求
- (void)requestForUnifiedOrder
{
    NSURL *url = [NSURL URLWithString:WX_UNIFIEDORDER_URL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    request.HTTPMethod = @"POST";
    [request addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = [self getPostBody];
    
    /* 发送请求 */
    NSHTTPURLResponse *response;
    NSError *error;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    NSString *result = [[NSString alloc] initWithData:responseData encoding:4];
    
    FMLog(@"生成预支付交易单返回数据：/n%@", result);
    
    /* 解析 */
    NSDictionary *resultDic = [NSDictionary dictionaryWithXMLString:result];
    WeChatResponse *weChatResponse = [WeChatResponse mj_objectWithKeyValues:resultDic];
    
    /* 调用统一支付订单成功 */
    if ([weChatResponse.return_code isEqualToString:@"SUCCESS"]
        && [weChatResponse.result_code isEqualToString:@"SUCCESS"])
    {
    
        PayReq *request = [[PayReq alloc] init];
        request.partnerId = weChatResponse.mch_id;
        request.prepayId = weChatResponse.prepay_id;
        request.package = @"Sign=WXPay";
        request.timeStamp= [WeChatPayUtil getTimeStamp];
        request.nonceStr = weChatResponse.nonce_str;
        request.sign = [WeChatPayUtil getPayReqestSign:request];

        /* 支付订单 */
        [WXApi sendReq:request];
        
    }
    /* 调用统一支付订单失败 */
    else
    {
        
    }
}

#pragma mark - 微信支付订单代理
- (void)onReq:(BaseReq *)req
{
    
}

- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp *response=(PayResp*)resp;
        switch(response.errCode)
        {
            case WXSuccess:
            {
                //服务器端查询支付通知或查询API返回的结果再提示成功
                FMLog(@"微信支付成功");
                if (self.didSuccessPay) self.didSuccessPay(response);
                break;
            }
            default:
            {
                if (self.didFailurePay)self.didFailurePay();
                FMLog(@"微信支付失败，retcode=%d",resp.errCode);
            }
                break;
        }
    }
}


- (NSData*)getPostBody
{
    /* 请求体 */
    NSMutableData *postBody = [NSMutableData data];
    
    [postBody appendData:[[NSString stringWithFormat:@"<xml>"] dataUsingEncoding:4]];
    
    [postBody appendData:[[NSString stringWithFormat:@"<appid>%@</appid>", _model.appid] dataUsingEncoding:4]];
    
    [postBody appendData:[[NSString stringWithFormat:@"<mch_id>%@</mch_id>", _model.mch_id]dataUsingEncoding:4]];
    
    [postBody appendData:[[NSString stringWithFormat:@"<body>%@</body>", _model.body]dataUsingEncoding:4]];
    
    [postBody appendData:[[NSString stringWithFormat:@"<nonce_str>%@</nonce_str>", _model.nonce_str]dataUsingEncoding:4]];
    
    [postBody appendData:[[NSString stringWithFormat:@"<sign>%@</sign>", _model.sign]dataUsingEncoding:4]];
    
    [postBody appendData:[[NSString stringWithFormat:@"<out_trade_no>%@</out_trade_no>", _model.out_trade_no]dataUsingEncoding:4]];
    
    [postBody appendData:[[NSString stringWithFormat:@"<total_fee>%@</total_fee>", _model.total_fee]dataUsingEncoding:4]];
    
    [postBody appendData:[[NSString stringWithFormat:@"<spbill_create_ip>%@</spbill_create_ip>", _model.spbill_create_ip]dataUsingEncoding:4]];
    
    [postBody appendData:[[NSString stringWithFormat:@"<notify_url>%@</notify_url>", _model.notify_url]dataUsingEncoding:4]];
    
    [postBody appendData:[[NSString stringWithFormat:@"<trade_type>%@</trade_type>", _model.trade_type]dataUsingEncoding:4]];
    
    [postBody appendData:[[NSString stringWithFormat:@"</xml>"] dataUsingEncoding:4]];
    
    NSString *bodyString = [[NSString alloc] initWithData:postBody encoding:4];
    
    FMLog(@"生成预支付交易请求体：/n%@", bodyString);
    
    return postBody;
}

#pragma mark - 查询订单支付结果
- (void)queryLastOrder
{
    
    WeChatProduct *product = [AppFunction unArchiverObjectWithfileName:kWXArchiverFileName];
    
    if (!product) {
        return;
    }
    
    kDispatch_Global(^{
    
        /* 重新签名 */
        product.sign = [WeChatPayUtil getOrderQuerySign:product];
        
        NSURL *url = [NSURL URLWithString:WX_ORDERQUERY_URL];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        
        request.HTTPMethod = @"POST";
        [request addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
        request.HTTPBody = [self getQueryOrderPostBodyWithProcuct:product];
        
        /* 发送请求 */
        NSHTTPURLResponse *response;
        NSError *error;
        
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        NSString *result = [[NSString alloc] initWithData:responseData encoding:4];
        
        FMLog(@"生成预支付交易单返回数据：/n%@", result);
        
        /* 解析 */
        NSDictionary *resultDic = [NSDictionary dictionaryWithXMLString:result];
        WeChatQueryResponse *queryResponse = [WeChatQueryResponse mj_objectWithKeyValues:resultDic];
        
        
        /* 调用查询订单接口成功 */
        if ([queryResponse.return_code isEqualToString:@"SUCCESS"]
            && [queryResponse.result_code isEqualToString:@"SUCCESS"])
        {
            KDispatch_Main(^{
            
                if (self.didSuccessQueryOrder)
                {
                    self.didSuccessQueryOrder(queryResponse);
                }
            });
        }

    });
    
}

- (NSData*)getQueryOrderPostBodyWithProcuct:(WeChatProduct*)product
{
    /* 请求体 */
    NSMutableData *postBody = [NSMutableData data];
    
    [postBody appendData:[[NSString stringWithFormat:@"<xml>"] dataUsingEncoding:4]];
    
    [postBody appendData:[[NSString stringWithFormat:@"<appid>%@</appid>", product.appid] dataUsingEncoding:4]];
    
    [postBody appendData:[[NSString stringWithFormat:@"<mch_id>%@</mch_id>", product.mch_id]dataUsingEncoding:4]];
    
    [postBody appendData:[[NSString stringWithFormat:@"<nonce_str>%@</nonce_str>", product.nonce_str]dataUsingEncoding:4]];
    
    [postBody appendData:[[NSString stringWithFormat:@"<sign>%@</sign>", product.sign]dataUsingEncoding:4]];
    
    [postBody appendData:[[NSString stringWithFormat:@"<out_trade_no>%@</out_trade_no>", product.out_trade_no]dataUsingEncoding:4]];
    
    [postBody appendData:[[NSString stringWithFormat:@"</xml>"] dataUsingEncoding:4]];
    
    NSString *bodyString = [[NSString alloc] initWithData:postBody encoding:4];
    
    FMLog(@"生成查询订单请求体：/n%@", bodyString);
    
    return postBody;
}


@end
