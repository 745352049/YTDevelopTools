//
//  YTPermissionContacts.h
//

#import "YTPermissions.h"

// 通讯录
#import <Contacts/Contacts.h>

NS_ASSUME_NONNULL_BEGIN

@interface YTPermissionContacts : NSObject

/// 通讯录权限（Privacy - Contacts Usage Description）
/// @param resultBlock 回调结果
+ (void)contactsPermissionWithResultBlock:(resultBlock)resultBlock;

@end

NS_ASSUME_NONNULL_END
