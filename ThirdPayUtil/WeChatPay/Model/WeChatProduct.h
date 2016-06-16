//
//  WeChatProduct.h
//  eFreshMall
//
//  Created by zlp on 16/4/22.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeChatProduct : NSObject

/* 参数介绍见 https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=9_1 */

/* 应用ID */
@property (nonatomic, copy) NSString *appid;//必填

/* 商户号 */
@property (nonatomic, copy) NSString *mch_id;//必填

/* 设备号 */
@property (nonatomic, copy) NSString *device_info;

/* 随机字符串 */
@property (nonatomic, copy) NSString *nonce_str;//必填

/* 签名 */
@property (nonatomic, copy) NSString *sign;//必填

/* 商品描述 */
@property (nonatomic, copy) NSString *body;//必填

/* 商品详情 */
@property (nonatomic, copy) NSString *detail;

/* 附加数据 */
@property (nonatomic, copy) NSString *attach;

/* 商户订单号 */
@property (nonatomic, copy) NSString *out_trade_no;//必填

/* 货币类型 */
@property (nonatomic, copy) NSString *fee_type;

/* 总金额 */
@property (nonatomic, copy) NSString *total_fee;//必填

/* 终端IP */
@property (nonatomic, copy) NSString *spbill_create_ip;//必填

/* 交易起始时间 */
@property (nonatomic, copy) NSString *time_start;

/* 交易结束时间 */
@property (nonatomic, copy) NSString *time_expire;

/* 商品标记 */
@property (nonatomic, copy) NSString *goods_tag;

/* 通知地址 */
@property (nonatomic, copy) NSString *notify_url;//必填

/* 交易类型 */
@property (nonatomic, copy) NSString *trade_type;//必填

/* 指定支付方式 */
@property (nonatomic, copy) NSString *limit_pay;


@end
