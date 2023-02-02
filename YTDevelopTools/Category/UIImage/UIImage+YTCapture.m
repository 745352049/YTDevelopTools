//
//  UIImage+YTCapture.m
//  

#import "UIImage+YTCapture.h"

@implementation UIImage (YTCapture)

+ (UIImage *)snapshotScreenForTableView:(UITableView *)tableView {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        // 第一个参数表示区域大小。
        // 第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。
        // 第三个参数就是屏幕密度了，调整清晰度。
        UIGraphicsBeginImageContextWithOptions(tableView.contentSize, NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(tableView.contentSize);
    }
    // 先保存原来frame 和 偏移量
    CGPoint savedContentOffset = tableView.contentOffset;
    CGRect savedFrame = tableView.frame;
    CGSize contentSize = tableView.contentSize;
    CGRect oldBounds = tableView.layer.bounds;

    if (@available(iOS 13.0, *)) {
        // iOS 13 系统截屏需要改变tableview 的 bounds
         [tableView.layer setBounds:CGRectMake(oldBounds.origin.x, oldBounds.origin.y, contentSize.width, contentSize.height)];
    }

    // 偏移量归零
    tableView.contentOffset = CGPointZero;
    // frame变为contentSize
    tableView.frame = CGRectMake(0, 0, tableView.contentSize.width, tableView.contentSize.height);
    // 截图
    [tableView.layer renderInContext:UIGraphicsGetCurrentContext()];
    if (@available(iOS 13.0, *)) {
        [tableView.layer setBounds:oldBounds];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 还原frame 和 偏移量
    tableView.contentOffset = savedContentOffset;
    tableView.frame = savedFrame;

    return image;
}

- (void)saveToAlbum:(NSString *)album Results:(void(^)(BOOL isSuccess, NSString *tipStr))result {
    PHAssetCollection *collection = [self createCollectionWithAlbumName:album];
    if (collection == nil) {
        if (result) result(NO, @"未获得相册读写权限！");
        return;
    }
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
        PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:self];
        PHObjectPlaceholder *placeholder = [assetChangeRequest placeholderForCreatedAsset];
        [assetCollectionChangeRequest addAssets:@[placeholder]];
    } error:&error];
    if (error) {
        if (result) result(NO, error.localizedDescription);
    } else {
        if (result) result(YES, @"保存成功！");
    }
}

- (PHAssetCollection *)createCollectionWithAlbumName:(NSString *)albumName {
    // 获得所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:albumName]) {
            return collection;
        }
    }
    // 代码执行到这里，说明还没有自定义相册
    __block NSString *createdCollectionId = nil;
    // 创建一个新的相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdCollectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:albumName].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    if (createdCollectionId == nil) return nil;
    // 创建完毕后再取出相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionId] options:nil].firstObject;
}

@end
