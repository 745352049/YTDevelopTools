//
//  YTPlaceholderTextView.m
//  

#import "YTPlaceholderTextView.h"

@interface YTPlaceholderTextView ()

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation YTPlaceholderTextView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    [self configUI];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];

    self.placeholderLabel.font = font;
}

- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
    [super setTextContainerInset:textContainerInset];
    // 设置了内边距
    [self refreshPlaceholderFrame];
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    [super setContentInset:contentInset];

    [self refreshPlaceholderFrame];
}

- (void)setText:(NSString *)text {
    [super setText:text];

    [self handleData];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;

    self.placeholderLabel.text = placeholder;
    [self.placeholderLabel sizeToFit];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;

    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;

    [self handleData];
}

- (void)placeholderTextViewdidChange:(NSNotification *)notificat {
    [self handleData];
}

- (void)handleData {
    if ([self.text length] > 0) {
        [self.placeholderLabel setHidden:YES];
    } else {
        [self.placeholderLabel setHidden:NO];
    }
    if ([self.text length] > self.maxCount && self.maxCount != 0 && self.markedTextRange == nil) {
        self.text = [self.text substringToIndex:self.maxCount];
    }
    if (_didChangeText) {
        _didChangeText(self);
    }
}

- (void)didChangeText:(didChangeText)block {
    if (_didChangeText) {
        _didChangeText = block;
    }
}

- (void)layoutSubviews {
    [self refreshPlaceholderFrame];
}

- (void)configUI {
    self.maxCount = 0;

    [self addSubview:self.placeholderLabel];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(placeholderTextViewdidChange:) name:UITextViewTextDidChangeNotification object:self];
}

- (void)refreshPlaceholderFrame {
    self.placeholderLabel.frame = CGRectMake(self.textContainerInset.left + 4.8, self.textContainerInset.top, self.frame.size.width - self.textContainerInset.left - self.textContainerInset.right - self.contentInset.left - self.contentInset.right - 4.8, self.frame.size.height - self.textContainerInset.top - self.textContainerInset.bottom - self.contentInset.top - self.contentInset.bottom);
    [self.placeholderLabel sizeToFit];
}

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _placeholderLabel.textColor = [UIColor lightGrayColor];
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.font = [self font];
        _placeholderLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _placeholderLabel;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
