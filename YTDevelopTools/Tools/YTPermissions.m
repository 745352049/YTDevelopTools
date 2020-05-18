//
//  YTPermissions.m
//  

#import "YTPermissions.h"

@implementation YTPermissions

+ (void)jumpToSettings {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {

            }];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Cannot jump to < Settings >, please manually jump to < Settings >!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

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
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        if (authStatus == AVAuthorizationStatusNotDetermined) {
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
        } else if (authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied) {
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
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
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
        } else if (authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied) {
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

+ (void)mediaLibraryPermissionWithResultBlock:(resultBlock)resultBlock {
    if (@available(iOS 9.3, *)) {
        MPMediaLibraryAuthorizationStatus authStatus = [MPMediaLibrary authorizationStatus];
        if (authStatus == MPMediaLibraryAuthorizationStatusNotDetermined) {
            [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
                if (status == MPMediaLibraryAuthorizationStatusAuthorized) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"********** 首次请求媒体库权限并同意授权 **********");
                        resultBlock(YES, @"媒体库权限");
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"********** 首次请求媒体库权限并拒接授权 **********");
                        resultBlock(NO, @"无媒体库权限");
                    });
                }
            }];
        } else if (authStatus == MPMediaLibraryAuthorizationStatusDenied || authStatus == MPMediaLibraryAuthorizationStatusRestricted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"********** 媒体库权限限制或手动关闭授权 **********");
                resultBlock(NO, @"无媒体库权限");
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"********** 已经获得媒体库权限 **********");
                resultBlock(YES, @"媒体库权限");
            });
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"********** 该设备不支持媒体库功能 **********");
            resultBlock(NO, @"该设备系统版本不支持媒体库功能");
        });
    }
}

+ (void)contactsPermissionWithResultBlock:(resultBlock)resultBlock {
    if (@available(iOS 9.0, *)) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (status == CNAuthorizationStatusNotDetermined) {
            CNContactStore *store = [[CNContactStore alloc] init];
            [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError*  _Nullable error) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"********** 首次请求通讯录权限并同意授权 **********");
                        resultBlock(YES, @"通讯录权限");
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"********** 首次请求通讯录权限并拒接授权 **********");
                        resultBlock(NO, @"无通讯录权限");
                    });
                }
            }];
        } else if (status == CNAuthorizationStatusRestricted || status == CNAuthorizationStatusDenied) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"********** 通讯录权限限制或手动关闭授权 **********");
                resultBlock(NO, @"无通讯录权限");
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"********** 已经获得通讯录权限 **********");
                resultBlock(YES, @"通讯录权限");
            });
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"********** 该设备不支持通讯录功能 **********");
            resultBlock(NO, @"该设备系统版本不支持通讯录功能");
        });
    }
}

+ (void)remindersPermissionWithResultBlock:(resultBlock)resultBlock {
    EKAuthorizationStatus authStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
    if (authStatus == EKAuthorizationStatusNotDetermined) {
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        [eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
            if (granted == YES) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"********** 首次请求提醒事项权限并同意授权 **********");
                    resultBlock(YES, @"提醒事项权限");
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"********** 首次请求提醒事项权限并拒接授权 **********");
                    resultBlock(NO, @"提醒事项权限");
                });
            }
        }];
    } else if (authStatus == EKAuthorizationStatusRestricted || authStatus == EKAuthorizationStatusDenied) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"********** 提醒事项权限限制或手动关闭授权 **********");
            resultBlock(NO, @"无提醒事项权限");
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"********** 已经获得提醒事项权限 **********");
            resultBlock(YES, @"提醒事项权限");
        });
    }
}

+ (void)calendarsPermissionWithResultBlock:(resultBlock)resultBlock {
    EKAuthorizationStatus authStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
    if (authStatus == EKAuthorizationStatusNotDetermined) {
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            if (granted == YES) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"********** 首次请求日历权限并同意授权 **********");
                    resultBlock(YES, @"日历权限");
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"********** 首次请求日历权限并拒接授权 **********");
                    resultBlock(NO, @"日历权限");
                });
            }
        }];
    } else if (authStatus == EKAuthorizationStatusRestricted || authStatus == EKAuthorizationStatusDenied) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"********** 日历权限限制或手动关闭授权 **********");
            resultBlock(NO, @"无日历权限");
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"********** 已经获得日历权限 **********");
            resultBlock(YES, @"日历权限");
        });
    }
}

@end
