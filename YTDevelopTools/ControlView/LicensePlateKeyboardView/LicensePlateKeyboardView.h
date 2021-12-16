//
//  LicensePlateKeyboardView.h
// 

#import <UIKit/UIKit.h>

#import "LicensePlateKeyboardConfig.h"
#import <AudioToolbox/AudioServices.h>

NS_ASSUME_NONNULL_BEGIN

@interface LicensePlateKeyboardView : UIView

- (instancetype)initWithConfig:(LicensePlateKeyboardConfig *)config;

@property (nonatomic,   copy) LicensePlateKeyboardConfig *config;

@property (nonatomic,   copy) void(^keyboardViewClickBlock)(LicensePlateKeyboardView *keyboardView, BOOL isDelete, BOOL isDone, NSString *value);

@end

NS_ASSUME_NONNULL_END
