//
//  UIImage+YTWaterMark.h
//  

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YTWaterMarkLocation) {
    YTWaterMarkLocation_Center = 0,
    YTWaterMarkLocation_LeftTop,
    YTWaterMarkLocation_LeftBottom,
    YTWaterMarkLocation_RightTop,
    YTWaterMarkLocation_RightBottom
};

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YTWaterMark)

/// 添加水印
/// @param text 水印文字
/// @param attrs 水印文字样式
/// @param spaceSize spaceSize.width  水平间距  spaceSize.height  垂直间距
/// @param transformRotation 旋转角度
- (UIImage *)getWaterMarkImageWithText:(NSString *)text Attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs SpaceSize:(CGSize)spaceSize TransformRotation:(CGFloat)transformRotation;

- (UIImage *)getWaterMarkImageWithText:(NSString *)text;

/*
 * TIPS：水印位置 Center      spaceSize -> nothing
                LeftTop     spaceSize.width spaceSize.height -> 居左 居上 的边距
                LeftBottom  spaceSize.width spaceSize.height -> 居左 居下 的边距
                RightTop    spaceSize.width spaceSize.height -> 居右 居上 的边距
                RightBottom spaceSize.width spaceSize.height -> 居右 居下 的边距
*/

/// 添加固定位置水印
/// @param text 水印文字
/// @param attrs 水印文字样式
/// @param spaceSize 边距
/// @param location 位置
- (UIImage *)getLocationWaterMarkImageWithText:(NSString *)text Attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs SpaceSize:(CGSize)spaceSize Location:(YTWaterMarkLocation)location;

- (UIImage *)getLocationWaterMarkImageWithText:(NSString *)text Location:(YTWaterMarkLocation)location;

@end

NS_ASSUME_NONNULL_END
