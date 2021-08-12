//
//  UIColor+YTColor.h
//

#import <UIKit/UIKit.h>

@interface UIColor (YTColor)

/// 十六进制颜色（以#开头）转换为UIColor
/// @param string 十六进制的颜色
/// @param alpha alpha
+ (UIColor *)colorWithHex:(NSString *)string alpha:(CGFloat)alpha;

/// RGB转换为UIColor
/// @param red red
/// @param green green
/// @param blue blue
/// @param alpha alpha
+ (UIColor *)colorWithRGB:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

/// 颜色转图片
/// @param color 颜色
+ (UIImage *)colorImageWithColor:(UIColor *)color;

/// 随机颜色
/// @param alpha alpha
+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;

@end
