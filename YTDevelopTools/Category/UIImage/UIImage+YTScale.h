//
//  UIImage+YTScale.h
//  

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YTScale)

+ (UIImage *)imageFromURLString:(NSString *)urlstring;

/// 指定宽度按比例缩放
+ (UIImage *)scaleImageNamed:(NSString *)image TargetWidth:(CGFloat)defineWidth;

- (UIImage *)imageScaleWithTargetWidth:(CGFloat)defineWidth;

/// 指定高度按比例缩放
+ (UIImage *)scaleImageNamed:(NSString *)image TargetHeight:(CGFloat)defineHeight;

- (UIImage *)imageScaleWithTargetHeight:(CGFloat)defineHeight;

@end

NS_ASSUME_NONNULL_END
