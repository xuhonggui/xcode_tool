//
//  RePayPreloadOrder.h
//  eFreshMall
//
//  Created by zlp on 16/5/20.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 预充值重新支付模型 */
@interface RePayPreloadOrder : NSObject

/* 用户主键 */
@property (nonatomic, copy) NSString *idUser;

/* 账户主键 */
@property (nonatomic, copy) NSString *idAccount;

/* 充值金额 */
@property (nonatomic, copy) NSString *amount;

/* 支付方式主键 */
@property (nonatomic, copy) NSString *idPayway;

/* 交易类型 */
@property (nonatomic, copy) NSString *tradingtype;

/* 交易时间 */
@property (nonatomic, copy) NSString *tradingtime;

/* 交易单号 */
@property (nonatomic, copy) NSString *tradingNo;

/* 充值描述 */
@property (nonatomic, copy) NSString *note;

@end
