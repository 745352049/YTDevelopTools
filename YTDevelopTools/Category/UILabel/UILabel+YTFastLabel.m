//
//  UILabel+YTFastLabel.m
//  

#import "UILabel+YTFastLabel.h"

@implementation UILabel (YTFastLabel)

- (text)set_text {
    return ^id (NSString * _Nullable text) {
        self.text = text;
        return self;
    };
}

- (attributedText)set_attributedText {
    return ^id (NSAttributedString * _Nullable attributedText) {
        self.attributedText = attributedText;
        return self;
    };
}

- (textColor)set_textColor {
    return ^id (UIColor * _Nullable color) {
        self.textColor = color;
        return self;
    };
}

- (font)set_font {
    return ^id (UIFont * _Nullable font) {
        self.font = font;
        return self;
    };
}

- (textAlignment)set_textAlignment {
    return ^id (NSTextAlignment alignment) {
        self.textAlignment = alignment;
        return self;
    };
}

- (backgroundColor)set_backgroundColor {
    return ^id (UIColor * _Nullable color) {
        self.backgroundColor = color;
        return self;
    };
}

- (lines)set_lines {
    return ^id (NSInteger lines) {
        self.numberOfLines = lines;
        return self;
    };
}

- (lineBreakMode)set_lineBreakMode {
    return ^id (NSLineBreakMode breakMode) {
        self.lineBreakMode = breakMode;
        return self;
    };
}

@end
