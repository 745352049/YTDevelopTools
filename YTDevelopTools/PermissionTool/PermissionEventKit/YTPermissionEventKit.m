//
//  YTPermissionEventKit.m
//

#import "YTPermissionEventKit.h"

@implementation YTPermissionEventKit

+ (void)remindersPermissionWithResultBlock:(PermissionEventKitResultBlock)resultBlock {
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

+ (void)calendarsPermissionWithResultBlock:(PermissionEventKitResultBlock)resultBlock {
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
