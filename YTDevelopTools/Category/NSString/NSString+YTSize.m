//
//  NSString+YTSize.m
//  

#import "NSString+YTSize.h"

@implementation NSString (YTSize)

- (CGSize)sizeWithFontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize {
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font MaxSize:(CGSize)maxSize {
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

@end
