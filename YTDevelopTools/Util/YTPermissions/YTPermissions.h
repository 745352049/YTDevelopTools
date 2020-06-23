//
//  YTPermissions.h
//  

#import <UIKit/UIKit.h>

typedef void(^resultBlock)(BOOL isPermission, NSString * _Nonnull resultStr);

NS_ASSUME_NONNULL_BEGIN

@interface YTPermissions : NSObject

/// 跳转到设置
+ (void)jumpToSettings;

@end

NS_ASSUME_NONNULL_END
