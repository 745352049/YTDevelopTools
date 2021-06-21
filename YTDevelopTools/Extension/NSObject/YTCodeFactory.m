//
//  YTCodeFactory.m
//

#import "YTCodeFactory.h"

@implementation YTCodeFactory

+ (UILabel *)getLabelWithTextColor:(UIColor *_Nullable)textColor backgroundColor:(UIColor *_Nullable)backgroundColor font:(UIFont *_Nullable)font alignmen:(NSTextAlignment)alignment text:(NSString *_Nullable)text {
    UILabel *label = [[UILabel alloc] init];
    
    if (textColor) {
        label.textColor = textColor;
    }
    
    if (backgroundColor) {
        label.backgroundColor = backgroundColor;
    }
    
    if (font) {
        label.font = font;
    }
    
    if (alignment) {
        label.textAlignment = alignment;
    }
    
    if (text) {
        label.text = text;
    }
    
    label.userInteractionEnabled = YES;
    label.clipsToBounds = YES;
    label.numberOfLines = 0;
    
    return label;
}

@end
