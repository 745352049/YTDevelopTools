//
//  MapNavigator.h
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapNavigator : NSObject

+ (BOOL)isAppleMapAppInstalled;

+ (BOOL)isBaiDuAppInstalled;

+ (BOOL)isGaoDeAppInstalled;

+ (BOOL)isTengXunAppInstalled;

+ (BOOL)isGoogleAppInstalled;


+ (void)AppleMapNavigatorWithLocation:(CLLocationCoordinate2D)location name:(NSString *)name;

+ (void)AppleMapNavigatorWithLocation:(CLLocationCoordinate2D)location name:(NSString *)name mode:(NSString *)mode;

+ (void)AppleMapNavigatorWithStartItem:(MKMapItem *)startItem endItem:(MKMapItem *)endItem launchOptions:(nullable NSDictionary <NSString *, id> *)launchOptions;


+ (void)BaiDuNavigatorWithLocation:(CLLocationCoordinate2D)location name:(NSString *)name;

+ (void)BaiDuNavigatorWithLocation:(CLLocationCoordinate2D)location name:(NSString *)name mode:(NSString *)mode coordtype:(NSString *)coordtype;

+ (void)BaiDuNavigatorWithUrl:(NSString *)url;


+ (void)GaoDeNavigatorWithLocation:(CLLocationCoordinate2D)location name:(NSString *)name;

+ (void)GaoDeNavigatorWithLocation:(CLLocationCoordinate2D)location name:(NSString *)name mode:(NSString *)mode;

+ (void)GaoDeNavigatorWithUrl:(NSString *)url;


+ (void)TengXunNavigatorWithLocation:(CLLocationCoordinate2D)location name:(NSString *)name;

+ (void)TengXunNavigatorWithLocation:(CLLocationCoordinate2D)location name:(NSString *)name mode:(NSString *)mode;

+ (void)TengXunNavigatorWithUrl:(NSString *)url;


+ (void)GoogleNavigatorWithLocation:(CLLocationCoordinate2D)location name:(NSString *)name;

+ (void)GoogleNavigatorWithLocation:(CLLocationCoordinate2D)location name:(NSString *)name mode:(NSString *)mode;

+ (void)GoogleNavigatorWithUrl:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
