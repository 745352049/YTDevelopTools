//
//  YTPermissionContacts.m
//  

#import "YTPermissionContacts.h"

@implementation YTPermissionContacts

+ (void)contactsPermissionWithResultBlock:(PermissionContactsResultBlock)resultBlock {
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

@end
