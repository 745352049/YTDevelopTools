//
//  YTPickerBaseView.h
// 

#import <UIKit/UIKit.h>

#define YTSCREEN_BOUNDS [UIScreen mainScreen].bounds
#define YTSCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define YTSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/// 状态栏高度
#define YTUISTATUSBARHEIGHT() \
^(){\
if (@available(iOS 13.0, *)) {\
return [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;\
} else {\
return [[UIApplication sharedApplication] statusBarFrame].size.height;\
}\
}()

#define YT_STATUSBAR_HEIGHT YTUISTATUSBARHEIGHT()
#define YT_SAFEAREA_HEIGHT (YT_STATUSBAR_HEIGHT > 20.0 ? 34.0 : 0.0)

#define YTDatePicWidth (350.0*(YTSCREEN_WIDTH/375.0))
#define YTButtonWidth 60.0

#define YTDatePicHeight (200.0*(YTSCREEN_HEIGHT/667.0))
#define YTTopViewHeight (40.0*(YTSCREEN_HEIGHT/667.0))
#define YTTotalViewHeight (240.0*(YTSCREEN_HEIGHT/667.0))

#define YTRGB_HEX(HexValue, Alpha) [UIColor colorWithRed:((CGFloat)((HexValue & 0xFF0000) >> 16)) / 255.0 green:((CGFloat)((HexValue & 0xFF00) >> 8)) / 255.0 blue:((CGFloat)(HexValue & 0xFF)) / 255.0 alpha:(Alpha)]

@interface YTPickerBaseView : UIView

/// 背景视图
@property (nonatomic, strong) UIView *backgroundView;

/// 弹出视图
@property (nonatomic, strong) UIView *selectView;

/// 顶部视图
@property (nonatomic, strong) UIView *topView;

/// 取消按钮
@property (nonatomic, strong) UIButton *cancleBtn;

/// 确定按钮
@property (nonatomic, strong) UIButton *doneBtn;

/// 中间标题
@property (nonatomic, strong) UILabel *titleLabel;

/// 分割线
@property (nonatomic, strong) UIView *lineView;

/// 初始化子视图
- (void)initUI;

/// 点击背景遮罩图层事件
- (void)backgroundViewWithTap:(UITapGestureRecognizer *)tap;

/// 取消按钮的点击事件
- (void)cancleBtnAction;

/// 确定按钮的点击事件
- (void)doneBtnAction;

@end
