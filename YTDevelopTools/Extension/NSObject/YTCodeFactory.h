//
//  YTCodeFactory.h
//  

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YTCodeFactory : NSObject

+ (UILabel *)getLabelWithTextColor:(UIColor *_Nullable)textColor backgroundColor:(UIColor *_Nullable)backgroundColor font:(UIFont *_Nullable)font alignmen:(NSTextAlignment)alignment text:(NSString *_Nullable)text;

@end

NS_ASSUME_NONNULL_END
