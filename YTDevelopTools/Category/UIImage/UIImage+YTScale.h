//
//  UIImage+YTScale.h
//  

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YTScale)

- (BOOL)isHaveAlpha;

- (NSString *)base64Encoding;

- (UIColor *)colorWithPoint:(CGPoint)point;

- (UIImage *)imageWithAlwaysOriginalMode;

+ (UIImage *)imageFromURLString:(NSString *)urlstring;

+ (UIImage *)stretchableCenterWithImageStr:(NSString *)imageStr;

+ (UIImage *)stretchableWithImageStr:(NSString *)imageStr leftCap:(CGFloat)leftCap topCap:(CGFloat)topCap;

/// 从中心拉伸的图片
- (UIImage *)stretchableCenter;

/// 自定义拉伸比例的图片
/// @param leftCap 左边不拉伸区域的宽度
/// @param topCap 上面不拉伸的高度
- (UIImage *)stretchableLeftCap:(CGFloat)leftCap topCap:(CGFloat)topCap;

/// 指定宽度按比例缩放
+ (UIImage *)scaleImageNamed:(NSString *)image TargetWidth:(CGFloat)defineWidth;

- (UIImage *)imageScaleWithTargetWidth:(CGFloat)defineWidth;

/// 指定高度按比例缩放
+ (UIImage *)scaleImageNamed:(NSString *)image TargetHeight:(CGFloat)defineHeight;

- (UIImage *)imageScaleWithTargetHeight:(CGFloat)defineHeight;

@end

NS_ASSUME_NONNULL_END
