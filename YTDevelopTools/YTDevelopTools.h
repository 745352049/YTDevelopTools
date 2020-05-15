//
//  YTDevelopTools.h
//  

#import <Foundation/Foundation.h>

#if __has_include(<YTDevelopTools/YTDevelopTools.h>)

FOUNDATION_EXPORT double YTDevelopToolsVersionNumber;
FOUNDATION_EXPORT const unsigned char YTDevelopToolsVersionString[];

#import <YTDevelopTools/YTSystemAlertController.h>

#else

#import "YTSystemAlertController.h"

#endif
