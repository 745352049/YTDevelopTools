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
    for (int i = 0; i < actionTitles.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitles[i] style:[actionStyles[i] integerValue] handler:^(UIAlertAction * _Nonnull action) {
            if (alertClickBlock) {
                alertClickBlock(i);
            }
        }];
        [alertController addAction:action];
    }
    [controller presentViewController:alertController animated:YES completion:nil];
}

@end