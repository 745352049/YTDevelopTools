//
//  YTPermissionMediaPlayer.h
//

#import "YTPermissions.h"

// 媒体库
#import <MediaPlayer/MediaPlayer.h>

NS_ASSUME_NONNULL_BEGIN

@interface YTPermissionMediaPlayer : NSObject

/// 媒体库权限（Privacy - Media Library Usage Description）
/// @param resultBlock 回调结果
+ (void)mediaLibraryPermissionWithResultBlock:(resultBlock)resultBlock;

@end

NS_ASSUME_NONNULL_END
