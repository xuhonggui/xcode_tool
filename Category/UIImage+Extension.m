//
//  UIImage+Extension.m
//  XBJob
//
//  Created by xuru on 15/10/27.
//  Copyright © 2015年 cnmobi. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+ (UIImage *)imageWithCircleBorderW:(CGFloat)borderW circleColor:(UIColor *)circleColor image:(UIImage *)image
{
    // 圆环宽度
    CGFloat borderWH = borderW;
    
    // 加载图片
    //    UIImage *image = [UIImage imageNamed:imageName];
    
    CGFloat ctxWH = image.size.width + 2 * borderWH;
    
    CGRect ctxRect = CGRectMake(0, 0, ctxWH, ctxWH);
    
    // 1.开启位图上下文
    UIGraphicsBeginImageContextWithOptions(ctxRect.size, NO, 0);
    
    // 2.画大圆
    UIBezierPath *bigCirclePath = [UIBezierPath bezierPathWithOvalInRect:ctxRect];
    
    // 设置圆环的颜色
    [circleColor set];
    
    [bigCirclePath fill];
    
    // 3.设置裁剪区域
    CGRect clipRect = CGRectMake(borderWH, borderWH, image.size.width, image.size.height);
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:clipRect];
    [clipPath addClip];
    
    //4.画图片
    [image drawAtPoint:CGPointMake(borderWH, borderWH)];
    
    // 5.从上下文中获取图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 6.关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

//拉伸图片使用
+(UIImage *)resizeImage:(NSString *)imageName{
    
    UIImage * bgImage = [UIImage imageNamed:imageName];
    bgImage = [bgImage stretchableImageWithLeftCapWidth:bgImage.size.width/2 topCapHeight:bgImage.size.height/2];
    return bgImage;
}

+ (BOOL) imageHasAlpha: (UIImage *) image
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

+ (NSString *) image2DataURL: (UIImage *) image
{
    NSData *imageData = nil;
    
    if ([UIImage imageHasAlpha: image]) {
        imageData = UIImagePNGRepresentation(image);
    } else {
        imageData = UIImageJPEGRepresentation(image, 0.4f);
    }
    
    return [imageData base64EncodedStringWithOptions: 0];
    
}

+ (NSString *)createTypeAndName: (UIImage *) image {
    NSString *mimeType = nil;
    
    NSString *uuid = [[NSUUID UUID] UUIDString];
    if ([UIImage imageHasAlpha: image]) {
        mimeType = [NSString stringWithFormat:@"%@.png", uuid];
    } else {
        mimeType = [NSString stringWithFormat:@"%@.jpeg", uuid];
    }
    return mimeType;
}

+ (UIImage *) dataURL2Image: (NSString *) imgSrc
{
    NSURL *url = [NSURL URLWithString: imgSrc];
    NSData *data = [NSData dataWithContentsOfURL: url];
    UIImage *image = [UIImage imageWithData: data];
    
    return image;
}

//按比例缩放,size 是你要把图显示到 多大区域 CGSizeMake(300, 140)
+(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor)
        {
            scaleFactor = widthFactor;
            
        }
        else
        {
            
            scaleFactor = heightFactor;
        }
        
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

/* 裁剪图片至指定大小，图片不压缩，不会模糊 */
+ (UIImage*) image:(UIImage*)sourceImage scaleToTargetSize:(CGSize)size
{
    
    UIImage *newImage = nil;
    
    /* 原图大小 */
    CGSize imgSize = sourceImage.size;
    CGFloat imgW = imgSize.width;
    CGFloat imgH = imgSize.height;
//    FMLog(@"原始大小：%f, %f", imgW, imgH);
    
    /* 目标图片大小 */
    CGFloat targetW = size.width;
    CGFloat targetH = size.height;
//    FMLog(@"目标大小：%f, %f", targetW, targetH);
    
    if (imgW < size.width || imgH < size.height)
    {
        newImage = [UIImage imageCompressForSize:sourceImage targetSize:size];
        
        return newImage;
    }
    
    /* 下面方法只适合原图需要缩小到指定大小 */
    
    CGFloat scale = 0.0;
    CGFloat scaleH;
    CGFloat scaleW;
    
    /* 图片原点 */
    CGPoint point = CGPointZero;
    
    if(CGSizeEqualToSize(imgSize, size) == NO)
    {
        CGFloat widScale = targetW/imgW;
        CGFloat heiScale = targetH/imgH;
        
        /* 裁剪高 */
        if (widScale > heiScale)
        {
            scale = targetW / targetH;
            scaleW = imgW;
            scaleH = scaleW / scale;
            point.y = (scaleH - imgH)/2;
            point.x = 0;
            
        }
        /* 裁剪宽 */
        else
        {
            scale = targetW / targetH;
            
            scaleH = imgH;
            scaleW = imgH * scale;
            
            point.y = 0;
            point.x = (scaleW - imgW)/2;
        }
        
        UIGraphicsBeginImageContext(CGSizeMake(scaleW, scaleH));
        
        CGRect rect = CGRectMake(point.x, point.y, imgW, imgH);
        
        
        [sourceImage drawInRect:rect];
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return newImage;

    }
    
    return sourceImage;
}

+(UIImage *) circleImage:(UIImage *)image withParam:(CGFloat)inset {
    
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

//把图片缩放到固定大小
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    
    UIGraphicsBeginImageContext(size);
    
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return scaledImage;
}

@end
