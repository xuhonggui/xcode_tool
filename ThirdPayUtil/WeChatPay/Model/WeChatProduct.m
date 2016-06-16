//
//  WeChatProduct.m
//  eFreshMall
//
//  Created by zlp on 16/4/22.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "WeChatProduct.h"

@implementation WeChatProduct

/* 序列化 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    
    [encoder encodeObject:self.appid forKey:@"appid"];
    [encoder encodeObject:self.mch_id forKey:@"mch_id"];
    [encoder encodeObject:self.out_trade_no forKey:@"out_trade_no"];
    [encoder encodeObject:self.nonce_str forKey:@"nonce_str"];
    
}

/* 反序列化 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        
        self.appid = [decoder decodeObjectForKey:@"appid"];
        self.mch_id = [decoder decodeObjectForKey:@"mch_id"];
        self.out_trade_no = [decoder decodeObjectForKey:@"out_trade_no"];
        self.nonce_str = [decoder decodeObjectForKey:@"nonce_str"];
        
    }
    return self;
}


@end
