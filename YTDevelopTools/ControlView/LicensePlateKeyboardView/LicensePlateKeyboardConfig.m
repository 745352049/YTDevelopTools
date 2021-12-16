//
//  LicensePlateKeyboardConfig.m
//  

#import "LicensePlateKeyboardConfig.h"

@interface LicensePlateKeyboardConfig ()

@property (nonatomic, strong, readwrite) NSMutableArray <LicensePlateKeyboardModel *> *dataArray;
@property (nonatomic, assign, readwrite) CGFloat itemWidth;
@property (nonatomic, assign, readwrite) CGFloat itemHeight;
@property (nonatomic, assign, readwrite) NSInteger rows;

@end

@implementation LicensePlateKeyboardConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        self.widthScale = 4.0/3.0;
        self.itemSpace = 8.0;
        self.rowCount = 10;
        self.addDone = YES;
        self.addDelete = YES;
    }
    return self;
}

- (NSString *)getPlateNumberFilePath {
    return [[NSBundle bundleWithURL:YTDevelopBundleURL] pathForResource:@"LicensePlateNumber" ofType:@"json"];
}

- (NSString *)getPlateProvinceFilePath {
    return [[NSBundle bundleWithURL:YTDevelopBundleURL] pathForResource:@"LicensePlateProvince" ofType:@"json"];
}

#pragma mark - Set

- (void)setWidthScale:(CGFloat)widthScale {
    _widthScale = widthScale;
}

- (void)setItemSpace:(CGFloat)itemSpace {
    _itemSpace = itemSpace;
}

- (void)setRowCount:(NSInteger)rowCount {
    _rowCount = rowCount;
}

- (void)setAddDone:(BOOL)addDone {
    _addDone = addDone;
}

- (void)setAddDelete:(BOOL)addDelete {
    _addDelete = addDelete;
}

- (void)setDoneImage:(UIImage *)doneImage {
    _doneImage = doneImage;
}

- (void)setDeleteImage:(UIImage *)deleteImage {
    _deleteImage = deleteImage;
}

- (void)setFilePath:(NSString *)filePath {
    _filePath = filePath;
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (!error) {
        NSArray *dataArr = [dict objectForKey:@"data"];
        [dataArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @autoreleasepool {
                LicensePlateKeyboardModel *model = [[LicensePlateKeyboardModel alloc] init];
                model.name = [obj objectForKey:@"name"];
                model.enable = [[obj objectForKey:@"enable"] isEqualToString:@"1"] ? YES : NO;
                [self.dataArray addObject:model];
            }
        }];
        
        if (self.addDelete == YES) {
            LicensePlateKeyboardModel *model = [[LicensePlateKeyboardModel alloc] init];
            model.isDelete = YES;
            [self.dataArray addObject:model];
        }
        
        if (self.addDone == YES) {
            LicensePlateKeyboardModel *model = [[LicensePlateKeyboardModel alloc] init];
            model.isDone = YES;
            [self.dataArray addObject:model];
        }
        
        self.itemWidth = (LicensePlateScreenWidth-self.itemSpace*(self.rowCount+1))/self.rowCount-0.1;
        self.itemHeight = self.itemWidth*self.widthScale;
        self.rows = ([self.dataArray count] + (self.rowCount-1)) / self.rowCount;
    } else {
        NSLog(@" 解析json出错：%@", error.localizedDescription);
    }
}

- (void)setItemWidth:(CGFloat)itemWidth {
    _itemWidth = itemWidth;
}

- (void)setItemHeight:(CGFloat)itemHeight {
    _itemHeight = itemHeight;
}

- (void)setRows:(NSInteger)rows {
    _rows = rows;
}

#pragma mark - Lazy

- (NSMutableArray<LicensePlateKeyboardModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
