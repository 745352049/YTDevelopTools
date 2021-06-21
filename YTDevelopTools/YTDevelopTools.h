//
//  YTDevelopTools.h
//

/**
 QQ:1538017568
 */

#import <Foundation/Foundation.h>

#if __has_include(<YTDevelopTools/YTDevelopTools.h>)

FOUNDATION_EXPORT double YTDevelopToolsVersionNumber;
FOUNDATION_EXPORT const unsigned char YTDevelopToolsVersionString[];

#import <YTDevelopTools/YTCategories.h>

#import <YTDevelopTools/YTExtension.h>

#import <YTDevelopTools/YTPermissionTool.h>

#import <YTDevelopTools/YTUIDesign.h>

#import <YTDevelopTools/YTMacrosHeader.h>

#else

#import "YTCategories.h"

#import "YTExtension.h"

#import "YTPermissionTool.h"

#import "YTUIDesign.h"

#import "YTMacrosHeader.h"

#endif
