//
//  YTHorizontalCollectionViewFlowLayout.h
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YTHorizonalType) {
    YTHorizonalCenter = 0,
    YTHorizonalLeft,
    YTHorizonalRight
};

@interface YTHorizontalCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) YTHorizonalType horizonalType;

@end
