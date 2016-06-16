//
//  RePayOrder.m
//  eFreshMall
//
//  Created by zlp on 16/5/19.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "RePayOrder.h"

@implementation RePayOrder

/* 反序列化 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        
        self.idUser = [decoder decodeObjectForKey:@"idUser"];
        self.idOrder = [decoder decodeObjectForKey:@"idOrder"];
        self.paytime = [decoder decodeObjectForKey:@"paytime"];
        self.out_trade_no = [decoder decodeObjectForKey:@"out_trade_no"];
    }
    return self;
}

/* 序列化 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    
    [encoder encodeObject:self.idUser forKey:@"idUser"];
    [encoder encodeObject:self.idOrder forKey:@"idOrder"];
    [encoder encodeObject:self.paytime forKey:@"paytime"];
    [encoder encodeObject:self.out_trade_no forKey:@"out_trade_no"];
    
}


@end
