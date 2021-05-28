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


#import <YTDevelopTools/YTKeyBoardView.h>
#import <YTDevelopTools/YTKeyBoardTextField.h>
#import <YTDevelopTools/YTPlaceholderTextView.h>
#import <YTDevelopTools/YTAssistiveTouchView.h>
#import <YTDevelopTools/YTRotatingImageView.h>
#import <YTDevelopTools/YTRotatingView.h>
#import <YTDevelopTools/YTBezierDrawPath.h>
#import <YTDevelopTools/YTBezierDrawView.h>

#else

#import "YTCategories.h"

#import "YTExtension.h"

#import "YTPermissionTool.h"


#import "YTKeyBoardView.h"
#import "YTKeyBoardTextField.h"
#import "YTPlaceholderTextView.h"
#import "YTAssistiveTouchView.h"
#import "YTRotatingImageView.h"
#import "YTRotatingView.h"
#import "YTBezierDrawPath.h"
#import "YTBezierDrawView.h"

#endif
