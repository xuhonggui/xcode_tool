//
//  FMWeChatPay.h
//  eFreshMall
//
//  Created by zlp on 16/4/22.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Order.h"
#import "WeChatProduct.h"
#import "WeChatResponse.h"
#import "WeChatQueryResponse.h"
#import "WXApi.h"

@interface FMWeChatPay : NSObject<WXApiDelegate>

+ (instancetype)sharedInstance;

- (void)payForProduct:(WeChatProduct*)product out_trade_no:(NSString*)out_trade_no;

/* 查询上一笔交易结果 */
- (void)queryLastOrder;

@property (nonatomic, copy) void(^didSuccessPay)(PayResp* resp);

@property (nonatomic, copy) void(^didFailurePay)();

@property (nonatomic, copy) void(^didSuccessQueryOrder)(WeChatQueryResponse *queryResp);

@end
