//
//  YTPermissionPhotos.m
//  

#import "YTPermissionPhotos.h"

@implementation YTPermissionPhotos

+ (void)cameraPermissionWithResultBlock:(resultBlock)resultBlock {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        if (authStatus == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"********** 首次请求相机权限并同意授权 **********");
                        resultBlock(YES, @"相机权限");
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"********** 首次请求相机权限并拒接授权 **********");
                        resultBlock(NO, @"无相机权限");
                    });
                }
            }];
        } else if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"********** 相机权限限制或手动关闭授权 **********");
                resultBlock(NO, @"无相机权限");
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"********** 已经获得相机权限 **********");
                resultBlock(YES, @"相机权限");
            });
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"********** 该设备不支持相机功能 **********");
            resultBlock(NO, @"该设备不支持相机功能");
        });
    }
}

+ (void)photoLibraryPermissionWithResultBlock:(resultBlock)resultBlock {
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        if (authStatus == PHAuthorizationStatusNotDetermined) {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusNotDetermined) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"********** 首次请求图片库权限 **********");
                        resultBlock(NO, @"首次请求图片库权限");
                    });
                } else if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"********** 首次请求图片库权限并拒接授权 **********");
                        resultBlock(NO, @"无图片库权限");
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"********** 首次请求图片库权限并同意授权 **********");
                        resultBlock(YES, @"图片库权限");
                    });
                }
            }];
        } else if (authStatus == PHAuthorizationStatusRestricted || authStatus == PHAuthorizationStatusDenied) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"********** 图片库权限限制或手动关闭授权 **********");
                resultBlock(NO, @"无图片库权限");
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"********** 已经获得图片库权限 **********");
                resultBlock(YES, @"图片库权限");
            });
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"********** 该设备不支持图片库集选功能 **********");
            resultBlock(NO, @"该设备不支持图片库功能");
        });
    }
}

+ (void)photoAlbumPermissionWithResultBlock:(resultBlock)resultBlock {
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        if (authStatus == AVAuthorizationStatusNotDetermined) {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusNotDetermined) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"********** 首次请求相册权限 **********");
                        resultBlock(NO, @"首次请求相册权限");
                    });
                } else if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"********** 首次请求相册权限并拒接授权 **********");
                        resultBlock(NO, @"无相册权限");
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"********** 首次请求相册权限并同意授权 **********");
                        resultBlock(YES, @"相册权限");
                    });
                }
            }];
        } else if (authStatus == PHAuthorizationStatusRestricted || authStatus == PHAuthorizationStatusDenied) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"********** 相册权限限制或手动关闭授权 **********");
                resultBlock(NO, @"无相册权限");
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"********** 已经获得相册权限 **********");
                resultBlock(YES, @"相册权限");
            });
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"********** 该设备不支持相册功能 **********");
            resultBlock(NO, @"该设备不支持相册功能");
        });
    }
}

+ (void)microphonePermissionWithResultBlock:(resultBlock)resultBlock {
    AVAudioSessionRecordPermission status = [[AVAudioSession sharedInstance] recordPermission];
    if (status == AVAudioSessionRecordPermissionUndetermined) {
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"********** 首次请求麦克风权限并同意授权 **********");
                    resultBlock(YES, @"麦克风权限");
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"********** 首次请求麦克风权限并拒接授权 **********");
                    resultBlock(NO, @"无麦克风权限");
                });
            }
        }];
    } else if (status == AVAudioSessionRecordPermissionDenied) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"********** 麦克风权限限制或手动关闭授权 **********");
            resultBlock(NO, @"无麦克风权限");
        });
    } else if (status == AVAudioSessionRecordPermissionGranted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"********** 已经获得麦克风权限 **********");
            resultBlock(YES, @"麦克风权限");
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"********** 该设备不支持麦克风功能 **********");
            resultBlock(NO, @"该设备不支持麦克风功能");
        });
    }
}

@end
