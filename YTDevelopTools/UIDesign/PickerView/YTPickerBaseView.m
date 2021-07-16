//
//  YTPickerBaseView.m
//

#import "YTPickerBaseView.h"

@implementation YTPickerBaseView

- (void)initUI {
    self.frame = YTSCREEN_BOUNDS;
    
    [self addSubview:self.backgroundView];
    [self addSubview:self.selectView];
    [self.selectView addSubview:self.topView];
    [self.topView addSubview:self.cancleBtn];
    [self.topView addSubview:self.doneBtn];
    [self.topView addSubview:self.titleLabel];
    [self.topView addSubview:self.lineView];
}

#pragma mark - 点击背景遮罩图层事件(子类实现)

- (void)backgroundViewWithTap:(UITapGestureRecognizer *)tap {
    
}

#pragma mark - 取消按钮的点击事件(子类实现)

- (void)cancleBtnAction {
    
}

#pragma mark - 确定按钮的点击事件(子类实现)

- (void)doneBtnAction {
    
}


#pragma mark - 取消按钮

- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.frame = CGRectMake(0, 0, YTButtonWidth, YTTopViewHeight);
        _cancleBtn.backgroundColor = [UIColor clearColor];
        _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_cancleBtn setTitleColor:YTRGB_HEX(0x1E90FF, 1.0) forState:UIControlStateNormal];
        [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(cancleBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}

#pragma mark - 确定按钮

- (UIButton *)doneBtn {
    if (!_doneBtn) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneBtn.frame = CGRectMake(YTDatePicWidth - YTButtonWidth, 0, YTButtonWidth, YTTopViewHeight);
        _doneBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_doneBtn setTitleColor:YTRGB_HEX(0x1E90FF, 1.0) forState:UIControlStateNormal];
        [_doneBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_doneBtn addTarget:self action:@selector(doneBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneBtn;
}

#pragma mark - 中间标题

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(YTButtonWidth, 0, YTDatePicWidth - YTButtonWidth * 2, YTTopViewHeight)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:18.0f];
        _titleLabel.textColor = YTRGB_HEX(0x1E90FF, 1.0);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

#pragma mark - 分割线

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, YTTopViewHeight, YTDatePicWidth, 0.5)];
        _lineView.backgroundColor = [UIColor colorWithRed:225.0 / 255.0 green:225.0 / 255.0 blue:225.0 / 255.0 alpha:1.0];
    }
    return _lineView;
}

#pragma mark - 顶部视图

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YTDatePicWidth, YTTopViewHeight + 0.5)];
        _topView.backgroundColor = YTRGB_HEX(0xFDFDFD, 1.0f);
    }
    return _topView;
}

#pragma mark - 选择视图

- (UIView *)selectView {
    if (!_selectView) {
        _selectView = [[UIView alloc] initWithFrame:CGRectMake((YTSCREEN_WIDTH - YTDatePicWidth) / 2.0, YTSCREEN_HEIGHT, YTDatePicWidth, YTTotalViewHeight)];
        _selectView.backgroundColor = [UIColor whiteColor];
        _selectView.clipsToBounds = YES;
        _selectView.layer.cornerRadius = 12.0;
    }
    return _selectView;
}

#pragma mark - 背景遮罩图层

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:YTSCREEN_BOUNDS];
        _backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        _backgroundView.userInteractionEnabled = YES;
        UITapGestureRecognizer *backgroundViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewWithTap:)];
        [_backgroundView addGestureRecognizer:backgroundViewTap];
    }
    return _backgroundView;
}

@end
