//
//  YTSinglePickerView.h
// 

#import "YTPickerBaseView.h"

typedef void(^YTResultBlock)(UIPickerView *pickerView, NSString *selectValue);

@interface YTSinglePickerView : YTPickerBaseView

/// 单项选择器
/// @param title 标题
/// @param singleArray 选项数组
/// @param defaultIndex 默认下标
/// @param isAutoSelect 是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
/// @param resultBlock 选中的回调
+ (void)showSinglePickerViewWithTitle:(NSString *)title SingleArray:(NSArray *)singleArray DefaultIndex:(NSInteger)defaultIndex isAutoSelect:(BOOL)isAutoSelect resultBlock:(YTResultBlock)resultBlock;

@end
