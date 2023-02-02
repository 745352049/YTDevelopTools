//
//  CarNumberKeyboardView.h
//

#import <UIKit/UIKit.h>

#import "CarNumberKeyboardConfig.h"
#import <AudioToolbox/AudioServices.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarNumberKeyboardView : UIView

- (instancetype)initWithConfig:(CarNumberKeyboardConfig *)config;

@property (nonatomic,   copy) CarNumberKeyboardConfig *config;

@property (nonatomic,   copy) void(^keyboardViewClickBlock)(CarNumberKeyboardView *keyboardView, BOOL isDelete, NSString *value);

@end

NS_ASSUME_NONNULL_END
