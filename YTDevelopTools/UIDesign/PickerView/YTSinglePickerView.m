//
//  YTSinglePickerView.m
// 

#import "YTSinglePickerView.h"

@interface YTSinglePickerView () <UIPickerViewDelegate, UIPickerViewDataSource> {
    NSString *_title;
    YTResultBlock _resultBlock;
    NSArray *_singleArray;
    NSInteger _defaultIndex;
    NSString *_selectValue;
    BOOL _isAutoSelect;
}

@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation YTSinglePickerView

#pragma mark - 显示选择器

+ (void)showSinglePickerViewWithTitle:(NSString *)title SingleArray:(NSArray *)singleArray DefaultIndex:(NSInteger)defaultIndex isAutoSelect:(BOOL)isAutoSelect resultBlock:(YTResultBlock)resultBlock {
    YTSinglePickerView *singleView = [[YTSinglePickerView alloc] initWithTitle:title SingleArray:singleArray DefaultIndex:defaultIndex isAutoSelect:isAutoSelect resultBlock:resultBlock];
    [singleView showWithAnimation:YES];
}

#pragma mark - 初始化时间选择器

- (instancetype)initWithTitle:(NSString *)title SingleArray:(NSArray *)singleArray DefaultIndex:(NSInteger)defaultIndex isAutoSelect:(BOOL)isAutoSelect resultBlock:(YTResultBlock)resultBlock {
    if (self = [super init]) {
        _title = title;
        _singleArray = singleArray;
        _resultBlock = resultBlock;
        _defaultIndex = defaultIndex;
        _isAutoSelect = isAutoSelect;
        _resultBlock = resultBlock;
        
        [self initUI];
    }
    return self;
}

#pragma mark - 初始化子视图

- (void)initUI {
    [super initUI];

    self.titleLabel.text = _title;
    [self.selectView addSubview:self.pickerView];
}

#pragma mark - 懒加载 pickerView

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, YTTopViewHeight + 0.5, YTDatePicWidth, YTDatePicHeight)];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        NSAssert(_defaultIndex <= _singleArray.count - 1, @"错误的默认选中下标");
        [_pickerView selectRow:_defaultIndex inComponent:0 animated:YES];
    }
    return _pickerView;
}

#pragma mark - 确定按钮的点击事件

- (void)doneBtnAction {
    [self dismissWithAnimation:YES];
    if (_resultBlock) {
        _selectValue = [_singleArray objectAtIndex:[self.pickerView selectedRowInComponent:0]];
        _resultBlock(_selectValue);
    }
}

#pragma mark - 取消按钮的点击事件

- (void)cancleBtnAction {
    [self dismissWithAnimation:YES];
}

#pragma mark - 点击背景遮罩图层事件

- (void)backgroundViewWithTap:(UITapGestureRecognizer *)tap {
    [self dismissWithAnimation:YES];
}

#pragma mark - 弹出视图方法

- (void)showWithAnimation:(BOOL)animation {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
            
            CGRect rect = self.selectView.frame;
            rect.origin.y -= rect.size.height + YT_SAFEAREA_HEIGHT;
            self.selectView.frame = rect;
        }];
    }
}

#pragma mark - 关闭视图方法

- (void)dismissWithAnimation:(BOOL)animation {
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        
        CGRect rect = self.selectView.frame;
        rect.origin.y += rect.size.height + YT_SAFEAREA_HEIGHT;
        self.selectView.frame = rect;
    } completion:^(BOOL finished) {
        [self.cancleBtn removeFromSuperview];
        [self.doneBtn removeFromSuperview];
        [self.titleLabel removeFromSuperview];
        [self.lineView removeFromSuperview];
        [self.topView removeFromSuperview];
        [self.pickerView removeFromSuperview];
        [self.selectView removeFromSuperview];
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
        
        self.cancleBtn = nil;
        self.doneBtn = nil;
        self.titleLabel = nil;
        self.lineView = nil;
        self.topView = nil;
        self.pickerView = nil;
        self.selectView = nil;
        self.backgroundView = nil;
    }];
}

#pragma mark - UIPickerViewDataSource UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _singleArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _singleArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (_isAutoSelect) {
        if (_resultBlock) {
            _resultBlock(_singleArray[row]);
        }
    }
}

@end
