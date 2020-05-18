//
//  YTPermissions.h
//  

#import <Foundation/Foundation.h>

// 相机
#import <Photos/Photos.h>
// 相册
#import <AssetsLibrary/AssetsLibrary.h>
// 媒体库
#import <MediaPlayer/MediaPlayer.h>
// 通讯录
#import <Contacts/Contacts.h>
// 日历
#import <EventKit/EventKit.h>

typedef void(^resultBlock)(BOOL isPermission, NSString * _Nonnull resultStr);

NS_ASSUME_NONNULL_BEGIN

@interface YTPermissions : NSObject

/// 跳转到设置
+ (void)jumpToSettings;

/// 相机权限（Privacy - Camera Usage Description）
/// @param resultBlock 回调结果
+ (void)cameraPermissionWithResultBlock:(resultBlock)resultBlock;

/// 相册权限（Privacy - Photo Library Usage Description）- 图片库 <表示从图片库(包含其他相册)取照片>
/// @param resultBlock 回调结果
+ (void)photoLibraryPermissionWithResultBlock:(resultBlock)resultBlock;

/// 相册权限（Privacy - Photo Library Usage Description）- 相机胶卷 <表示仅仅从相机胶卷中选取照片>
/// @param resultBlock 回调结果
+ (void)photoAlbumPermissionWithResultBlock:(resultBlock)resultBlock;

/// 麦克风权限（Privacy - Microphone Usage Description）
/// @param resultBlock 回调结果
+ (void)microphonePermissionWithResultBlock:(resultBlock)resultBlock;

/// 媒体库权限（Privacy - Media Library Usage Description）
/// @param resultBlock 回调结果
+ (void)mediaLibraryPermissionWithResultBlock:(resultBlock)resultBlock;

/// 通讯录权限（Privacy - Contacts Usage Description）
/// @param resultBlock 回调结果
+ (void)contactsPermissionWithResultBlock:(resultBlock)resultBlock;

/// 提醒事项权限（Privacy - Reminders Usage Description）
/// @param resultBlock 回调结果
+ (void)remindersPermissionWithResultBlock:(resultBlock)resultBlock;

/// 日历权限（Privacy - Calendars Usage Description）
/// @param resultBlock 回调结果
+ (void)calendarsPermissionWithResultBlock:(resultBlock)resultBlock;

@end

NS_ASSUME_NONNULL_END
