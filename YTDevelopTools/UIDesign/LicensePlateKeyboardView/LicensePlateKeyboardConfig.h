//
//  LicensePlateKeyboardConfig.h
//  YANTING
//
//  Created by MAC on 2021/9/30.
//

#import <UIKit/UIKit.h>

#import "LicensePlateKeyboardModel.h"

NS_ASSUME_NONNULL_BEGIN

#define LicensePlateScreenWidth [UIScreen mainScreen].bounds.size.width

@interface LicensePlateKeyboardConfig : NSObject

@property (nonatomic, assign) CGFloat itemSpace;
@property (nonatomic, assign) NSInteger rowCount;
@property (nonatomic, assign) BOOL addDone;
@property (nonatomic, assign) BOOL addDelete;

@property (nonatomic,   copy) NSString *filePath;

@property (nonatomic, strong, readonly) NSMutableArray <LicensePlateKeyboardModel *> *dataArray;
@property (nonatomic, assign, readonly) CGFloat itemWidth;
@property (nonatomic, assign, readonly) CGFloat itemHeight;
@property (nonatomic, assign, readonly) NSInteger rows;

@end

NS_ASSUME_NONNULL_END
