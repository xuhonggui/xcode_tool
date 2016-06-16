//
//  NSData+Extension.h
//  eFreshMall
//
//  Created by zlp on 16/4/21.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Extension)

- (void)saveDataCacheWithIdentifier:(NSString *)identifier;

+ (NSData *)getDataCacheWithIdentifier:(NSString *)identifier;

+ (void)clearCache;

+ (BOOL)isImageDataCacheWithIdentifier:(NSString *)identifier;

/* 判断图片类型 */
+ (NSString *)contentTypeForImageData:(NSData *)data;

@end
