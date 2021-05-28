//
//  YTSystemAlertController.m
//  

#import "YTSystemAlertController.h"

@implementation YTSystemAlertController

+ (void)alertWithTitle:(NSString *_Nullable)title
               Message:(NSString *_Nullable)message
        PreferredStyle:(UIAlertControllerStyle)preferredStyle
          ActionTitles:(NSArray<NSString *> *_Nonnull)actionTitles
          ActionStyles:(NSArray<NSString *> *_Nonnull)actionStyles
            Controller:(UIViewController *_Nonnull)controller
            AlertBlock:(YTAlertClickBlock _Nullable)alertClickBlock {
    NSAssert(actionStyles.count == actionTitles.count, @"自定义系统弹框的按钮标题和按钮风格的数组长度应该保持一致");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    [actionTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:obj style:[actionStyles[idx] integerValue] handler:^(UIAlertAction * _Nonnull action) {
            if (alertClickBlock) {
                alertClickBlock(idx);
            }
        }];
        [alertController addAction:action];
    }];
    [controller presentViewController:alertController animated:YES completion:nil];
}

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

@end
