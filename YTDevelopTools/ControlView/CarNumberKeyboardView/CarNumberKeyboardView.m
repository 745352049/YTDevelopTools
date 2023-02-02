//
//  CarNumberKeyboardView.m
//  

#import "CarNumberKeyboardView.h"

#import "CarNumberKeyboardCell.h"

#define CarNumberKeyboard_StatusbarHeight() \
^(){\
if (@available(iOS 13.0, *)) {\
return [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height;\
} else {\
return [[UIApplication sharedApplication] statusBarFrame].size.height;\
}\
}()

#define CarNumberKeyboard_SafeArea_Height (CarNumberKeyboard_StatusbarHeight() > 20.0 ? 34.0 : 0.0)

@interface CarNumberKeyboardView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *collectionArray;

@end

@implementation CarNumberKeyboardView

- (instancetype)initWithConfig:(CarNumberKeyboardConfig *)config {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, CarNumberKeyboardScreenWidth, 0.01);
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
        
        self.config = config;
        [self.collectionView registerClass:[CarNumberKeyboardCell class] forCellWithReuseIdentifier:@"CarNumberKeyboardCell"];
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)setConfig:(CarNumberKeyboardConfig *)config {
    _config = config;
    
    [self createUI];
}

- (void)createUI {
    CGFloat height = self.config.rows*(self.config.itemHeight+self.config.itemSpace)+self.config.itemSpace;
    
    CGRect rect = self.frame;
    rect.size.height = height+CarNumberKeyboard_SafeArea_Height;
    self.frame = rect;
    
    CGRect collectRect = self.collectionView.frame;
    collectRect.size.height = height;
    self.collectionView.frame = collectRect;
    
    [self.collectionArray removeAllObjects];
    [self.collectionArray addObjectsFromArray:[self.config.dataArray copy]];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CarNumberKeyboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CarNumberKeyboardCell" forIndexPath:indexPath];
    [cell setConfig:self.config];
    CarNumberKeyboardModel *model = [self.collectionArray objectAtIndex:indexPath.row];
    cell.model = model;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CarNumberKeyboardModel *model = [self.collectionArray objectAtIndex:indexPath.row];
    if (!model.enable) return;
    
    AudioServicesPlaySystemSound(1519);
    
    if (model.isChange) {
        if ([model.name isEqualToString:@"ABC"]) {
            self.config.filePath = [self.config getPlateNumberFilePath];
            [self setConfig:self.config];
        } else if ([model.name isEqualToString:@"省份"]) {
            self.config.filePath = [self.config getPlateProvinceFilePath];
            [self setConfig:self.config];
        }
    } else {
        if (_keyboardViewClickBlock) {
            self.keyboardViewClickBlock(self, model.isDelete, model.name);
        }
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CarNumberKeyboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CarNumberKeyboardCell" forIndexPath:indexPath];
    [cell.contentView layoutIfNeeded];
    
    CarNumberKeyboardModel *model = [self.collectionArray objectAtIndex:indexPath.row];
    if (model.isChange || model.isDelete) {
        return CGSizeMake((self.config.itemWidth*3.0+self.config.itemSpace)/2.0, self.config.itemHeight);
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

- (NSMutableArray *)collectionArray {
    if (!_collectionArray) {
        _collectionArray = [[NSMutableArray alloc] init];
    }
    return _collectionArray;
}

- (UICollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _layout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, CarNumberKeyboardScreenWidth, 0.01) collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
    }
    return _collectionView;
}
    
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
