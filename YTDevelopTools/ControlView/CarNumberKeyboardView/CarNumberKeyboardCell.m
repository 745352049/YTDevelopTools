//
//  CarNumberKeyboardCell.m
//  

#import "CarNumberKeyboardCell.h"

@interface CarNumberKeyboardCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *deleteImageV;

@end

@implementation CarNumberKeyboardCell

- (void)layoutSubviews {
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.deleteImageV];
    
    self.bgView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
    self.titleLabel.frame = self.bgView.bounds;
    self.deleteImageV.frame = self.bgView.bounds;
    
    self.bgView.layer.cornerRadius = 6.0;
}

- (void)setConfig:(CarNumberKeyboardConfig *)config {
    _config = config;
}

- (void)setModel:(CarNumberKeyboardModel *)model {
    _model = model;
    
    if (model.name.length) {
        if (model.enable) {
            self.titleLabel.textColor = [UIColor blackColor];
        } else {
            self.titleLabel.textColor = [UIColor lightGrayColor];
        }
        self.titleLabel.text = model.name;
        [self.deleteImageV setHidden:YES];
        [self.titleLabel setHidden:NO];
    } else {
        [self.deleteImageV setHidden:NO];
        [self.titleLabel setHidden:YES];
    }
    
    if (model.isDelete == YES) {
        if (self.config.deleteImage) {
            self.deleteImageV.image = self.config.deleteImage;
        } else {
            self.deleteImageV.image = [UIImage imageNamed:[[NSBundle bundleWithURL:YTDevelopBundleURL] pathForResource:@"LicensePlateKeyboardDel@2x" ofType:@"png"]];
        }
    }
}

- (UIImageView *)deleteImageV {
    if (!_deleteImageV) {
        _deleteImageV = [[UIImageView alloc] init];
        _deleteImageV.contentMode = UIViewContentModeCenter;
    }
    return _deleteImageV;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

@end
