//
//  YTBezierDrawView.m
//  

#import "YTBezierDrawView.h"

@interface YTBezierDrawView ()

@end

@implementation YTBezierDrawView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self config];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

#pragma mark - Public

- (void)clear {
    if (self.pathsArray.count <= 0) return;
    [self.pathsArray removeAllObjects];
    self.lineColor = [UIColor blackColor];
    [self setNeedsDisplay];
}

- (void)undo {
    if (self.pathsArray.count <= 0) return;
    [self.pathsArray removeLastObject];
    [self setNeedsDisplay];
}

- (void)eraser {
    if (self.pathsArray.count <= 0) return;
    self.lineColor = self.backgroundColor;
    [self setNeedsDisplay];
}

- (UIImage *)getDrawImage {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - Private

- (void)config {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureAction:)];
    panGesture.minimumNumberOfTouches = 1;
    panGesture.maximumNumberOfTouches = 1;
    [self addGestureRecognizer:panGesture];
    
    self.backgroundColor = [UIColor whiteColor];
    self.lineColor = [UIColor blackColor];
    self.lineWidth = 10.0;
}

- (void)panGestureAction:(UIPanGestureRecognizer *)pan {
    /// 获取当前点
    CGPoint currentPoint = [pan locationInView:self];
    if (currentPoint.x < 0 || currentPoint.x > self.frame.size.width) return;
    if (currentPoint.y < 0 || currentPoint.y > self.frame.size.height) return;
    
    if (self.drawCustomPathPointBlock) {
        self.drawCustomPathPointBlock(self, currentPoint, pan);
        return;
    }
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.path = [[YTBezierDrawPath alloc] init];
            self.path.lineWidth = self.lineWidth;
            self.path.pathColor = self.lineColor;
            self.path.lineCapStyle = kCGLineCapRound;
            self.path.lineJoinStyle = kCGLineJoinRound;
            [self.path moveToPoint:currentPoint];
            [self.pathsArray addObject:self.path];
        }
            break;
        default:
            break;
    }
    [self.path addLineToPoint:currentPoint];
    [self setNeedsDisplay];
    if (self.drawCurrentPointBlock) {
        self.drawCurrentPointBlock(currentPoint);
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self.pathsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YTBezierDrawPath *path = obj;
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)path;
            [image drawInRect:rect];
        } else {
            [path.pathColor set];
            [path stroke];
        }
    }];
}

#pragma mark - Setter

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    
    [self.pathsArray addObject:image];
    [self setNeedsDisplay];
}

#pragma mark - Lazy

- (NSMutableArray *)pathsArray {
    if (!_pathsArray) {
        _pathsArray = [[NSMutableArray alloc] init];
    }
    return _pathsArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
