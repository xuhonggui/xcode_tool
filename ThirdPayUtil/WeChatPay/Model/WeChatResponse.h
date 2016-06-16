//
//  WeChatResponse.h
//  eFreshMall
//
//  Created by zlp on 16/4/27.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeChatResponse : NSObject

/* 返回状态码 */
@property (nonatomic, copy) NSString *return_code;

/* 返回信息 */
@property (nonatomic, copy) NSString *return_msg;

/* 以下字段在return_code为SUCCESS的时候有返回 */

/* 应用APPID */
@property (nonatomic, copy) NSString *appid;

/* 商户号 */
@property (nonatomic, copy) NSString *mch_id;

/* 设备号 */
@property (nonatomic, copy) NSString *device_info;

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

/* 以下字段在return_code 和result_code都为SUCCESS的时候有返回 */

/* 交易类型 */
@property (nonatomic, copy) NSString *trade_type;

/* 预支付交易会话标识 */
@property (nonatomic, copy) NSString *prepay_id;


@end
