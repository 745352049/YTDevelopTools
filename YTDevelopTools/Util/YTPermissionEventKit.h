//
//  YTPermissionEventKit.h
//

#import "YTPermissions.h"

// 日历
#import <EventKit/EventKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YTPermissionEventKit : NSObject

/// 提醒事项权限（Privacy - Reminders Usage Description）
/// @param resultBlock 回调结果
+ (void)remindersPermissionWithResultBlock:(resultBlock)resultBlock;

/// 日历权限（Privacy - Calendars Usage Description）
/// @param resultBlock 回调结果
+ (void)calendarsPermissionWithResultBlock:(resultBlock)resultBlock;

@end

NS_ASSUME_NONNULL_END
