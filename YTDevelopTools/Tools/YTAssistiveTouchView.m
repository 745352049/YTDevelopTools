//
//  YTAssistiveTouchView.m
// 

#import "YTAssistiveTouchView.h"

#define YTAssistiveTouchStatusbarHeight() \
^(){\
if (@available(iOS 13.0, *)) {\
return [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;\
} else {\
return [[UIApplication sharedApplication] statusBarFrame].size.height;\
}\
}()

#define YTAssistiveTouch_Statusbar_Height YTAssistiveTouchStatusbarHeight()
#define YTAssistiveTouch_SafeArea_Height (YTAssistiveTouch_Statusbar_Height > 20.0 ? 34.0 : 0.0)

#define YTAssistiveTouch_UIScreenHeight [UIScreen mainScreen].bounds.size.height
#define YTAssistiveTouch_UIScreenWidth [UIScreen mainScreen].bounds.size.width

@interface YTAssistiveTouchView () <UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) YTStayLocation stayLocation;
@property (nonatomic, strong) UIBezierPath *maskPath;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;
/// 蒙板
@property (nonatomic, strong) UIView *coverView;
/// 滑动范围
@property (nonatomic, assign) CGRect rangeRect;

@end

@implementation YTAssistiveTouchView

+ (instancetype)shareInstance {
    static YTAssistiveTouchView *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[YTAssistiveTouchView alloc] initWithFrame:CGRectMake(0, YTAssistiveTouch_UIScreenHeight / 2.0, 60.0, 60.0)];
    });
    return tool;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.rangeRect.origin.x != 0 || self.rangeRect.origin.y != 0 || self.rangeRect.size.height != 0 || self.rangeRect.size.width != 0) {
        // 设置了rangeRect
    } else {
        // 没有设置rangeRect
        self.rangeRect = CGRectMake(0, YTAssistiveTouch_Statusbar_Height, YTAssistiveTouch_UIScreenWidth, YTAssistiveTouch_UIScreenHeight - YTAssistiveTouch_Statusbar_Height - YTAssistiveTouch_SafeArea_Height);
    }
}

- (void)configUI {
    self.backgroundColor = [UIColor redColor];
    self.userInteractionEnabled = YES;
    self.clipsToBounds = YES;
    
    [self addGestureRecognizer:self.tapGesture];
    [self addGestureRecognizer:self.panGesture];
    
    self.dragEnable = YES;
    self.isKeepBounds = YES;
    self.isShowCoverView = YES;
    self.isAllowLandscapeMode = NO;
    self.isLandscapeMode = NO;
    self.stayLocation = YTStayLocationLeft;
}

- (void)orientationDidChangeAction:(NSNotification *)notification {
    if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait || [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown) {
        if (self.isLandscapeMode == YES) {
            self.isLandscapeMode = NO;
            if (self.orientationDidChangeBlock) {
                self.orientationDidChangeBlock(self, YTStayLocationLeft);
            }
        }
    } else if ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft || [[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight) {
        if (self.isLandscapeMode == NO) {
            self.isLandscapeMode = YES;
            self.orientationDidChangeBlock(self, YTStayLocationBottom);
        }
    }
}

- (void)addAssistiveTouchViewSubView:(void(^)(YTAssistiveTouchView *assistiveTouchView))addBlock {
    addBlock(self);
}

- (void)setAssistiveTouchViewProperty:(void(^)(YTAssistiveTouchView *assistiveTouchView))setBlock {
    setBlock(self);
}

- (void)addMaskLayerWith:(YTMaskLayerLocation)location {
    if (location == YTMaskLayerLocationAll) {
        self.maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(self.frame.size.width / 2.0, self.frame.size.width / 2.0)];
    } else if (location == YTMaskLayerLocationLeft) {
        self.maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(self.frame.size.width / 2.0, self.frame.size.width / 2.0)];
    } else if (location == YTMaskLayerLocationRight) {
        self.maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(self.frame.size.width / 2.0, self.frame.size.width / 2.0)];
    } else if (location == YTMaskLayerLocationTop) {
        self.maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(self.frame.size.width / 2.0, self.frame.size.width / 2.0)];
    } else if (location == YTMaskLayerLocationBottom) {
        self.maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(self.frame.size.width / 2.0, self.frame.size.width / 2.0)];
    }
    self.maskLayer.frame = self.bounds;
    self.maskLayer.path = self.maskPath.CGPath;
    self.layer.mask = self.maskLayer;
}

- (void)setCoverViewProperty:(void(^)(UIView *coverView))setBlock {
    setBlock(self.coverView);
}

#pragma mark - 视图的显示与隐藏

- (void)showAssistiveTouchView {
    if (!self.superview) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
        if (self.isShowAssistiveTouchViewBlock) {
            self.isShowAssistiveTouchViewBlock(self, YES);
        }
    }
}

- (void)removeAssistiveTouchView {
    if (self.superview) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self removeFromSuperview];
        if (self.isShowAssistiveTouchViewBlock) {
            self.isShowAssistiveTouchViewBlock(self, NO);
        }
    }
}

- (void)hiddenAssistiveTouchView {
    if (self.superview) {
        self.hidden = YES;
        if (self.isHiddenAssistiveTouchViewBlock) {
            self.isHiddenAssistiveTouchViewBlock(self, YES);
        }
    }
}

- (void)notHiddenAssistiveTouchView {
    if (self.superview) {
        self.hidden = NO;
        if (self.isHiddenAssistiveTouchViewBlock) {
            self.isHiddenAssistiveTouchViewBlock(self, NO);
        }
    }
}

#pragma mark - coverView 的显示与隐藏

- (void)showCoverView {
    if (!self.coverView.superview) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.coverView];
        if (self.isShowCoverViewBlock) {
            self.isShowCoverViewBlock(self.coverView, YES);
        }
        if (self.addCoverViewSubViewBlock) {
            self.addCoverViewSubViewBlock(self.coverView, self.frame, self.stayLocation);
        }
        [self hiddenAssistiveTouchView];
    }
}

- (void)removeCoverView {
    if (self.coverView.superview) {
        [self.coverView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.coverView removeFromSuperview];
        if (self.isShowCoverViewBlock) {
            self.isShowCoverViewBlock(self.coverView, NO);
        }
    }
}

#pragma mark - coverView 点击手势

- (void)coverViewTapGestureAction:(UITapGestureRecognizer *)tap {
    [self notHiddenAssistiveTouchView];
    [self removeCoverView];
}

#pragma mark - 点击手势

- (void)tapGestureAction:(UITapGestureRecognizer *)tap {
    if (self.tapGestureBlock) {
        self.tapGestureBlock(self, self.stayLocation, self.rangeRect);
    }
    if (!self.coverView.superview && self.isShowCoverView == YES && self.isKeepBounds == YES) {
        [self showCoverView];
    }
}

#pragma mark - 滑动手势

- (void)panGestureAction:(UIPanGestureRecognizer *)pan {
    if(self.dragEnable == NO) return;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        { // 开始拖动
            if (self.panGestureStateBlock) {
                self.panGestureStateBlock(self, YTPanGestureStatebegin);
            }
            
            // 注意完成移动后，将translation重置为0十分重要。否则translation每次都会叠加
            [pan setTranslation:CGPointZero inView:self];
            // 保存触摸起始点位置
            self.startPoint = [pan translationInView:self];
            break;
        }
        case UIGestureRecognizerStateChanged:
        { // 拖动中
            // 计算位移 = 当前位置 - 起始位置
            if (self.panGestureStateBlock) {
                self.panGestureStateBlock(self, YTPanGestureStateDuring);
            }
            CGPoint point = [pan translationInView:self];
            float dx;
            float dy;
            switch (self.dragDirection) {
                case YTDragDirectionAny:
                    dx = point.x - self.startPoint.x;
                    dy = point.y - self.startPoint.y;
                    break;
                case YTDragDirectionHorizontal:
                    dx = point.x - self.startPoint.x;
                    dy = 0;
                    break;
                case YTDragDirectionVertical:
                    dx = 0;
                    dy = point.y - self.startPoint.y;
                    break;
                default:
                    dx = point.x - self.startPoint.x;
                    dy = point.y - self.startPoint.y;
                    break;
            }
            
            // 计算移动后的view中心点
            CGPoint newCenter = CGPointMake(self.center.x + dx, self.center.y + dy);
            // 移动view
            self.center = newCenter;
            // 注意完成上述移动后，将translation重置为0十分重要。否则translation每次都会叠加
            [pan setTranslation:CGPointZero inView:self];
            break;
        }
        case UIGestureRecognizerStateEnded:
        { // 拖动结束
            [pan setTranslation:CGPointZero inView:self];
            [self keepBounds];
            if (self.panGestureStateBlock) {
                self.panGestureStateBlock(self, YTPanGestureStateEnd);
            }
            break;
        }
        case UIGestureRecognizerStateCancelled:
        {
            [pan setTranslation:CGPointZero inView:self];
            [self keepBounds];
            if (self.panGestureStateBlock) {
                self.panGestureStateBlock(self, YTPanGestureStateCancelled);
            }
        }
            break;
        default:
            break;
    }
}

- (void)keepBounds {
    // 中心点判断
    float centerX = self.rangeRect.origin.x + (self.rangeRect.size.width - self.frame.size.width)/2.0;
    CGRect rect = self.frame;
    if (self.isKeepBounds == NO) { // 没有黏贴边界的效果
        if (self.frame.origin.x < self.rangeRect.origin.x) {
            CGContextRef context = UIGraphicsGetCurrentContext();
            [UIView beginAnimations:@"keepLeftMove" context:context];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:keepAnimationDuration];
            rect.origin.x = self.rangeRect.origin.x;
            self.frame = rect;
            [UIView commitAnimations];
        } else if (self.rangeRect.origin.x + self.rangeRect.size.width < self.frame.origin.x + self.frame.size.width) {
            CGContextRef context = UIGraphicsGetCurrentContext();
            [UIView beginAnimations:@"keepRightMove" context:context];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:keepAnimationDuration];
            rect.origin.x = self.rangeRect.origin.x + self.rangeRect.size.width - self.frame.size.width;
            self.frame = rect;
            [UIView commitAnimations];
        }
    } else if (self.isKeepBounds == YES) { // 自动粘边
        if (self.isLandscapeMode == YES) {
            float centerY = self.rangeRect.origin.y + (self.rangeRect.size.height - self.frame.size.height)/2.0;
            if (self.frame.origin.y < centerY) {
                CGContextRef context = UIGraphicsGetCurrentContext();
                [UIView beginAnimations:@"keepTopMove" context:context];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView setAnimationDuration:keepAnimationDuration];
                rect.origin.y = self.rangeRect.origin.y;
                self.frame = rect;
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(topMoveAnimationStop)];
                [UIView commitAnimations];
            } else {
                CGContextRef context = UIGraphicsGetCurrentContext();
                [UIView beginAnimations:@"keepBottomMove" context:context];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView setAnimationDuration:keepAnimationDuration];
                rect.origin.y = self.rangeRect.origin.y + self.rangeRect.size.height - self.frame.size.height;
                self.frame = rect;
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(bottomMoveAnimationStop)];
                [UIView commitAnimations];
            }
            
            if (self.frame.origin.x < self.rangeRect.origin.x) {
                CGContextRef context = UIGraphicsGetCurrentContext();
                [UIView beginAnimations:@"rangeTopMove" context:context];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView setAnimationDuration:keepAnimationDuration];
                rect.origin.x = self.rangeRect.origin.x;
                self.frame = rect;
                [UIView commitAnimations];
            } else if (self.rangeRect.origin.x + self.rangeRect.size.width < self.frame.origin.x + self.frame.size.width) {
                CGContextRef context = UIGraphicsGetCurrentContext();
                [UIView beginAnimations:@"rangeBottomMove" context:context];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView setAnimationDuration:keepAnimationDuration];
                rect.origin.x = self.rangeRect.origin.x + self.rangeRect.size.width - self.frame.size.width;
                self.frame = rect;
                [UIView commitAnimations];
            }
        } else {
            if (self.frame.origin.x < centerX) {
                CGContextRef context = UIGraphicsGetCurrentContext();
                [UIView beginAnimations:@"keepLeftMove" context:context];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView setAnimationDuration:keepAnimationDuration];
                rect.origin.x = self.rangeRect.origin.x;
                self.frame = rect;
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(leftMoveAnimationStop)];
                [UIView commitAnimations];
            } else {
                CGContextRef context = UIGraphicsGetCurrentContext();
                [UIView beginAnimations:@"keepRightMove" context:context];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView setAnimationDuration:keepAnimationDuration];
                rect.origin.x = self.rangeRect.origin.x + self.rangeRect.size.width - self.frame.size.width;
                self.frame = rect;
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(rightMoveAnimationStop)];
                [UIView commitAnimations];
            }
            
            if (self.frame.origin.y < self.rangeRect.origin.y) {
                CGContextRef context = UIGraphicsGetCurrentContext();
                [UIView beginAnimations:@"rangeTopMove" context:context];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView setAnimationDuration:keepAnimationDuration];
                rect.origin.y = self.rangeRect.origin.y;
                self.frame = rect;
                [UIView commitAnimations];
            } else if (self.rangeRect.origin.y + self.rangeRect.size.height < self.frame.origin.y + self.frame.size.height) {
                CGContextRef context = UIGraphicsGetCurrentContext();
                [UIView beginAnimations:@"rangeBottomMove" context:context];
                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                [UIView setAnimationDuration:keepAnimationDuration];
                rect.origin.y = self.rangeRect.origin.y + self.rangeRect.size.height - self.frame.size.height;
                self.frame = rect;
                [UIView commitAnimations];
            }
        }
    }
}

- (void)leftMoveAnimationStop {
    self.stayLocation = YTStayLocationLeft;
    if (self.keepBoundsAnimationsEndBlock) {
        self.keepBoundsAnimationsEndBlock(self, self.stayLocation);
    }
}

- (void)rightMoveAnimationStop {
    self.stayLocation = YTStayLocationRight;
    if (self.keepBoundsAnimationsEndBlock) {
        self.keepBoundsAnimationsEndBlock(self, self.stayLocation);
    }
}

- (void)topMoveAnimationStop {
    self.stayLocation = YTStayLocationTop;
    if (self.keepBoundsAnimationsEndBlock) {
        self.keepBoundsAnimationsEndBlock(self, self.stayLocation);
    }
}

- (void)bottomMoveAnimationStop {
    self.stayLocation = YTStayLocationBottom;
    if (self.keepBoundsAnimationsEndBlock) {
        self.keepBoundsAnimationsEndBlock(self, self.stayLocation);
    }
}

#pragma mark - Setter

- (void)setDragEnable:(BOOL)dragEnable {
    _dragEnable = dragEnable;
}

- (void)setIsKeepBounds:(BOOL)isKeepBounds {
    _isKeepBounds = isKeepBounds;
}

- (void)setRangeRect:(CGRect)rangeRect {
    _rangeRect = rangeRect;
}

- (void)setIsShowCoverView:(BOOL)isShowCoverView {
    _isShowCoverView = isShowCoverView;
}

- (void)setStayLocation:(YTStayLocation)stayLocation {
    _stayLocation = stayLocation;
}

- (void)setIsAllowLandscapeMode:(BOOL)isAllowLandscapeMode {
    _isAllowLandscapeMode = isAllowLandscapeMode;
    
    if (isAllowLandscapeMode == YES) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChangeAction:) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
}

- (void)setIsLandscapeMode:(BOOL)isLandscapeMode {
    _isLandscapeMode = isLandscapeMode;
    
    self.coverView.frame = [UIScreen mainScreen].bounds;
    if (isLandscapeMode == YES) {
        self.stayLocation = YTStayLocationBottom;
        self.rangeRect = CGRectMake(0, 0, YTAssistiveTouch_UIScreenWidth, YTAssistiveTouch_UIScreenHeight);
        self.frame = CGRectMake((YTAssistiveTouch_UIScreenWidth - self.frame.size.width) / 2.0, YTAssistiveTouch_UIScreenHeight - self.frame.size.height, self.frame.size.width, self.frame.size.height);
        [self addMaskLayerWith:YTMaskLayerLocationTop];
    } else {
        self.stayLocation = YTStayLocationLeft;
        self.rangeRect = CGRectMake(0, YTAssistiveTouch_Statusbar_Height, YTAssistiveTouch_UIScreenWidth, YTAssistiveTouch_UIScreenHeight - YTAssistiveTouch_Statusbar_Height - YTAssistiveTouch_SafeArea_Height);
        self.frame = CGRectMake(0, (YTAssistiveTouch_UIScreenHeight - self.frame.size.height) / 2.0, self.frame.size.width, self.frame.size.height);
        [self addMaskLayerWith:YTMaskLayerLocationRight];
    }
}

#pragma mark - Lazy

- (UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        _tapGesture.numberOfTouchesRequired = 1;
    }
    return _tapGesture;
}

- (UIPanGestureRecognizer *)panGesture {
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        _panGesture.minimumNumberOfTouches = 1;
        _panGesture.maximumNumberOfTouches = 1;
        _panGesture.delegate = self;
    }
    return _panGesture;
}

- (UIBezierPath *)maskPath {
    if (!_maskPath) {
        _maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(self.frame.size.width / 2.0, self.frame.size.width / 2.0)];
    }
    return _maskPath;
}

- (CAShapeLayer *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = [[CAShapeLayer alloc] init];
        _maskLayer.frame = self.bounds;
    }
    return _maskLayer;
}

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _coverView.backgroundColor = [UIColor colorWithRed:236.0/255.0 green:237.0/255.0 blue:238.0/255.0 alpha:0.9];
        _coverView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewTapGestureAction:)];
        tapGesture.numberOfTouchesRequired = 1;
        [_coverView addGestureRecognizer:tapGesture];
    }
    return _coverView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
