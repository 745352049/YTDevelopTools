//
//  CarNumberKeyboardConfig.m
//

#import "CarNumberKeyboardConfig.h"

@interface CarNumberKeyboardConfig ()

@property (nonatomic, strong, readwrite) NSMutableArray <CarNumberKeyboardModel *> *dataArray;
@property (nonatomic, assign, readwrite) CGFloat itemWidth;
@property (nonatomic, assign, readwrite) CGFloat itemHeight;
@property (nonatomic, assign, readwrite) NSInteger rows;

@end

@implementation CarNumberKeyboardConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        self.widthScale = 4.0/3.0;
        self.itemSpace = 6.0;
        self.rowCount = 10;
    }
    return self;
}

- (NSString *)getPlateNumberFilePath {
    return [[NSBundle bundleWithURL:YTDevelopBundleURL] pathForResource:@"CarNumberNumber" ofType:@"json"];
}

- (NSString *)getPlateProvinceFilePath {
    return [[NSBundle bundleWithURL:YTDevelopBundleURL] pathForResource:@"CarNumberProvince" ofType:@"json"];
}

- (void)analysisFileWithPath:(NSString *)filePath dataArray:(NSMutableArray *)dataArray {
    [dataArray removeAllObjects];
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (!error) {
        NSArray *dataArr = [dict objectForKey:@"data"];
        [dataArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            @autoreleasepool {
                CarNumberKeyboardModel *model = [[CarNumberKeyboardModel alloc] init];
                model.name = [obj objectForKey:@"name"];
                model.enable = [[obj objectForKey:@"enable"] isEqualToString:@"1"] ? YES : NO;
                model.isChange = ([model.name isEqualToString:@"ABC"] || [model.name isEqualToString:@"省份"]) ? YES : NO;
                [dataArray addObject:model];
            }
        }];
        
        CarNumberKeyboardModel *model = [[CarNumberKeyboardModel alloc] init];
        model.isDelete = YES;
        model.enable = YES;
        [dataArray addObject:model];
        
        self.itemWidth = (CarNumberKeyboardScreenWidth-self.itemSpace*(self.rowCount+1))/self.rowCount-0.1;
        self.itemHeight = self.itemWidth*self.widthScale;
        self.rows = ([dataArray count] + (self.rowCount-1)) / self.rowCount;
    } else {
        NSLog(@" 解析json出错：%@", error.localizedDescription);
    }
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

- (void)setDeleteImage:(UIImage *)deleteImage {
    _deleteImage = deleteImage;
}

- (void)setFilePath:(NSString *)filePath {
    _filePath = filePath;
    
    [self analysisFileWithPath:filePath dataArray:self.dataArray];
}

#pragma mark - Lazy

- (NSMutableArray<CarNumberKeyboardModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end


@implementation CarNumberKeyboardModel

@end
