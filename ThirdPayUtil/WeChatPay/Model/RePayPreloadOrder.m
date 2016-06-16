//
//  RePayPreloadOrder.m
//  eFreshMall
//
//  Created by zlp on 16/5/20.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "RePayPreloadOrder.h"

@implementation RePayPreloadOrder

/* 反序列化 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        
        self.idUser = [decoder decodeObjectForKey:@"idUser"];
        self.idAccount = [decoder decodeObjectForKey:@"idAccount"];
        self.amount = [decoder decodeObjectForKey:@"amount"];
        self.idPayway = [decoder decodeObjectForKey:@"idPayway"];
        self.tradingtype = [decoder decodeObjectForKey:@"tradingtype"];
        self.tradingtime = [decoder decodeObjectForKey:@"tradingtime"];
        self.tradingNo = [decoder decodeObjectForKey:@"tradingNo"];
        self.note = [decoder decodeObjectForKey:@"note"];
    }
    return self;
}

/* 序列化 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    
    [encoder encodeObject:self.idUser forKey:@"idUser"];
    [encoder encodeObject:self.idAccount forKey:@"idAccount"];
    [encoder encodeObject:self.amount forKey:@"amount"];
    [encoder encodeObject:self.idPayway forKey:@"idPayway"];
    [encoder encodeObject:self.tradingtype forKey:@"tradingtype"];
    [encoder encodeObject:self.tradingtime forKey:@"tradingtime"];
    [encoder encodeObject:self.tradingNo forKey:@"tradingNo"];
    [encoder encodeObject:self.note forKey:@"note"];

    
}


@end
