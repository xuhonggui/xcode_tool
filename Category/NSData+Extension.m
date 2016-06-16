//
//  NSData+Extension.m
//  eFreshMall
//
//  Created by zlp on 16/4/21.
//  Copyright © 2016年 cnmobi. All rights reserved.
//

#import "NSData+Extension.h"
#import <CommonCrypto/CommonDigest.h>

#define kSDMaxCacheFileAmount 100

@implementation NSData (Extension)

+ (NSString *)cachePath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"Caches"];
    path = [path stringByAppendingPathComponent:@"ImageDataCache"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

+ (NSString *)creatMD5StringWithString:(NSString *)string
{
    const char *original_str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    [hash lowercaseString];
    return hash;
}

+ (NSString *)creatDataPathWithString:(NSString *)string
{
    NSString *path = [NSData cachePath];
    path = [path stringByAppendingPathComponent:[self creatMD5StringWithString:string]];
    return path;
}

- (void)saveDataCacheWithIdentifier:(NSString *)identifier
{
    NSString *path = [NSData creatDataPathWithString:identifier];
    [self writeToFile:path atomically:YES];
}

+ (NSData *)getDataCacheWithIdentifier:(NSString *)identifier
{
    static BOOL isCheckedCacheDisk = NO;
    if (!isCheckedCacheDisk) {
        NSFileManager *manager = [NSFileManager defaultManager];
        NSArray *contents = [manager contentsOfDirectoryAtPath:[self cachePath] error:nil];
        if (contents.count >= kSDMaxCacheFileAmount) {
            [manager removeItemAtPath:[self cachePath] error:nil];
        }
        isCheckedCacheDisk = YES;
    }
    NSString *path = [self creatDataPathWithString:identifier];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

+ (void)clearCache
{
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:[self cachePath] error:nil];
}

+ (BOOL)isImageDataCacheWithIdentifier:(NSString *)identifier
{
    NSString *path = [self creatDataPathWithString:identifier];
    
    return [kFileManager fileExistsAtPath:path];
}

/* 判断图片类型 */
+ (NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
        case 0x52:
            // R as RIFF for WEBP
            if ([data length] < 12) {
                return nil;
            }
            
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"image/webp";
            }
            
            return nil;
    }
    return nil;
}


@end
