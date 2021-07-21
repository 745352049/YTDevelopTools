//
//  UIImage+YTQRCode.m
//  

#import "UIImage+YTQRCode.h"

@implementation UIImage (YTQRCode)

+ (UIImage *)createQRCodeWithString:(NSString *)string Width:(CGFloat)width {
    /**
     CIAztecCodeGenerator
     CICheckerboardGenerator
     CICode128BarcodeGenerator
     广泛应用在企业内部管理、生产流程、物流控制系统方面的条码码制
     Code 128码与Code 39码有很多的相近性，都广泛运用在企业内部管理、生产流程、物流控制系统方面。不同的在于Code 128比Code 39能表现更多的字符，单位长度里的编码密度更高。当单位长度里不能容下Code 39编码或编码字符超出了Code 39的限制时，就可选择Code128来编码。所以Code 128比Code 39更具灵活性。
   
     CIConstantColorGenerator
     CILenticularHaloGenerator
     CIPDF417BarcodeGenerator
     CIQRCodeGenerator
     CIRandomGenerator
     CIStarShineGenerator
     CIStripesGenerator
     CISunbeamsGenerator
     */
    
    /// 创建过滤器，这里的@"CIQRCodeGenerator"是滤镜名称
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    /// 恢复默认设置
    [filter setDefaults];
    /// 给过滤器添加数据
    NSString *message = string;
    /// 这里的value必须是NSData类型
    NSData *dataString = [message dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:dataString forKey:@"inputMessage"];
    /// 生成二维码
    CIImage *outImage = [filter outputImage];
    UIImage *imageV = [self ciiImageTransformImage:outImage Size:CGSizeMake(width, width)];

    return imageV;
}

+ (UIImage *)createQRCodeWithString:(NSString *)string Width:(CGFloat)width centerImage:(UIImage *)centerImage centerWidth:(CGFloat)centerWidth {
    /// 创建过滤器，这里的@"CIQRCodeGenerator"是滤镜名称
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    /// 恢复默认设置
    [filter setDefaults];
    /// 给过滤器添加数据
    NSString *message = string;
    /// 这里的value必须是NSData类型
    NSData *dataString = [message dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:dataString forKey:@"inputMessage"];
    /// 生成二维码
    CIImage *outImage = [filter outputImage];
    /// 转成高清格式
    UIImage *qrcode = [self ciiImageTransformHDImage:outImage Size:CGSizeMake(width, width)];
    /// 添加logo
    if (centerImage) {
        qrcode = [self drawImage:centerImage width:centerWidth inImage:qrcode];
    }
    
    return qrcode;
}

+ (UIImage *)drawImage:(UIImage *)image width:(CGFloat)width inImage:(UIImage *)inImage {
    /// 画的背景大小
    CGSize imageSize;
    imageSize = [inImage size];
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    [inImage drawAtPoint:CGPointMake(0, 0)];
    /// 获得图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    /// 画自己想要画的内容(添加的图片)
    CGContextDrawPath(context, kCGPathStroke);
    /// 注意的尺寸不要太大,否则可能无法识别
    CGRect rect = CGRectMake(imageSize.width/2.0 - width/2.0, imageSize.height/2.0 - width/2.0, width, width);
    CGContextClip(context);
    [image drawInRect:rect];
    /// 返回绘制的新图形
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/// 将二维码转成高清的格式
/// @param ciiImage 资源图片
/// @param size 大小
+ (UIImage *)ciiImageTransformHDImage:(CIImage *)ciiImage Size:(CGSize)size {
    CGRect extent = CGRectIntegral(ciiImage.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciiImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    return [UIImage imageWithCGImage:scaledImage];
}

/// 将CIImage转换成UIImage并放大
/// @param ciiImage 资源图片
/// @param size 大小
+ (UIImage *)ciiImageTransformImage:(CIImage *)ciiImage Size:(CGSize)size {
    CGRect extent = CGRectIntegral(ciiImage.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciiImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);

    return [UIImage imageWithCGImage:scaledImage];
}

@end
