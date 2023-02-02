//
//  UIImage+YTCapture.h
//  

#import <UIKit/UIKit.h>

#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YTCapture)

/// tableView已滑动过的视图截图
+ (UIImage *)snapshotScreenForTableView:(UITableView *)tableView;

/// 保存图片到相册
- (void)saveToAlbum:(NSString *)album Results:(void(^)(BOOL isSuccess, NSString *tipStr))result;

@end

NS_ASSUME_NONNULL_END
