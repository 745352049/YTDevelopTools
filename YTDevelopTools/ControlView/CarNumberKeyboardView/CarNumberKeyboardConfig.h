//
//  CarNumberKeyboardConfig.h
//  

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define CarNumberKeyboardScreenWidth [UIScreen mainScreen].bounds.size.width
#define YTDevelopBundle [NSBundle bundleWithIdentifier:@"org.cocoapods.YTDevelopTools"]
#define YTDevelopBundleURL [YTDevelopBundle URLForResource:@"YTDevelopTools" withExtension:@"bundle"]

@class CarNumberKeyboardModel;

@interface CarNumberKeyboardConfig : NSObject

- (NSString *)getPlateNumberFilePath;

- (NSString *)getPlateProvinceFilePath;

@property (nonatomic, assign) CGFloat widthScale;
@property (nonatomic, assign) CGFloat itemSpace;
@property (nonatomic, assign) NSInteger rowCount;
@property (nonatomic, strong) UIImage *deleteImage;
@property (nonatomic,   copy) NSString *filePath;

@property (nonatomic, strong, readonly) NSMutableArray <CarNumberKeyboardModel *> *dataArray;
@property (nonatomic, assign, readonly) CGFloat itemWidth;
@property (nonatomic, assign, readonly) CGFloat itemHeight;
@property (nonatomic, assign, readonly) NSInteger rows;

@end


@interface CarNumberKeyboardModel : NSObject

@property (nonatomic,   copy) NSString *name;
@property (nonatomic, assign) BOOL enable;
///
@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, assign) BOOL isChange;

@end

NS_ASSUME_NONNULL_END
