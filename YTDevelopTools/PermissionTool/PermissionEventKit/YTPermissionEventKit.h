//
//  YTPermissionEventKit.h
//

// 日历
#import <EventKit/EventKit.h>

typedef void(^PermissionEventKitResultBlock)(BOOL isPermission, NSString * _Nonnull resultStr);

NS_ASSUME_NONNULL_BEGIN

@interface YTPermissionEventKit : NSObject

/// 提醒事项权限（Privacy - Reminders Usage Description）
/// @param resultBlock 回调结果
+ (void)remindersPermissionWithResultBlock:(PermissionEventKitResultBlock)resultBlock;

/// 日历权限（Privacy - Calendars Usage Description）
/// @param resultBlock 回调结果
+ (void)calendarsPermissionWithResultBlock:(PermissionEventKitResultBlock)resultBlock;

@end

NS_ASSUME_NONNULL_END
