//
//  FMAliPay.h
//  eFreshMall
//
//  Created by zlp on 16/3/1.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Product.h"
#import "Order.h"
@interface FMAliPay : NSObject

@property(nonatomic, strong)NSMutableArray *productList;

@property (nonatomic, strong) Product *product;
@property(nonatomic,strong)Order *order;
+ (instancetype)sharedInstance;

- (void)payForOrder;

/* 随机产生订单号 */
- (NSString *)generateTradeNO;

@property (nonatomic, copy) void(^successPayMentAction)();

@property (nonatomic, copy) void(^failurePayMentAction)();

@end
