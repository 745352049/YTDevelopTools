//
//  LicensePlateKeyboardView.m
//  

#import "LicensePlateKeyboardView.h"

#import "YTHorizontalCollectionViewFlowLayout.h"
#import "LicensePlateKeyboardCell.h"
#import "LicensePlateKeyboardModel.h"

#define LicensePlate_StatusbarHeight() \
^(){\
if (@available(iOS 13.0, *)) {\
return [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;\
} else {\
return [[UIApplication sharedApplication] statusBarFrame].size.height;\
}\
}()

#define LicensePlate_SafeArea_Height (LicensePlate_StatusbarHeight() > 20.0 ? 34.0 : 0.0)

@interface LicensePlateKeyboardView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) YTHorizontalCollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation LicensePlateKeyboardView

- (instancetype)initWithConfig:(LicensePlateKeyboardConfig *)config {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, LicensePlateScreenWidth, 0.01);
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
        
        self.config = config;
    }
    return self;
}

- (void)setConfig:(LicensePlateKeyboardConfig *)config {
    _config = config;
    
    [self createUI];
}

- (void)createUI {
    CGFloat height = self.config.rows*(self.config.itemHeight+self.config.itemSpace)+self.config.itemSpace;
    
    CGRect rect = self.frame;
    rect.size.height = height+LicensePlate_SafeArea_Height;
    self.frame = rect;
    
    CGRect collectRect = self.collectionView.frame;
    collectRect.size.height = height;
    self.collectionView.frame = collectRect;
    
    [self.collectionView registerClass:[LicensePlateKeyboardCell class] forCellWithReuseIdentifier:@"LicensePlateKeyboardCell"];
    [self addSubview:self.collectionView];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.config.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LicensePlateKeyboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LicensePlateKeyboardCell" forIndexPath:indexPath];
    LicensePlateKeyboardModel *model = [self.config.dataArray objectAtIndex:indexPath.row];
    cell.model = model;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LicensePlateKeyboardModel *model = [self.config.dataArray objectAtIndex:indexPath.row];
    if (model.isDelete == YES) {
        if (_keyboardViewClickBlock) {
            self.keyboardViewClickBlock(self, YES, NO, @"");
        }
        return;
    }
    
    if (model.isDone == YES) {
        if (_keyboardViewClickBlock) {
            self.keyboardViewClickBlock(self, NO, YES, @"");
        }
        return;
    }
    if (model.enable == YES) {
        if (_keyboardViewClickBlock) {
            self.keyboardViewClickBlock(self, NO, NO, model.name);
        }
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.config.addDone == YES && self.config.addDelete == YES) {
        if (indexPath.item > self.config.dataArray.count - 3) {
            return CGSizeMake((self.config.itemWidth*3.0+self.config.itemSpace)/2.0, self.config.itemHeight);
        }
    } else if (self.config.addDone == YES || self.config.addDelete == YES) {
        if (indexPath.item > self.config.dataArray.count - 2) {
            return CGSizeMake((self.config.itemWidth*3.0+self.config.itemSpace)/2.0, self.config.itemHeight);
        }
    }
    return CGSizeMake(self.config.itemWidth, self.config.itemHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(self.config.itemSpace, self.config.itemSpace, self.config.itemSpace, self.config.itemSpace);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.config.itemSpace;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.config.itemSpace;
}

#pragma mark - Lazy

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, LicensePlateScreenWidth, 0.01) collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
    }
    return _collectionView;
}

- (YTHorizontalCollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[YTHorizontalCollectionViewFlowLayout alloc] init];
        _layout.horizonalType = YTHorizonalLeft;
    }
    return _layout;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
