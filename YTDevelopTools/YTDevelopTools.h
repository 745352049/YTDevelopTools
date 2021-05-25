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

#import <YTDevelopTools/UIImage+YTWaterMark.h>
#import <YTDevelopTools/NSString+YTMD5Encrypt.h>
#import <YTDevelopTools/NSBundle+YTBundle.h>
#import <YTDevelopTools/UIColor+YTAdapter.h>

#import <YTDevelopTools/YTSystemAlertController.h>
#import <YTDevelopTools/YTPermissions.h>

#import <YTDevelopTools/YTKeyBoardView.h>
#import <YTDevelopTools/YTKeyBoardTextField.h>
#import <YTDevelopTools/YTPlaceholderTextView.h>
#import <YTDevelopTools/YTAssistiveTouchView.h>
#import <YTDevelopTools/YTRotatingImageView.h>
#import <YTDevelopTools/YTRotatingView.h>
#import <YTDevelopTools/YTBezierDrawPath.h>
#import <YTDevelopTools/YTBezierDrawView.h>

#import <YTDevelopTools/YTPermissionTool.h>

#else

#import "UIImage+YTWaterMark.h"
#import "NSString+YTMD5Encrypt.h"
#import "NSBundle+YTBundle.h"
#import "UIColor+YTAdapter.h"

#import "YTSystemAlertController.h"
#import "YTPermissions.h"

#import "YTKeyBoardView.h"
#import "YTKeyBoardTextField.h"
#import "YTPlaceholderTextView.h"
#import "YTAssistiveTouchView.h"
#import "YTRotatingImageView.h"
#import "YTRotatingView.h"
#import "YTBezierDrawPath.h"
#import "YTBezierDrawView.h"

#import "YTPermissionTool.h"

#endif
