//
//  YTSafeKeyBoardView.m
//

#import "YTSafeKeyBoardView.h"

#define YTKeyBoard_SafeAreaHeight() \
^(){\
if (@available(iOS 13.0, *)) {\
return [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;\
} else {\
return [[UIApplication sharedApplication] statusBarFrame].size.height;\
}\
}()

#define YTKeyBoardWidth [UIScreen mainScreen].bounds.size.width
#define YTKeyBoardHeight (220.0 + YTKeyBoard_SafeAreaHeight())
#define YTKeyBoardItem_Width YTKeyBoardWidth/3.0
#define YTKeyBoardItem_Height 55.0

@interface YTSafeKeyBoardView ()

@property (nonatomic, assign) BOOL isShowPoint;

@end

@implementation YTSafeKeyBoardView

- (instancetype)initWithShowPonit:(BOOL)show {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-YTKeyBoardHeight, YTKeyBoardWidth, YTKeyBoardHeight);
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];

        self.isShowPoint = show;

        [self createKeyBoardUI];
    }
    return self;
}

- (void)setIsShowPoint:(BOOL)isShowPoint {
    _isShowPoint = isShowPoint;
}

- (void)keyValueClickAction:(UIButton *)sender {
    if (_keyBoardClickBlock) {
        _keyBoardClickBlock(sender.titleLabel.text, YTKeyBoardHandleType_Number);
    }
}

- (void)pointClickAction {
    if (_keyBoardClickBlock) {
        _keyBoardClickBlock(nil, YTKeyBoardHandleType_Point);
    }
}

- (void)deleteClickAction {
    if (_keyBoardClickBlock) {
        _keyBoardClickBlock(nil, YTKeyBoardHandleType_Delete);
    }
}

- (void)createKeyBoardUI {
    NSArray *array = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"·",@"0",@""];

    float kx;
    float ky;

    for (int i = 0; i < array.count; i ++) {

        kx = i % 3 * YTKeyBoardItem_Width;
        ky = i / 3 * YTKeyBoardItem_Height;

        UIButton *keyButton= [UIButton buttonWithType:UIButtonTypeCustom];
        [keyButton setTag:(800 + i)];
        [keyButton setFrame:CGRectMake(kx, ky, YTKeyBoardItem_Width, YTKeyBoardItem_Height)];
        keyButton.layer.borderWidth = 0.25;
        keyButton.layer.borderColor = [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:0.8].CGColor;
        keyButton.enabled = YES;

        if (i == 9) {
            if (self.isShowPoint == YES) {
                [keyButton setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
                [keyButton.titleLabel setFont:[UIFont systemFontOfSize:26]];
                [keyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [keyButton setBackgroundColor:[UIColor whiteColor]];
                [keyButton addTarget:self action:@selector(pointClickAction) forControlEvents:UIControlEventTouchUpInside];
            } else {
                [keyButton setBackgroundColor:[UIColor clearColor]];
            }

            [self addSubview:keyButton];
            continue;
        }

        if (i == 11) {
            if (self.isShowPoint == YES) {
                [keyButton setBackgroundColor:[UIColor whiteColor]];
            }
            [keyButton setImage:[UIImage imageNamed:[[NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"YTDevelopTools" withExtension:@"bundle"]] pathForResource:@"YTSafeKeyBoard_D@2x" ofType:@"png"]] forState:UIControlStateNormal];
            [keyButton addTarget:self action:@selector(deleteClickAction) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:keyButton];
            continue;
        }

        [keyButton setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [keyButton.titleLabel setFont:[UIFont systemFontOfSize:26]];
        [keyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [keyButton setBackgroundColor:[UIColor whiteColor]];
        [keyButton addTarget:self action:@selector(keyValueClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:keyButton];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
