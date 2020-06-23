//
//  YTAssistiveTouchView.h
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YTDragDirection) {
    YTDragDirectionAny = 0,
    YTDragDirectionHorizontal,
    YTDragDirectionVertical
};

typedef NS_ENUM(NSUInteger, YTPanGestureState) {
    YTPanGestureStatebegin = 0,
    YTPanGestureStateDuring,
    YTPanGestureStateEnd,
    YTPanGestureStateCancelled
};

typedef NS_ENUM(NSUInteger, YTStayLocation) {
    YTStayLocationLeft = 0,
    YTStayLocationRight,
    YTStayLocationTop,
    YTStayLocationBottom
};

typedef NS_ENUM(NSUInteger, YTMaskLayerLocation) {
    YTMaskLayerLocationAll = 0,
    YTMaskLayerLocationLeft,
    YTMaskLayerLocationRight,
    YTMaskLayerLocationTop,
    YTMaskLayerLocationBottom
};

#define kYTAssistiveTouchView [YTAssistiveTouchView shareInstance]

static CGFloat keepAnimationDuration = 0.4;

@interface YTAssistiveTouchView : UIView

/// 单例
+ (instancetype)shareInstance;

/// 拖曳的方向
@property (nonatomic, assign) YTDragDirection dragDirection;

/// 是否可拖曳，默认YES，YES->能拖曳，NO->不能拖曳
@property (nonatomic, assign) BOOL dragEnable;

/// 黏贴边界效果，默认YES，YES->自动黏贴最近的边界，NO->不会黏贴在边界，它是free(自由)状态，跟随手指到任意位置，但是也不可以拖出给定的范围frame
@property (nonatomic, assign) BOOL isKeepBounds;

/// 是否显示CoverView，默认YES
@property (nonatomic, assign) BOOL isShowCoverView;

/// 是否允许横竖屏切换，默认NO
@property (nonatomic, assign) BOOL isAllowLandscapeMode;

/// 是否是横屏，默认NO
@property (nonatomic, assign) BOOL isLandscapeMode;

/// 显示
- (void)showAssistiveTouchView;

/// 移除
- (void)removeAssistiveTouchView;

/// 隐藏
- (void)hiddenAssistiveTouchView;

/// 不隐藏
- (void)notHiddenAssistiveTouchView;

/// 添加子控件方法
/// @param addBlock 闭包
- (void)addAssistiveTouchViewSubView:(void(^)(YTAssistiveTouchView *assistiveTouchView))addBlock;

/// 添加MaskLayer
/// @param location 位置
- (void)addMaskLayerWith:(YTMaskLayerLocation)location;

/// 设置方法
/// @param setBlock 闭包
- (void)setAssistiveTouchViewProperty:(void(^)(YTAssistiveTouchView *assistiveTouchView))setBlock;

/// 是否显示的回调Block
@property (nonatomic,   copy) void(^isShowAssistiveTouchViewBlock)(YTAssistiveTouchView *assistiveTouchView, BOOL isShow);

/// 是否隐藏的回调Block
@property (nonatomic,   copy) void(^isHiddenAssistiveTouchViewBlock)(YTAssistiveTouchView *assistiveTouchView, BOOL isHidden);

/// 点击手势的回调Block
@property (nonatomic,   copy) void(^tapGestureBlock)(YTAssistiveTouchView *assistiveTouchView, YTStayLocation stayLocation, CGRect rangeRect);

/// 滑动手势的回调Block
@property (nonatomic,   copy) void(^panGestureStateBlock)(YTAssistiveTouchView *assistiveTouchView, YTPanGestureState state);

/// 黏贴边界效果结束回调Block
@property (nonatomic,   copy) void(^keepBoundsAnimationsEndBlock)(YTAssistiveTouchView *assistiveTouchView, YTStayLocation stayLocation);

/// 横竖屏切换通知Block
@property (nonatomic,   copy) void(^orientationDidChangeBlock)(YTAssistiveTouchView *assistiveTouchView, YTStayLocation stayLocation);

/// coverView 移除
- (void)removeCoverView;

/// 设置coverView
/// @param setBlock 闭包
- (void)setCoverViewProperty:(void(^)(UIView *coverView))setBlock;

/// coverView 添加子控件
@property (nonatomic,   copy) void(^addCoverViewSubViewBlock)(UIView *coverView, CGRect assistiveTouchViewFrame, YTStayLocation stayLocation);

/// coverView 是否显示的回调Block
@property (nonatomic,   copy) void(^isShowCoverViewBlock)(UIView *coverView, BOOL isShow);

@end

NS_ASSUME_NONNULL_END
