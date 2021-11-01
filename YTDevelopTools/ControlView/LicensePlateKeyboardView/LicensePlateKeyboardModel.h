//
//  LicensePlateModel.h
//  

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LicensePlateKeyboardModel : NSObject

@property (nonatomic,   copy) NSString *name;
@property (nonatomic, assign) BOOL enable;
///
@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, assign) BOOL isDone;

@end

NS_ASSUME_NONNULL_END
