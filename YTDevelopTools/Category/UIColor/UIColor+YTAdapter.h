//
//  UIColor+YTAdapter.h
//  

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 适配暗黑模式
@interface UIColor (YTAdapter)

+ (UIColor *)colorWithLightColor:(UIColor *)lightColor DarkColor:(UIColor *)darkColor;

@end

NS_ASSUME_NONNULL_END
