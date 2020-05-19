//
//  YTDevelopTools.h
//  

#import <Foundation/Foundation.h>

#if __has_include(<YTDevelopTools/YTDevelopTools.h>)

FOUNDATION_EXPORT double YTDevelopToolsVersionNumber;
FOUNDATION_EXPORT const unsigned char YTDevelopToolsVersionString[];

#import <YTDevelopTools/UIImage+YTWaterMark.h>
#import <YTDevelopTools/NSString+YTMD5Encrypt.h>
#import <YTDevelopTools/NSBundle+YTBundle.h>

#import <YTDevelopTools/YTSystemAlertController.h>
#import <YTDevelopTools/YTPermissions.h>
#import <YTDevelopTools/YTKeyBoardView.h>
#import <YTDevelopTools/YTKeyBoardTextField.h>

#else

#import "UIImage+YTWaterMark.h"
#import "NSString+YTMD5Encrypt.h"
#import "NSBundle+YTBundle.h"

#import "YTSystemAlertController.h"
#import "YTPermissions.h"
#import "YTKeyBoardView.h"
#import "YTKeyBoardTextField.h"

#endif
