//
//  LicensePlateKeyboardConfig.h
//  

#import <UIKit/UIKit.h>

#import "LicensePlateKeyboardModel.h"

NS_ASSUME_NONNULL_BEGIN

#define LicensePlateScreenWidth [UIScreen mainScreen].bounds.size.width
#define YTDevelopBundle [NSBundle bundleWithIdentifier:@"org.cocoapods.YTDevelopTools"]
#define YTDevelopBundleURL [YTDevelopBundle URLForResource:@"YTDevelopTools" withExtension:@"bundle"]

@interface LicensePlateKeyboardConfig : NSObject

- (NSString *)getPlateNumberFilePath;

- (NSString *)getPlateProvinceFilePath;

@property (nonatomic, assign) CGFloat widthScale;
@property (nonatomic, assign) CGFloat itemSpace;
@property (nonatomic, assign) NSInteger rowCount;
@property (nonatomic, assign) BOOL addDone;
@property (nonatomic, assign) BOOL addDelete;
@property (nonatomic, strong) UIImage *doneImage;
@property (nonatomic, strong) UIImage *deleteImage;

@property (nonatomic,   copy) NSString *filePath;

@property (nonatomic, strong, readonly) NSMutableArray <LicensePlateKeyboardModel *> *dataArray;
@property (nonatomic, assign, readonly) CGFloat itemWidth;
@property (nonatomic, assign, readonly) CGFloat itemHeight;
@property (nonatomic, assign, readonly) NSInteger rows;

@end

NS_ASSUME_NONNULL_END
