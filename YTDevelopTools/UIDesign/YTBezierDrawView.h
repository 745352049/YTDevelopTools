//
//  YTBezierDrawView.h
//

#import <UIKit/UIKit.h>

#import "YTBezierDrawPath.h"

NS_ASSUME_NONNULL_BEGIN

@interface YTBezierDrawView : UIView

/// 贝塞尔对象
@property (nonatomic, strong) YTBezierDrawPath *path;
/// 路径集合
@property (nonatomic, strong) NSMutableArray *pathsArray;
/// 当前点的坐标
@property (nonatomic,  copy) void(^drawCurrentPointBlock)(CGPoint currentPoint);
/// 自定义绘制路径
@property (nonatomic,  copy) void(^drawCustomPathPointBlock)(YTBezierDrawView *drawView, CGPoint currentPoint, UIPanGestureRecognizer *panGesture);
/// 画线的宽度
@property (nonatomic, assign) CGFloat lineWidth;
/// 线条颜色
@property (nonatomic, retain) UIColor *lineColor;
/// 加载背景图片
@property (nonatomic, strong) UIImage *image;
/// 清屏
- (void)clear;
/// 撤销
- (void)undo;
/// 橡皮擦
- (void)eraser;
/// 获得画板图片
- (UIImage *)getDrawImage;

@end

NS_ASSUME_NONNULL_END
