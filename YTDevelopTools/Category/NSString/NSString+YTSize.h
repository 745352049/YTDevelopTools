//
//  NSString+YTSize.h
//  

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YTSize)

- (CGSize)sizeWithFontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;

- (CGSize)sizeWithFont:(UIFont *)font MaxSize:(CGSize)maxSize;

@end

NS_ASSUME_NONNULL_END
