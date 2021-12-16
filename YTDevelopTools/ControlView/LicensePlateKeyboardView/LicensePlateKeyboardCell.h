//
//  LicensePlateKeyboardCell.h
//  

#import <UIKit/UIKit.h>

#import "LicensePlateKeyboardModel.h"
#import "LicensePlateKeyboardConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface LicensePlateKeyboardCell : UICollectionViewCell

@property (nonatomic,   copy) LicensePlateKeyboardConfig *config;
@property (nonatomic,   copy) LicensePlateKeyboardModel *model;

@end

NS_ASSUME_NONNULL_END
