//
//  UIView+YTShadowCorner.m
//

#import "UIView+YTShadowCorner.h"

@implementation UIView (YTShadowCorner)

- (void)setCornerWithType:(UIRectCorner)type Radius:(CGFloat)radius {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:type cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    self.layer.mask = layer;
}

- (void)setShadowWithColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity shadowRadius:(CGFloat)shadowRadius {
    self.clipsToBounds = NO;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowOffset = offset;
}

- (void)setShadowCornerWithColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity shadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius {
    self.clipsToBounds = NO;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowOffset = offset;
    self.layer.cornerRadius = cornerRadius;
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = self.layer.bounds;
    maskLayer.masksToBounds = YES;
    [self.layer addSublayer:maskLayer];
}

@end
