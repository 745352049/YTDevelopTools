//
//  YTKeyBoardTextField.m
//

#import "YTKeyBoardTextField.h"

#import "YTKeyBoardView.h"

@interface ObserverObject : NSObject

@property (nonatomic, strong) NSMutableArray *valueArray;

@end

@implementation ObserverObject

- (NSMutableArray *)valueArray {
    if (!_valueArray) {
        _valueArray = [[NSMutableArray alloc] init];
    }
    return _valueArray;
}

@end

@interface YTKeyBoardTextField ()

@property (nonatomic, strong) YTKeyBoardView *keyBoardView;
@property (nonatomic, strong) ObserverObject *observerObject;
@property (nonatomic, assign) NSInteger currentPosition;
@property (nonatomic, assign) BOOL isContainsPoint;

@end

@implementation YTKeyBoardTextField

- (void)awakeFromNib {
    [super awakeFromNib];

    [self configData];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configData];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configData];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"------%@  dealloc------", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (_observerObject != nil) {
        [_observerObject removeObserver:self forKeyPath:@"valueArray"];
    }
}

/// 这里要调用super方法 要不然删不了东西
- (void)deleteBackward {
    [super deleteBackward];

    NSLog(@"监听键盘删除按钮");
}

- (void)setIsShowPoint:(BOOL)isShowPoint {
    _isShowPoint = isShowPoint;

    self.keyBoardView.isShowPoint = isShowPoint;
}

- (void)setInputCount:(NSInteger)inputCount {
    _inputCount = inputCount;
}

- (void)cleanValue {
    [[self.observerObject mutableArrayValueForKeyPath:@"valueArray"] removeAllObjects];
    self.text = [self.observerObject.valueArray componentsJoinedByString:@""];
    [self changeValueKey];
}

/// 获取光标的位置
- (void)changeValueKey {
    self.currentPosition = [self offsetFromPosition:self.beginningOfDocument toPosition:self.selectedTextRange.start];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"valueArray"]) {
        if (_keyBoardDelegate && [_keyBoardDelegate respondsToSelector:@selector(keyBoardTextFieldInputing:InputValue:Complete:)]) {
            [_keyBoardDelegate keyBoardTextFieldInputing:self InputValue:[self.observerObject.valueArray componentsJoinedByString:@""] Complete:self.observerObject.valueArray.count == self.inputCount ? YES : NO];
        }
    }
}

- (void)getPosition:(NSInteger)integer withType:(YTKeyBoardHandleType)type {
    UITextPosition *beginning = self.beginningOfDocument;
    if (type != YTKeyBoardHandleType_Delete) {
        UITextPosition *now = [self positionFromPosition:beginning offset:integer + 1];
        UITextRange *range = [self textRangeFromPosition:now toPosition:now];
        self.selectedTextRange = range;
    } else {
        UITextPosition *now = [self positionFromPosition:beginning offset:integer - 1];
        UITextRange *range = [self textRangeFromPosition:now toPosition:now];
        self.selectedTextRange = range;
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}

- (void)configData {
    self.delegate = self;
    self.inputCount = MAXFLOAT;
    self.keyBoardView = [[YTKeyBoardView alloc] init];

    __weak __typeof(self) weakSelf = self;
    self.keyBoardView.keyBoardClickBlock = ^(NSString * _Nullable value, YTKeyBoardHandleType type) {
        if (type == YTKeyBoardHandleType_Number) {
            if (weakSelf.observerObject.valueArray.count >= weakSelf.inputCount) return;
            [[weakSelf.observerObject mutableArrayValueForKeyPath:@"valueArray"] insertObject:value atIndex:weakSelf.currentPosition];
            weakSelf.isContainsPoint = [weakSelf.observerObject.valueArray containsObject: @"."];
            weakSelf.text = [weakSelf.observerObject.valueArray componentsJoinedByString:@""];
            [weakSelf getPosition:weakSelf.currentPosition withType:type];
        } else if (type == YTKeyBoardHandleType_Point) {
            if (weakSelf.observerObject.valueArray.count >= weakSelf.inputCount) return;
            if (weakSelf.isContainsPoint == YES) return;
            [[weakSelf.observerObject mutableArrayValueForKeyPath:@"valueArray"] insertObject:value atIndex:weakSelf.currentPosition];
            weakSelf.isContainsPoint = [weakSelf.observerObject.valueArray containsObject: @"."];
            weakSelf.text = [weakSelf.observerObject.valueArray componentsJoinedByString:@""];
            [weakSelf getPosition:weakSelf.currentPosition withType:type];
        } else {
            if (weakSelf.observerObject.valueArray.count <= 0) return;
            if (weakSelf.currentPosition == 0) return;
            [[weakSelf.observerObject mutableArrayValueForKeyPath:@"valueArray"] removeObjectAtIndex:weakSelf.currentPosition - 1];
            weakSelf.isContainsPoint = [weakSelf.observerObject.valueArray containsObject: @"."];
            weakSelf.text = [weakSelf.observerObject.valueArray componentsJoinedByString:@""];
            [weakSelf getPosition:weakSelf.currentPosition withType:type];
        }
    };

    self.inputView = self.keyBoardView;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeValueKey) name:YTKeyBoardChangeNotification object:nil];
    [self.observerObject addObserver:self forKeyPath:@"valueArray" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}

- (ObserverObject *)observerObject {
    if (!_observerObject) {
        _observerObject = [[ObserverObject alloc] init];
    }
    return _observerObject;
}

#pragma mark - Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (_keyBoardDelegate && [_keyBoardDelegate respondsToSelector:@selector(keyBoardTextFieldShouldBeginEditing:)]) {
        return [_keyBoardDelegate keyBoardTextFieldShouldBeginEditing:textField];
    }

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (_keyBoardDelegate && [_keyBoardDelegate respondsToSelector:@selector(keyBoardTextFieldDidBeginEditing:)]) {
        [_keyBoardDelegate keyBoardTextFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (_keyBoardDelegate && [_keyBoardDelegate respondsToSelector:@selector(keyBoardTextFieldShouldEndEditing:)]) {
        return [_keyBoardDelegate keyBoardTextFieldShouldEndEditing:textField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_keyBoardDelegate && [_keyBoardDelegate respondsToSelector:@selector(keyBoardTextFieldDidEndEditing:)]) {
        [_keyBoardDelegate keyBoardTextFieldDidEndEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason API_AVAILABLE(ios(10.0)) {
    if (_keyBoardDelegate && [_keyBoardDelegate respondsToSelector:@selector(keyBoardTextFieldDidEndEditing:reason:)]) {
        [_keyBoardDelegate keyBoardTextFieldDidEndEditing:textField reason:reason];
    }
}

/*
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 没走这个代理方法 可能是自定义键盘的原因吧

    return YES;
}
 */

- (void)textFieldDidChangeSelection:(UITextField *)textField API_AVAILABLE(ios(13.0), tvos(13.0)) {
    if (_keyBoardDelegate && [_keyBoardDelegate respondsToSelector:@selector(keyBoardTextFieldDidChangeSelection:)]) {
        [_keyBoardDelegate keyBoardTextFieldDidChangeSelection:textField];
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    [self cleanValue];

    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (_keyBoardDelegate && [_keyBoardDelegate respondsToSelector:@selector(keyBoardTextFieldShouldReturn:)]) {
        return [_keyBoardDelegate keyBoardTextFieldShouldReturn:self];
    }

    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
