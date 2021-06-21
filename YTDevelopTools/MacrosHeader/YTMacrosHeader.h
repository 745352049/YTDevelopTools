//
//  YTMacrosHeader.h
//

#ifndef YTMacrosHeader_h
#define YTMacrosHeader_h

/// NSLog打印宏
#ifdef DEBUG
#define YTLog(fmt, ...) NSLog((@"\n👉 %@ %s [Line %d] 👈 \n" fmt @"\n"), NSStringFromClass([self class]), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define YTLog(...)
#endif

/// 弱引用
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

/// 强引用
#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

/// 判断屏幕方向是否是竖屏
#define judgeDeviceOrientationLandscapeHorizontal() \
^(){\
    if ([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight || [UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft) { \
        return YES; \
    } else { \
        return NO; \
    } \
}()

/// WindowsSize
#define WindowsSize [UIScreen mainScreen].bounds.size

/// 判断是否是iPad
#define UI_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/// 判断是否是iPhone
#define UI_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/// 当前屏幕宽
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

/// 当前屏幕高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

/// 绝对长度 pt * SCALE  ||  像素 px / 2 * SCALE
#define SCALE_WIDTH SCREEN_WIDTH/375.0
#define SCALE_HEIGHT SCREEN_HEIGHT/667.0

/// 状态栏高度
#define UIStatusbarHeight() \
^(){\
if (@available(iOS 13.0, *)) {\
return [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;\
} else {\
return [[UIApplication sharedApplication] statusBarFrame].size.height;\
}\
}()

#define UI_Statusbar_Height UIStatusbarHeight()

/// 导航栏 + 状态栏 高度
#define UI_NavBar_Height UI_Statusbar_Height > 20.0 ? 88.0 : 64.0

/// 曲面屏底部安全区域高度
#define UI_SafeArea_Height UI_Statusbar_Height > 20.0 ? 34.0 : 0.0

/// 机型判断
/// 判断iPhone 4 系列
#define IS_IPHONE_4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)
/// 判断iPhone 5 系列
#define IS_IPHONE_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)
/// 判断iPhone 6 系列
#define IS_IPHONE_6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)
/// 判断iphone 6+ 系列
#define IS_IPHONE_6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)
/// 判断iPhone X
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)
/// 判断iPHone Xr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)
/// 判断iPhone Xs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)
/// 判断iPhone Xs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)
/// 判断iPhone 11
#define IS_IPHONE_11 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)
/// 判断iPhone 11 Pro
#define IS_IPHONE_11_Pro ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)
/// 判断iPhone 11 Pro Max
#define IS_IPHONE_11_Pro_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)
/// 判断iPhone 12
#define IS_IPHONE_12 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1170, 2532), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)
/// 判断iPhone 12 Mini
#define IS_IPHONE_12_Mini ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1080, 2340), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)
/// 判断iPhone 12 Pro
#define IS_IPHONE_12_Pro ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1170, 2532), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)
/// 判断iPhone 12 Pro Max
#define IS_IPHONE_12_Pro_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1284, 2778), [[UIScreen mainScreen] currentMode].size) && !UI_IS_IPAD : NO)

/// 是否是曲面屏
#define UI_IPHONE_X_More (IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max == YES || IS_IPHONE_11 == YES || IS_IPHONE_11_Pro == YES || IS_IPHONE_11_Pro_Max == YES || IS_IPHONE_12 == YES || IS_IPHONE_12_Mini == YES || IS_IPHONE_12_Pro == YES || IS_IPHONE_12_Pro_Max == YES)

/// NSUserDefaults
#define userDefaults [NSUserDefaults standardUserDefaults]

/// NSNotificationCenter
#define notificationCenter [NSNotificationCenter defaultCenter]

#endif /* YTMacrosHeader_h */
