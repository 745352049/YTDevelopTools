//
//  UIColor+YTAdapter.m
//  

#import "UIColor+YTAdapter.h"

@implementation UIColor (YTAdapter)

+ (UIColor *)colorWithLightColor:(UIColor *)lightColor DarkColor:(UIColor *)darkColor {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
            if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleDark) {
                return darkColor ? darkColor : [UIColor whiteColor];
            } else {
                return lightColor ? lightColor : [UIColor blackColor];
            }
        }];
    } else {
        return lightColor ? lightColor : [UIColor blackColor];
    }
}

@end
