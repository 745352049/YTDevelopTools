//
//  YTSystemAlertController.h
// 

#import <UIKit/UIKit.h>

typedef void(^YTAlertClickBlock)(NSInteger index);

@interface YTSystemAlertController : NSObject

/**
 Tips：
 系统UIAlertController Title 可空 message 可空 UIAlertActionStyleCancel 只能设置于取消按钮

 按钮风格
 UIAlertActionStyleDefault = 0,
 UIAlertActionStyleCancel,
 UIAlertActionStyleDestructive

 弹框风格
 UIAlertControllerStyleActionSheet = 0,
 UIAlertControllerStyleAlert
 */

/**

 调法式例：
 1.注意按钮标题和按钮风格的数组一一对应
 2.设置UIAlertActionStyleCancel的时候注意放在第一位
 [YTSystemAlertController alertWithTitle:@"提示" Message:@"注意按钮标题和按钮风格的数组一一对应" PreferredStyle:UIAlertControllerStyleAlert ActionTitles:@[@"取消", @"确定"] ActionStyles:@[@"1", @"2"] Controller:self AlertBlock:^(NSInteger index) {
     NSLog(@"点击了 --- %ld", (long)index);
 }];

 */

/**
 系统弹框

 @param title title
 @param message message
 @param preferredStyle 弹框风格
 @param actionTitles 按钮标题数组
 @param actionStyles 按钮风格数组
 @param controller 弹框所在控制器
 @param alertClickBlock 回调
 */
+ (void)alertWithTitle:(NSString *_Nullable)title
               Message:(NSString *_Nullable)message
        PreferredStyle:(UIAlertControllerStyle)preferredStyle
          ActionTitles:(NSArray<NSString *> *_Nonnull)actionTitles
          ActionStyles:(NSArray<NSString *> *_Nonnull)actionStyles
            Controller:(UIViewController *_Nonnull)controller
            AlertBlock:(YTAlertClickBlock _Nullable)alertClickBlock;

@end
