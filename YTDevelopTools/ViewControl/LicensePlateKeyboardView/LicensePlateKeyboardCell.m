//
//  LicensePlateKeyboardCell.m
//  

#import "LicensePlateKeyboardCell.h"

@interface LicensePlateKeyboardCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *deleteImageV;

@end

@implementation LicensePlateKeyboardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.bgView.layer.cornerRadius = 6.0;
}

- (void)setModel:(LicensePlateKeyboardModel *)model {
    _model = model;
    
    if (model.name.length) {
        if (model.enable) {
            self.titleLabel.textColor = [UIColor blackColor];
        } else {
            self.titleLabel.textColor = [UIColor lightGrayColor];
        }
        self.titleLabel.text = model.name;
        [self.deleteImageV setHidden:YES];
    } else {
        [self.deleteImageV setHidden:NO];
    }
    
    if (model.isDelete == YES) {
        self.deleteImageV.image = [UIImage imageNamed:[[NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"YTDevelopTools" withExtension:@"bundle"]] pathForResource:@"LicensePlateKeyboardDel@2x" ofType:@"png"]];
    }
    
    if (model.isDone == YES) {
        self.deleteImageV.image = [UIImage imageNamed:[[NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"YTDevelopTools" withExtension:@"bundle"]] pathForResource:@"LicensePlateKeyboardDis@2x" ofType:@"png"]];
    }
}

@end
