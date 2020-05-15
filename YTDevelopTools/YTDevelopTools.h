//
//  YTDevelopTools.h
//  

#import <Foundation/Foundation.h>

#if __has_include(<YTDevelopTools/YTDevelopTools.h>)

FOUNDATION_EXPORT double YTDevelopToolsVersionNumber;
FOUNDATION_EXPORT const unsigned char YTDevelopToolsVersionString[];

#import <YTDevelopTools/YTSystemAlertController.h>
#import <YTDevelopTools/UIImage+YTWaterMark.h>
#import <YTDevelopTools/NSString+YTMD5Encrypt.h>

#else

#import "YTSystemAlertController.h"
#import "UIImage+YTWaterMark.h"
#import "NSString+YTMD5Encrypt.h"

#endif
