//
//  UIImage+YTQRCode.h
//  

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YTQRCode)

+ (UIImage *)createQRCodeWithString:(NSString *)string Width:(CGFloat)width;

/**
 UIImage *Image = [UIImage imageNamed:@"Self"];
 Image = [Image jk_imageScaledToFitSize:CGSizeMake(40, 40)];
 Image = [Image jk_imageWithCornerRadius:8.0];
 */

+ (UIImage *)createQRCodeWithString:(NSString *)string Width:(CGFloat)width centerImage:(UIImage *)centerImage centerWidth:(CGFloat)centerWidth;

@end

NS_ASSUME_NONNULL_END
