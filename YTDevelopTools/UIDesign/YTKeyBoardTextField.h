//
//  YTKeyBoardTextField.h
//  

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YTKeyBoardTextFieldDelegate <NSObject>

@optional

// 系统代理
- (BOOL)keyBoardTextFieldShouldBeginEditing:(UITextField *)textField;
- (void)keyBoardTextFieldDidBeginEditing:(UITextField *)textField;
- (BOOL)keyBoardTextFieldShouldEndEditing:(UITextField *)textField;
- (void)keyBoardTextFieldDidEndEditing:(UITextField *)textField;
- (void)keyBoardTextFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason API_AVAILABLE(ios(10.0));

- (void)keyBoardTextFieldDidChangeSelection:(UITextField *)textField API_AVAILABLE(ios(13.0), tvos(13.0));
- (BOOL)keyBoardTextFieldShouldReturn:(UITextField *)textField;

// 自定义代理
- (void)keyBoardTextFieldInputing:(UITextField *)textField InputValue:(NSString *)value Complete:(BOOL)complete;

@end

@interface YTKeyBoardTextField : UITextField <UITextFieldDelegate>

@property (nonatomic, assign) BOOL isShowPoint;

@property (nonatomic, assign) NSInteger inputCount;

@property (nonatomic,   weak) id <YTKeyBoardTextFieldDelegate> keyBoardDelegate;

- (void)cleanValue;

@end

NS_ASSUME_NONNULL_END
