//
//  YTKeyBoardView.h
// 

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YTKeyBoardHandleType) {
    YTKeyBoardHandleType_Delete = 0, // 删除键
    YTKeyBoardHandleType_Number,     // 数字键
    YTKeyBoardHandleType_Point       // 点键
};

#define YTKeyBoardChangeNotification @"YTKeyBoardChangeNotification"

NS_ASSUME_NONNULL_BEGIN

@interface YTKeyBoardView : UIView

@property (nonatomic, assign) BOOL isShowPoint;

@property (nonatomic, copy) void(^keyBoardClickBlock)(NSString * _Nullable value, YTKeyBoardHandleType type);

@end

NS_ASSUME_NONNULL_END
