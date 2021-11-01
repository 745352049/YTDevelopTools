//
//  UIImage+YTScale.m
// 

#import "UIImage+YTScale.h"

@implementation UIImage (YTScale)

- (BOOL)isHaveAlpha {
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

- (NSString *)base64Encoding {
    NSData *imageData = UIImageJPEGRepresentation(self, 1.0f);
    return [NSString stringWithFormat:@"%@", [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
}

- (UIColor *)colorWithPoint:(CGPoint)point {
    CFDataRef pixelData = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage));
    const UInt8 *data = CFDataGetBytePtr(pixelData);
    NSUInteger width = self.size.width;
    int pixelInfo = ((width * point.y) + point.x) * 4;
    
    CGFloat red = (CGFloat)data[pixelInfo] / 255.0f;
    CGFloat green = (CGFloat)data[pixelInfo + 1] / 255.0f;
    CGFloat blue = (CGFloat)data[pixelInfo + 2] / 255.0f;
    CGFloat alpha = (CGFloat)data[pixelInfo + 3] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (UIImage *)imageWithAlwaysOriginalMode {
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)imageFromURLString:(NSString *)urlstring {
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlstring]]];
}

+ (UIImage *)stretchableCenterWithImageStr:(NSString *)imageStr {
    return [[UIImage imageNamed:imageStr] stretchableCenter];
}

+ (UIImage *)stretchableWithImageStr:(NSString *)imageStr leftCap:(CGFloat)leftCap topCap:(CGFloat)topCap {
    return [[UIImage imageNamed:imageStr] stretchableLeftCap:leftCap topCap:topCap];
}

- (UIImage *)stretchableCenter {
    return [self stretchableImageWithLeftCapWidth:self.size.width*0.5 topCapHeight:self.size.height*0.5];
}

- (UIImage *)stretchableLeftCap:(CGFloat)leftCap topCap:(CGFloat)topCap {
    return [self stretchableImageWithLeftCapWidth:self.size.width*leftCap topCapHeight:self.size.height*topCap];
}

+ (UIImage *)scaleImageNamed:(NSString *)image TargetWidth:(CGFloat)defineWidth {
    return [[UIImage imageNamed:image] imageScaleWithTargetWidth:defineWidth];
}

/// 指定宽度按比例缩放
- (UIImage *)imageScaleWithTargetWidth:(CGFloat)defineWidth {
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = [UIScreen mainScreen].scale;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if (CGSizeEqualToSize(imageSize, size) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor;
        } else {
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    UIGraphicsBeginImageContextWithOptions(thumbnailRect.size, NO, [UIScreen mainScreen].scale);
    [self drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (newImage) {
        return newImage;
    }
    
    return self;
}

/// 指定高度按比例缩放
+ (UIImage *)scaleImageNamed:(NSString *)image TargetHeight:(CGFloat)defineHeight {
    return [[UIImage imageNamed:image] imageScaleWithTargetHeight:defineHeight];
}

- (UIImage *)imageScaleWithTargetHeight:(CGFloat)defineHeight {
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetHeight = defineHeight;
    CGFloat targetWidth = width / (height / targetHeight);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = [UIScreen mainScreen].scale;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if (CGSizeEqualToSize(imageSize, size) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor;
        } else {
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    UIGraphicsBeginImageContextWithOptions(thumbnailRect.size, NO, [UIScreen mainScreen].scale);
    [self drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (newImage) {
        return newImage;
    }
    
    return self;
}

@end
