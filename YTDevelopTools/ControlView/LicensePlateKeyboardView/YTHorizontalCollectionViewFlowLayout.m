//
//  MLHorizontalCollectionViewFlowLayout.m
//  

#import "YTHorizontalCollectionViewFlowLayout.h"

@implementation YTHorizontalCollectionViewFlowLayout

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributes = [[NSMutableArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    NSMutableDictionary *rowsDict = [[NSMutableDictionary alloc] init];
    id <UICollectionViewDelegateFlowLayout> delegate = (id <UICollectionViewDelegateFlowLayout>)[self.collectionView delegate];
    BOOL itemSpacing = [delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)];
    BOOL sectionInset = [delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)];
    
    for (UICollectionViewLayoutAttributes *itemAttributes in attributes) {
        CGFloat midYRound = roundf(CGRectGetMidY(itemAttributes.frame));
        CGFloat midYPlus = midYRound + 1;
        CGFloat midYMinus = midYRound - 1;
        NSNumber *key;
        if (rowsDict[@(midYPlus)])
            key = @(midYPlus);
        
        if (rowsDict[@(midYMinus)])
            key = @(midYMinus);
        
        if (!key)
            key = @(midYRound);
        
        if (!rowsDict[key])
            rowsDict[key] = [NSMutableArray new];
        
        [(NSMutableArray *)rowsDict[key] addObject:itemAttributes];
    }
    
    CGFloat collectionViewWidth = [self collectionViewContentWidth];
    [rowsDict enumerateKeysAndObjectsUsingBlock:^(id key, NSArray *itemAttributesCollection, BOOL *stop) {
        NSInteger itemsInRow = [itemAttributesCollection count];
        CGFloat interitemSpacing = [self minimumInteritemSpacing];
        if (itemSpacing && itemsInRow > 0) {
            NSUInteger section = [[itemAttributesCollection[0] indexPath] section];
            interitemSpacing = [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
        }
        UIEdgeInsets sectionInsets = [self sectionInset];
        if (sectionInset) {
            NSUInteger section = [[itemAttributesCollection[0] indexPath] section];
            sectionInsets = [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
        }
        // 计算出总间隔
        CGFloat aggregateInteritemSpacing = interitemSpacing * (itemsInRow - 1) + sectionInsets.left + sectionInsets.right;
        // 计算每行所有item的宽度
        CGFloat aggregateItemWidths = 0.0f;
        for (UICollectionViewLayoutAttributes *itemAttributes in itemAttributesCollection) {
            aggregateItemWidths += CGRectGetWidth(itemAttributes.frame);
        }
        // 间隔和item的总宽度
        CGFloat alignmentWidth = aggregateItemWidths + aggregateInteritemSpacing;
        CGFloat alignmentXOffset = 0.0;
        // 算出每行第一个item的偏移量
        if (self.horizonalType == YTHorizonalLeft) {
            alignmentXOffset = sectionInsets.left;
        } else if (self.horizonalType == YTHorizonalCenter) {
            alignmentXOffset = (collectionViewWidth - alignmentWidth) / 2.0;
        } else if (self.horizonalType == YTHorizonalRight) {
            alignmentXOffset = collectionViewWidth - alignmentWidth - sectionInsets.right;
        }
        
        CGRect previousFrame = CGRectZero;
        for (UICollectionViewLayoutAttributes *itemAttributes in itemAttributesCollection) {
            CGRect itemFrame = itemAttributes.frame;
            if (CGRectEqualToRect(previousFrame, CGRectZero)) {
                itemFrame.origin.x = alignmentXOffset;
            } else {
                itemFrame.origin.x = CGRectGetMaxX(previousFrame) + interitemSpacing;
            }
            itemAttributes.frame = itemFrame;
            previousFrame = itemFrame;
        }
    }];
    
    return attributes;
}

- (void)setHorizonalType:(YTHorizonalType)horizonalType {
    _horizonalType = horizonalType;
}

- (CGFloat)collectionViewContentWidth {
    return CGRectGetWidth(self.collectionView.bounds) - self.collectionView.contentInset.left - self.collectionView.contentInset.right;;
}

- (CGSize)collectionViewContentSize {
    CGSize size = [super collectionViewContentSize];
    return size;
}

@end
