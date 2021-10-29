//
//  YTRotatingImageView.h
//  

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YTRotatingImageView : UIImageView

/// 暂停状态下恢复旋转时 继续旋转还是重置旋转 默认为NO
@property (nonatomic, assign) BOOL isResetWithResume;

/// 是否旋转
@property (nonatomic, assign, readonly) BOOL isRotateState;

/// 是否暂停
@property (nonatomic, assign, readonly) BOOL isPauseState;

/// 是否停止
@property (nonatomic, assign, readonly) BOOL isStopState;

/// 动画完成的回调
@property (nonatomic,   copy) void(^rotatingCompleteBlock)(YTRotatingImageView *rotatingImageView);

/// 开始旋转
- (void)startRotating;

/// 开始旋转
/// @param angle 旋转角度
/// @param duration 旋转一个周期所用的时间
/// @param repeatCount 重复次数
- (void)startRotatingWithAngle:(float)angle Duration:(CFTimeInterval)duration RepeatCount:(float)repeatCount;

/// 暂停旋转
- (void)pauseRotating;

/// 恢复旋转
- (void)resumeRotating;

/// 停止旋转
- (void)stopRotating;

@end

NS_ASSUME_NONNULL_END
