//
//  CarNumberKeyboardCell.h
//  

#import <UIKit/UIKit.h>

#import "CarNumberKeyboardConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface CarNumberKeyboardCell : UICollectionViewCell

@property (nonatomic,   copy) CarNumberKeyboardConfig *config;
@property (nonatomic,   copy) CarNumberKeyboardModel *model;

@end

NS_ASSUME_NONNULL_END
