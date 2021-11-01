//
//  YTRotatingView.m
//

#import "YTRotatingView.h"

@interface YTRotatingView () <CAAnimationDelegate> {
    // 旋转角度
    float _angle;
    // 旋转周期
    CFTimeInterval _duration;
    // 旋转次数
    float _repeatCount;
    // 是否旋转
    BOOL _isRotating;
    // 是否暂停
    BOOL _isPauseRotating;
    // 是否停止
    BOOL _isStopRotating;
}

@end

@implementation YTRotatingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configData];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configData];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configData];
}

- (void)configData {
    _angle = M_PI*2.0;
    _duration = 5.0;
    _repeatCount = MAXFLOAT;
    _isRotating = NO;
    _isPauseRotating = NO;
    _isStopRotating = YES;
    self.isResetWithResume = NO;
}

- (BOOL)isRotateState {
    return _isRotating;
}

- (BOOL)isPauseState {
    return _isPauseRotating;
}

- (BOOL)isStopState {
    return _isStopRotating;
}

- (void)startRotating {
    [self startRotatingWithAngle:_angle Duration:_duration RepeatCount:_repeatCount];
}

- (void)startRotatingWithAngle:(float)angle Duration:(CFTimeInterval)duration RepeatCount:(float)repeatCount {
    _angle = angle;
    _duration = duration;
    _repeatCount = repeatCount;
    
    if (_isRotating == NO && _isPauseRotating == NO && _isStopRotating == YES) {
        _isRotating = YES;
        _isPauseRotating = NO;
        _isStopRotating = NO;
        
        CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        rotateAnimation.fromValue = [NSNumber numberWithFloat:0.0];
        rotateAnimation.toValue = [NSNumber numberWithFloat:angle];
        rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        rotateAnimation.cumulative = NO;
        rotateAnimation.removedOnCompletion = YES;
        rotateAnimation.fillMode = kCAFillModeForwards;
        rotateAnimation.duration = duration;
        rotateAnimation.repeatCount = repeatCount;
        rotateAnimation.delegate = self;
        [rotateAnimation setValue:@"YTRotatingViewValue" forKey:@"YTRotatingViewKey"];
        [self.layer addAnimation:rotateAnimation forKey:@"YTRotatingViewLayer"];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag == NO) return;
    if ([[anim valueForKey:@"YTRotatingViewKey"] isEqualToString:@"YTRotatingViewValue"]) {
        if (self.rotatingCompleteBlock) {
            self.rotatingCompleteBlock(self);
        }
    }
}

- (void)pauseRotating {
    if (_isRotating == YES && _isPauseRotating == NO && _isStopRotating == NO) {
        _isRotating = NO;
        _isPauseRotating = YES;
        _isStopRotating = NO;
        
        CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        // 停止旋转
        self.layer.speed = 0.0;
        // 保存时间，恢复旋转需要用到
        self.layer.timeOffset = pausedTime;
    }
}

- (void)resumeRotating {
    if (_isRotating == NO && _isPauseRotating == YES && _isStopRotating == NO) {
        if (self.isResetWithResume == YES) {
            self.layer.speed = 1.0;
            self.layer.timeOffset = 0.0;
            self.layer.beginTime = 0.0;
            
            [self.layer removeAnimationForKey:@"YTRotatingViewLayer"];
            
            _isRotating = NO;
            _isPauseRotating = NO;
            _isStopRotating = YES;
            
            [self startRotating];
        } else {
            CFTimeInterval pausedTime = self.layer.timeOffset;
            // 开始旋转
            self.layer.speed = 1.0;
            self.layer.timeOffset = 0.0;
            self.layer.beginTime = 0.0;
            CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
            // 从暂停的时间点开始旋转
            self.layer.beginTime = timeSincePause;
            
            _isRotating = YES;
            _isPauseRotating = NO;
            _isStopRotating = NO;
        }
    }
}

- (void)stopRotating {
    if (_isStopRotating == YES) return;
    
    self.layer.speed = 1.0;
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    
    [self.layer removeAnimationForKey:@"YTRotatingViewLayer"];
    
    _isRotating = NO;
    _isPauseRotating = NO;
    _isStopRotating = YES;
}

- (void)setIsResetWithResume:(BOOL)isResetWithResume {
    _isResetWithResume = isResetWithResume;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
