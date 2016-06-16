//
//  RePayOrder.h
//  eFreshMall
//
//  Created by zlp on 16/5/19.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 重新支付订单模型 */
@interface RePayOrder : NSObject

/* 用户主键 */
@property (nonatomic, copy) NSString *idUser;

/* 订单信息 */
@property (nonatomic, copy) NSString *idOrder;

/* 支付时间 */
@property (nonatomic, copy) NSString *paytime;

/* 订单号 */
@property (nonatomic, copy) NSString *out_trade_no;

@end
