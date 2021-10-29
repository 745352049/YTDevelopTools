//
//  YTMethodHeader.h
//  

#ifndef YTMethodHeader_h
#define YTMethodHeader_h

/// NSLog打印宏
#ifdef DEBUG
#define YTLog(fmt, ...) NSLog((@"\n👉 %@ %s [Line %d] 👈 \n" fmt @"\n"), NSStringFromClass([self class]), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define YTLog(...)
#endif

/// NSLog打印宏
#ifdef DEBUG
#define LongLog(format, ...) printf("👉 %s 👈", [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String])
#else
#define LongLog(...)
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

/// NSUserDefaults
#define userDefaults [NSUserDefaults standardUserDefaults]

/// NSNotificationCenter
#define notificationCenter [NSNotificationCenter defaultCenter]

/// 颜色
#define ColorWith(Red, Green, Blue, Alpha) [UIColor colorWithRed:Red/255.0 green:Green/255.0 blue:Blue/255.0 alpha:Alpha]

/// 颜色
#define ColorAlphaWith(Red, Green, Blue, Alpha) [UIColor colorWithRed:Red/255.0 green:Green/255.0 blue:Blue/255.0 alpha:Alpha]

/// 颜色
#define ColorWithRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/// NSUserDefaults
#define userDefaults [NSUserDefaults standardUserDefaults]

/// NSNotificationCenter
#define notificationCenter [NSNotificationCenter defaultCenter]

/// 图片
#define ImageNamed(imageString) [UIImage imageNamed:imageString]

/// 字体
#define FontSize(size) [UIFont systemFontOfSize:size]

#define BoldFontSize(size) [UIFont boldSystemFontOfSize:size]

/// UIStoryboard
#define StoryboardWith(Name) [UIStoryboard storyboardWithName:Name bundle:[NSBundle mainBundle]]

#endif /* YTMethodHeader_h */
