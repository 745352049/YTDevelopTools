//
//  YTPermissionMediaPlayer.m
//

#import "YTPermissionMediaPlayer.h"

@implementation YTPermissionMediaPlayer

+ (void)mediaLibraryPermissionWithResultBlock:(PermissionMediaPlayerResultBlock)resultBlock {
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

@end
