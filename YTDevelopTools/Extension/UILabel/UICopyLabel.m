//
//  UICopyLabel.m
//  

#import "UICopyLabel.h"

@implementation UICopyLabel

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initCopyAction];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initCopyAction];
    }
    return self;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(LabelPasteboard)) {
        return YES;
    }
    return NO;
}

- (void)copy:(id)sender {
    [self LabelPasteboard];
}

- (void)initCopyAction {
    [self attachLongPressHandler];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIMenuControllerWillHideMenuNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        //self.backgroundColor = [UIColor whiteColor];
    }];
}

- (void)attachLongPressHandler {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressAction:)];
    longPress.minimumPressDuration = 1.0;
    [self addGestureRecognizer:longPress];
}

- (void)handleLongPressAction:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        //self.backgroundColor = [UIColor linkColor];
        UIMenuItem *item = [[UIMenuItem alloc]initWithTitle:@"复制" action:@selector(LabelPasteboard)];
        [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
        [UIMenuController sharedMenuController].menuItems = @[item];
        [UIMenuController sharedMenuController].menuVisible = YES;
    }
}

- (void)LabelPasteboard {
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    pboard.string = self.text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
