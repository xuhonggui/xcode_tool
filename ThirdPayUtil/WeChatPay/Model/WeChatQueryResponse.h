//
//  WeChatQueryResponse.h
//  eFreshMall
//
//  Created by zlp on 16/5/19.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 微信支付查询订单返回信息，具体见https://pay.weixin.qq.com/wiki/doc/api/app/app.php?chapter=9_2&index=4 */

@interface WeChatQueryResponse : NSObject

/* 返回码 */
@property (nonatomic, copy) NSString *return_code;

/* 返回信息 */
@property (nonatomic, copy) NSString *return_msg;

/* appid */
@property (nonatomic, copy) NSString *appid;

/* 商户号 */
@property (nonatomic, copy) NSString *mch_id;

/* 随机字符串 */
@property (nonatomic, copy) NSString *nonce_str;

/* 签名 */
@property (nonatomic, copy) NSString *sign;

/* 业务结果 */
@property (nonatomic, copy) NSString *result_code;

/* 错误代码 */
@property (nonatomic, copy) NSString *err_code;

/* 错误代码描述 */
@property (nonatomic, copy) NSString *err_code_des;

/* 设备号 */
@property (nonatomic, copy) NSString *device_info;

/* 用户标识 */
@property (nonatomic, copy) NSString *openid;

/* 是否关注公众账号 */
@property (nonatomic, copy) NSString *is_subscribe;

/* 交易类型 */
@property (nonatomic, copy) NSString *trade_type;

/* 
 * 交易状态 
 *   SUCCESS—支付成功
     REFUND—转入退款
     NOTPAY—未支付
     CLOSED—已关闭
     REVOKED—已撤销（刷卡支付）
     USERPAYING--用户支付中
     PAYERROR--支付失败(其他原因，如银行返回失败)
 */
@property (nonatomic, copy) NSString *trade_state;

/* 付款银行 */
@property (nonatomic, copy) NSString *bank_type;

/* 总金额 */
@property (nonatomic, copy) NSString *total_fee;

/* 现金支付金额 */
@property (nonatomic, copy) NSString *cash_fee;

/* 货币种类 */
@property (nonatomic, copy) NSString *fee_type;

/* 现金支付货币类型 */
@property (nonatomic, copy) NSString *cash_fee_type;

/* 代金券或立减优惠金额 */
@property (nonatomic, copy) NSString *coupon_fee;

/* 代金券或立减优惠使用数量 */
@property (nonatomic, copy) NSString *coupon_count;

/* 代金券或立减优惠批次ID */
@property (nonatomic, copy) NSString *coupon_batch_id_$n;

/* 代金券或立减优惠ID */
@property (nonatomic, copy) NSString *coupon_id_$n;

/* 单个代金券或立减优惠支付金额 */
@property (nonatomic, copy) NSString *coupon_fee_$n;

/* 微信支付订单号 */
@property (nonatomic, copy) NSString *transaction_id;

/* 商户订单号 */
@property (nonatomic, copy) NSString *out_trade_no;

/* 附加数据 */
@property (nonatomic, copy) NSString *attach;

/* 支付完成时间 */
@property (nonatomic, copy) NSString *time_end;

/* 交易状态描述 */
@property (nonatomic, copy) NSString *trade_state_desc;

@end
