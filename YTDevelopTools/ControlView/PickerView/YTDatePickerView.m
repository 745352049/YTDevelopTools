//
//  YTDatePickerView.m
//

#import "YTDatePickerView.h"

@interface YTDatePickerView () {
    UIDatePickerMode _datePickerMode;
    NSString *_title;
    NSString *_minDateStr;
    NSString *_maxDateStr;
    YTDateResultBlock _resultBlock;
    NSString *_selectValue;
    BOOL _isAutoSelect;
}

@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation YTDatePickerView

#pragma mark - 显示时间选择器

+ (void)showDatePickerWithTitle:(NSString *)title dateType:(UIDatePickerMode)type defaultSelValue:(NSString *)defaultSelValue minDateStr:(NSString *)minDateStr maxDateStr:(NSString *)maxDateStr isAutoSelect:(BOOL)isAutoSelect resultBlock:(YTDateResultBlock)resultBlock {
    YTDatePickerView *datePickerView = [[YTDatePickerView alloc] initWithTitle:title dateType:type defaultSelValue:defaultSelValue minDateStr:(NSString *)minDateStr maxDateStr:(NSString *)maxDateStr isAutoSelect:isAutoSelect resultBlock:resultBlock];
    [datePickerView showWithAnimation:YES];
}

#pragma mark - 初始化时间选择器

- (instancetype)initWithTitle:(NSString *)title dateType:(UIDatePickerMode)type defaultSelValue:(NSString *)defaultSelValue minDateStr:(NSString *)minDateStr maxDateStr:(NSString *)maxDateStr isAutoSelect:(BOOL)isAutoSelect resultBlock:(YTDateResultBlock)resultBlock {
    if (self = [super init]) {
        _datePickerMode = type;
        _title = title;
        _minDateStr = minDateStr;
        _maxDateStr = maxDateStr;
        _isAutoSelect = isAutoSelect;
        _resultBlock = resultBlock;
        if (defaultSelValue.length > 0) {
            _selectValue = defaultSelValue;
        } else {
            _selectValue = [self toStringWithDate:[NSDate date]];
        }
        
        [self initUI];
    }
    return self;
}

#pragma mark - 初始化子视图

- (void)initUI {
    [super initUI];

    self.titleLabel.text = _title;
    [self.selectView addSubview:self.datePicker];
}

#pragma mark - 时间选择器

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.backgroundColor = [UIColor whiteColor];
        if (@available(iOS 13.4, *)) {
            _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        }
        _datePicker.datePickerMode = _datePickerMode;
        _datePicker.frame = CGRectMake(0, YTTopViewHeight + 0.5, YTDatePicWidth, YTDatePicHeight);
        // 设置该UIDatePicker的国际化Locale，以简体中文习惯显示日期，UIDatePicker控件默认使用iOS系统的国际化Locale
        _datePicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CHS_CN"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        dateFormatter.locale = [NSLocale systemLocale];
        [dateFormatter setCalendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian]];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        // 设置时间范围
        if (_minDateStr != nil && _minDateStr.length > 0) {
            NSDate *minDate = [dateFormatter dateFromString:_minDateStr];
            if (minDate) {
                _datePicker.minimumDate = minDate;
            }
        }
        if (_maxDateStr != nil && _maxDateStr.length > 0) {
            NSDate *maxDate = [dateFormatter dateFromString:_maxDateStr];
            if (maxDate) {
                _datePicker.maximumDate = maxDate;
            }
        }
        NSDate *crrentDate = [self toDateWithDateString:_selectValue];
        if (crrentDate) {
            // 把当前时间赋值给 _datePicker
            [_datePicker setDate:crrentDate animated:YES];
        }
        // 滚动改变值的响应事件
        [_datePicker addTarget:self action:@selector(didSelectValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}

#pragma mark - 时间选择器的滚动响应事件

- (void)didSelectValueChanged:(UIDatePicker *)sender {
    if (sender.date) {
        _selectValue = [self toStringWithDate:sender.date];
        if (_isAutoSelect) {
            if (_resultBlock) {
                _resultBlock(self.datePicker, _selectValue);
            }
        }
    }
}

#pragma mark - 确定按钮的点击事件

- (void)doneBtnAction {
    [self dismissWithAnimation:YES];
    if (_resultBlock) {
        _resultBlock(self.datePicker, _selectValue);
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
        [self.datePicker removeFromSuperview];
        [self.selectView removeFromSuperview];
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
        
        self.cancleBtn = nil;
        self.doneBtn = nil;
        self.titleLabel = nil;
        self.lineView = nil;
        self.topView = nil;
        self.datePicker = nil;
        self.selectView = nil;
        self.backgroundView = nil;
    }];
}

#pragma mark - 格式转换：NSDate --> NSString

- (NSString *)toStringWithDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    dateFormatter.locale = [NSLocale systemLocale];
    [dateFormatter setCalendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    switch (_datePickerMode) {
        case UIDatePickerModeTime:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        case UIDatePickerModeDate:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case UIDatePickerModeDateAndTime:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case UIDatePickerModeCountDownTimer:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        default:
            break;
    }
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

#pragma mark - 格式转换：NSString --> NSDate

- (NSDate *)toDateWithDateString:(NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    dateFormatter.locale = [NSLocale systemLocale];
    [dateFormatter setCalendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    switch (_datePickerMode) {
        case UIDatePickerModeTime:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        case UIDatePickerModeDate:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case UIDatePickerModeDateAndTime:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case UIDatePickerModeCountDownTimer:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        default:
            break;
    }
    NSDate *destDate = [dateFormatter dateFromString:dateString];
    
    return destDate;
}

@end
