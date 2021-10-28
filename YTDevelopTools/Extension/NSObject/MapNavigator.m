//
//  MapNavigator.m
//  

#import "MapNavigator.h"

@implementation MapNavigator

+ (BOOL)isAppleMapAppInstalled {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com/"]]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isBaiDuAppInstalled {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isGaoDeAppInstalled {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isTengXunAppInstalled {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isGoogleAppInstalled {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        return YES;
    }
    return NO;
}

///

+ (void)AppleMapNavigatorWithLocation:(CLLocationCoordinate2D)location name:(NSString *)name {
    /// 用户位置
    MKMapItem *startItem = [MKMapItem mapItemForCurrentLocation];
    /// 终点位置
    MKMapItem *endItem = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:location addressDictionary:nil]];
    endItem.name = name;
    /// launchOptions
    NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                                    MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                                    MKLaunchOptionsShowsTrafficKey : @(YES)};
    
    [MapNavigator AppleMapNavigatorWithStartItem:startItem endItem:endItem launchOptions:launchOptions];
}

+ (void)AppleMapNavigatorWithStartItem:(MKMapItem *)startItem endItem:(MKMapItem *)endItem launchOptions:(nullable NSDictionary <NSString *, id> *)launchOptions {
    [MKMapItem openMapsWithItems:@[startItem, endItem] launchOptions:launchOptions];
}

///

+ (void)BaiDuNavigatorWithLocation:(CLLocationCoordinate2D)location {
    [MapNavigator BaiDuNavigatorWithUrl:[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=%f,%f&mode=%@&src=iOS", location.latitude, location.longitude, @"driving"]];
}

+ (void)BaiDuNavigatorWithUrl:(NSString *)url {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
}

///

+ (void)GaoDeNavigatorWithLocation:(CLLocationCoordinate2D)location name:(NSString *)name {
    [MapNavigator GaoDeNavigatorWithUrl:[NSString stringWithFormat:@"iosamap://path?sourceApplication=iOS&dlat=%f&dlon=%f&dname=%@&t=0", location.latitude, location.longitude, name]];
}

+ (void)GaoDeNavigatorWithUrl:(NSString *)url {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
}

///

+ (void)TengXunNavigatorWithLocation:(CLLocationCoordinate2D)location name:(NSString *)name {
    [MapNavigator TengXunNavigatorWithUrl:[NSString stringWithFormat:@"qqmap://map/routeplan?from=%@&type=%@&tocoord=%f,%f&to=%@", @"我的位置", @"drive", location.latitude, location.longitude, name]];
}

+ (void)TengXunNavigatorWithUrl:(NSString *)url {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
}

///

+ (void)GoogleNavigatorWithLocation:(CLLocationCoordinate2D)location name:(NSString *)name {
    [MapNavigator GoogleNavigatorWithUrl:[NSString stringWithFormat:@"comgooglemaps://?x-source=iOS&x-success=scheme&daddr=%f,%f&daddr=%@&directionsmode=%@", location.latitude, location.longitude, name, @"driving"]];
}

+ (void)GoogleNavigatorWithUrl:(NSString *)url {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]];
}

@end
