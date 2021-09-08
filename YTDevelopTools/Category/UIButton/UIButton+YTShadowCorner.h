//
//  UIButton+YTShadowCorner.h
//  

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (YTShadowCorner)

/// View 圆角
/// @param type 圆角类型
/// @param radius 视图圆角
- (void)setCornerWithType:(UIRectCorner)type Radius:(CGFloat)radius;

/// View 阴影
/// @param color 阴影颜色
/// @param offset 偏移量 四周（0, 0） 向左偏移10（-10, 0） 向右偏移10（10, 0） 向上偏移10（0, -10） 向下偏移10 （0, 10）
/// @param opacity 不透明度
/// @param shadowRadius 阴影圆角
- (void)setShadowWithColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity shadowRadius:(CGFloat)shadowRadius;

/// View 阴影加圆角
/// @param color 阴影颜色
/// @param offset 偏移量 四周（0, 0） 向左偏移10（-10, 0） 向右偏移10（10, 0） 向上偏移10（0, -10） 向下偏移10 （0, 10）
/// @param opacity 不透明度
/// @param shadowRadius 阴影圆角
/// @param cornerRadius 视图圆角
- (void)setShadowCornerWithColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity shadowRadius:(CGFloat)shadowRadius cornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
