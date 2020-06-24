//
//  YTKeyBoardView.m
//

#import "YTKeyBoardView.h"

#define YTKeyBoard_StatusbarHeight() \
^(){\
if (@available(iOS 13.0, *)) {\
return [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;\
} else {\
return [[UIApplication sharedApplication] statusBarFrame].size.height;\
}\
}()

#define YTKeyBoard_Statusbar_Height YTKeyBoard_StatusbarHeight()
#define YTKeyBoard_SafeArea_Height (YTKeyBoard_Statusbar_Height > 20.0 ? 34.0 : 0.0)
#define YTKeyBoardWidth [UIScreen mainScreen].bounds.size.width
#define YTKeyBoardHeight (220.0 + YTKeyBoard_SafeArea_Height)
#define YTKeyBoardItem_Width YTKeyBoardWidth/3.0
#define YTKeyBoardItem_Height 55.0

@interface YTKeyBoardView ()

@end

@implementation YTKeyBoardView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-YTKeyBoardHeight, YTKeyBoardWidth, YTKeyBoardHeight);
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1.0];

        [self createKeyBoardUIWithPoint:NO];
    }
    return self;
}

- (void)setIsShowPoint:(BOOL)isShowPoint {
    _isShowPoint = isShowPoint;

    [self isShowPointWithPointButton:[self viewWithTag:809] Show:isShowPoint];
    [self isShowPointWithDeleteButton:[self viewWithTag:811] Show:isShowPoint];
}

- (void)isShowPointWithPointButton:(UIButton *)button Show:(BOOL)show {
    if (show == YES) {
        [button setTitle:@"·" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:26]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(pointClickAction) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [button setTitle:@"" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor clearColor]];
        [button removeTarget:self action:@selector(pointClickAction) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)isShowPointWithDeleteButton:(UIButton *)button Show:(BOOL)show {
    if (show == YES) {
        [button setBackgroundColor:[UIColor whiteColor]];
    } else {
        [button setBackgroundColor:[UIColor clearColor]];
    }
}

- (void)keyValueClickAction:(UIButton *)sender {
    // 发送一个通知，获取当前的光标位置
    [[NSNotificationCenter defaultCenter] postNotificationName:YTKeyBoardChangeNotification object:nil];
    if (_keyBoardClickBlock) {
        _keyBoardClickBlock(sender.titleLabel.text, YTKeyBoardHandleType_Number);
    }
}

- (void)pointClickAction {
    // 发送一个通知，获取当前的光标位置
    [[NSNotificationCenter defaultCenter] postNotificationName:YTKeyBoardChangeNotification object:nil];
    if (_keyBoardClickBlock) {
        _keyBoardClickBlock(@".", YTKeyBoardHandleType_Point);
    }
}

- (void)deleteClickAction {
    // 发送一个通知，获取当前的光标位置
    [[NSNotificationCenter defaultCenter] postNotificationName:YTKeyBoardChangeNotification object:nil];
    if (_keyBoardClickBlock) {
        _keyBoardClickBlock(nil, YTKeyBoardHandleType_Delete);
    }
}

- (void)createKeyBoardUIWithPoint:(BOOL)show {
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
            [self isShowPointWithPointButton:keyButton Show:show];

            [self addSubview:keyButton];
            continue;
        }

        if (i == 11) {
            [self isShowPointWithDeleteButton:keyButton Show:show];
            [keyButton setImage:[UIImage imageNamed:[[NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"YTDevelopTools" withExtension:@"bundle"]] pathForResource:@"YTKeyBoard_D@2x" ofType:@"png"]] forState:UIControlStateNormal];
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
