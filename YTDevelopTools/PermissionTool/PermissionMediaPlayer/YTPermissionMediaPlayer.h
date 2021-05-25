//
//  YTPermissionMediaPlayer.h
//

// 媒体库
#import <MediaPlayer/MediaPlayer.h>

typedef void(^PermissionMediaPlayerResultBlock)(BOOL isPermission, NSString * _Nonnull resultStr);

NS_ASSUME_NONNULL_BEGIN

@interface YTPermissionMediaPlayer : NSObject

/// 媒体库权限（Privacy - Media Library Usage Description）
/// @param resultBlock 回调结果
+ (void)mediaLibraryPermissionWithResultBlock:(PermissionMediaPlayerResultBlock)resultBlock;

@end

NS_ASSUME_NONNULL_END
