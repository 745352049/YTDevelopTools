//
//  YTPlaceholderTextView.h
//  

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class YTPlaceholderTextView;

typedef void(^didChangeText)(YTPlaceholderTextView *textView);

@interface YTPlaceholderTextView : UITextView

@property (nonatomic,   copy) NSString *placeholder;
@property (nonatomic,   copy) UIColor *placeholderColor;
@property (nonatomic, assign) NSInteger maxCount;
@property (nonatomic,   copy) didChangeText didChangeText;

- (void)didChangeText:(didChangeText)block;

@end

NS_ASSUME_NONNULL_END
