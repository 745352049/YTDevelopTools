//
//  UILabel+YTFastLabel.h
//  

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef UILabel * _Nonnull (^text)(NSString * _Nullable text);
typedef UILabel * _Nonnull (^attributedText)(NSAttributedString * _Nullable attributedText);
typedef UILabel * _Nonnull (^textColor)(UIColor * _Nullable color);
typedef UILabel * _Nonnull (^font)(UIFont * _Nullable font);
typedef UILabel * _Nonnull (^textAlignment)(NSTextAlignment alignment);
typedef UILabel * _Nonnull (^backgroundColor)(UIColor * _Nullable color);
typedef UILabel * _Nonnull (^lines)(NSInteger lines);
typedef UILabel * _Nonnull (^lineBreakMode)(NSLineBreakMode breakMode);

@interface UILabel (YTFastLabel)

- (text)set_text;

- (attributedText)set_attributedText;

- (textColor)set_textColor;

- (font)set_font;

- (textAlignment)set_textAlignment;

- (backgroundColor)set_backgroundColor;

- (lines)set_lines;

- (lineBreakMode)set_lineBreakMode;

@end

NS_ASSUME_NONNULL_END
