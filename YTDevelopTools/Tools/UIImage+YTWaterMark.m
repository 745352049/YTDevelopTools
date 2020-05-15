//
//  UIImage+YTWaterMark.m
//  

#import "UIImage+YTWaterMark.h"

static CGFloat YTMARK_HORIZONTAL_SPACE = 40.0;
static CGFloat YTMARK_VERTICAL_SPACE = 80.0;
static CGFloat YTMARK_CG_TRANSFORM_ROTATING = - M_PI_2 / 2;
static CGFloat YTMARK_TEXT_FONT = 16.0;
static CGFloat YTMARK_LOCATION_SPACE = 16.0;

@implementation UIImage (YTWaterMark)

- (UIImage *)getWaterMarkImageWithText:(NSString *)text Attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs SpaceSize:(CGSize)spaceSize TransformRotation:(CGFloat)transformRotation {
    CGFloat img_w = self.size.width;
    CGFloat img_h = self.size.height;
    // 开启上下文 (绘制的范围 图层是否完全透明 缩放比例->0时自适应)
    //UIGraphicsBeginImageContext(CGSizeMake(img_w, img_h));
    UIGraphicsBeginImageContextWithOptions(self.size, YES, 0.0);
    [self drawInRect:CGRectMake(0, 0, img_w, img_h)];

    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text attributes:attrs];

    CGFloat str_w = attrStr.size.width;
    CGFloat str_h = attrStr.size.height;

    CGContextRef context = UIGraphicsGetCurrentContext();
    // 将绘制原点（0，0）调整到源image的中心
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(img_w/2, img_h/2));
    // 以绘制原点为中心旋转
    CGContextConcatCTM(context, CGAffineTransformMakeRotation(transformRotation));
    // 将绘制原点恢复初始值，保证context中心点和image中心点处在一个点(当前context已经发生旋转，绘制出的任何layer都是倾斜的)
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-img_w/2, -img_h/2));
    // sqrtLength：原始image对角线length。在水印旋转矩阵中只要矩阵的宽高是原始image的对角线长度，无论旋转多少度都不会有空白。
    CGFloat sqrtLength = sqrt(img_w * img_w + img_h * img_h);
    // 计算需要绘制的列数和行数
    int count_Hor = sqrtLength / (str_w + spaceSize.width) + 1;
    int count_Ver = sqrtLength / (str_h + spaceSize.height) + 1;
    // 此处计算出需要绘制水印文字的起始点，由于水印区域要大于图片区域所以起点在原有基础上移
    CGFloat orignX = -(sqrtLength - img_w)/2.0;
    CGFloat orignY = -(sqrtLength - img_h)/2.0;
    // 在每列绘制时X坐标叠加
    CGFloat overlayOrignX = orignX;
    // 在每行绘制时Y坐标叠加
    CGFloat overlayOrignY = orignY;
    for (int i = 0; i < count_Hor * count_Ver; i++) {
        [text drawInRect:CGRectMake(overlayOrignX, overlayOrignY, str_w, str_h) withAttributes:attrs];
        if (i % count_Hor == 0 && i != 0) {
            overlayOrignX = orignX;
            overlayOrignY += (str_h + spaceSize.height);
        }else{
            overlayOrignX += (str_w + spaceSize.width);
        }
    }
    
    CGContextSaveGState(context);
    CGContextRestoreGState(context);

    UIImage *lastImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return lastImage;
}

- (UIImage *)getWaterMarkImageWithText:(NSString *)text {
    return [self getWaterMarkImageWithText:text Attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:YTMARK_TEXT_FONT], NSForegroundColorAttributeName: [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1]} SpaceSize:CGSizeMake(YTMARK_HORIZONTAL_SPACE, YTMARK_VERTICAL_SPACE) TransformRotation:YTMARK_CG_TRANSFORM_ROTATING];
}

- (UIImage *)getLocationWaterMarkImageWithText:(NSString *)text Attributes:(nullable NSDictionary<NSAttributedStringKey, id> *)attrs SpaceSize:(CGSize)spaceSize Location:(YTWaterMarkLocation)location {

    CGFloat img_w = self.size.width;
    CGFloat img_h = self.size.height;

    UIGraphicsBeginImageContextWithOptions(self.size, YES, 0.0);
    [self drawInRect:CGRectMake(0, 0, img_w, img_h)];

    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text attributes:attrs];

    CGFloat str_w = attrStr.size.width;
    CGFloat str_h = attrStr.size.height;

    CGContextRef context = UIGraphicsGetCurrentContext();
    switch (location) {
        case YTWaterMarkLocation_Center:
        {
            [text drawInRect:CGRectMake((img_w-str_w)/2.0, (img_h-str_h)/2.0, str_w, str_h) withAttributes:attrs];
        }
            break;
        case YTWaterMarkLocation_LeftTop:
        {
            [text drawInRect:CGRectMake(spaceSize.width, spaceSize.height, str_w, str_h) withAttributes:attrs];
        }
            break;
        case YTWaterMarkLocation_LeftBottom:
        {
            [text drawInRect:CGRectMake(spaceSize.width, img_h-spaceSize.height-str_h, str_w, str_h) withAttributes:attrs];
        }
            break;
        case YTWaterMarkLocation_RightTop:
        {
            [text drawInRect:CGRectMake(img_w-spaceSize.width-str_w, spaceSize.height, str_w, str_h) withAttributes:attrs];
        }
            break;
        case YTWaterMarkLocation_RightBottom:
        {
            [text drawInRect:CGRectMake(img_w-spaceSize.width-str_w, img_h-spaceSize.height-str_h, str_w, str_h) withAttributes:attrs];
        }
            break;
        default:
        {
            [text drawInRect:CGRectMake((img_w-str_w)/2.0, (img_h-str_h)/2.0, str_w, str_h) withAttributes:attrs];
        }
            break;
    }

    CGContextSaveGState(context);
    CGContextRestoreGState(context);

    UIImage *lastImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return lastImage;
}

- (UIImage *)getLocationWaterMarkImageWithText:(NSString *)text Location:(YTWaterMarkLocation)location {
    return [self getLocationWaterMarkImageWithText:text Attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:YTMARK_TEXT_FONT], NSForegroundColorAttributeName: [UIColor colorWithRed:192.0/255.0 green:192.0/255.0 blue:192.0/255.0 alpha:1]} SpaceSize:CGSizeMake(YTMARK_LOCATION_SPACE, YTMARK_LOCATION_SPACE) Location:location];
}

@end
