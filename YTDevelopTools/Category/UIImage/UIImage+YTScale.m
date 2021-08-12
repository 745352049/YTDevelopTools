//
//  UIImage+YTScale.m
// 

#import "UIImage+YTScale.h"

@implementation UIImage (YTScale)

+ (UIImage *)imageFromURLString:(NSString *)urlstring {
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlstring]]];
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
