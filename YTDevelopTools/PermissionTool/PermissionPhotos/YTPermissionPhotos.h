//
//  YTPermissionPhotos.h
//

// 相机
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

typedef void(^PermissionPhotosResultBlock)(BOOL isPermission, NSString * _Nonnull resultStr);

NS_ASSUME_NONNULL_BEGIN

@interface YTPermissionPhotos : NSObject

/// 相机权限（Privacy - Camera Usage Description）
/// @param resultBlock 回调结果
+ (void)cameraPermissionWithResultBlock:(PermissionPhotosResultBlock)resultBlock;

/// 相册权限（Privacy - Photo Library Usage Description）- 图片库 <表示从图片库(包含其他相册)取照片>
/// @param resultBlock 回调结果
+ (void)photoLibraryPermissionWithResultBlock:(PermissionPhotosResultBlock)resultBlock;

/// 相册权限（Privacy - Photo Library Usage Description）- 相机胶卷 <表示仅仅从相机胶卷中选取照片>
/// @param resultBlock 回调结果
+ (void)photoAlbumPermissionWithResultBlock:(PermissionPhotosResultBlock)resultBlock;

/// 麦克风权限（Privacy - Microphone Usage Description）
/// @param resultBlock 回调结果
+ (void)microphonePermissionWithResultBlock:(PermissionPhotosResultBlock)resultBlock;

@end

NS_ASSUME_NONNULL_END
