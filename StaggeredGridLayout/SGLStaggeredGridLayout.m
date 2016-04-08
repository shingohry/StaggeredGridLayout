//
//  SGLStaggeredGridLayout.m
//  StaggeredGridLayout
//
//  Created by Shingo Hiraya on 2016/03/17.
//  Copyright © 2016年 Shingo Hiraya. All rights reserved.
//

#import "SGLStaggeredGridLayout.h"
#import "SGLStaggeredGridLayoutAttributes.h"

static NSInteger const kNumberOfColumns = 2;
static CGFloat const kCellMargin = 10.0f;

@interface SGLStaggeredGridLayout ()

@property (nonatomic) NSMutableArray<__kindof UICollectionViewLayoutAttributes *> *cachedAttributes;
@property (nonatomic) CGFloat contentHeight;
@property (nonatomic, readonly) CGFloat contentWidth;

@end

@implementation SGLStaggeredGridLayout

#pragma mark - Life Cycle

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    
    if (self) {
        _contentHeight = 0.0f;
        _cachedAttributes = [NSMutableArray new];
    }
    
    return self;
}

#pragma mark - Accessor

// collectionView のコンテンツ部分の幅を返す
- (CGFloat)contentWidth
{
    return CGRectGetWidth(self.collectionView.bounds) - (self.collectionView.contentInset.left + self.collectionView.contentInset.right);
}

#pragma mark - UICollectionViewLayout

// collectionView のコンテンツ部分のサイズを返す
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.contentWidth, self.contentHeight);
}

// 引数で渡されたCGRectの範囲内に表示される要素の UICollectionViewLayoutAttributes の配列を返す
- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray<__kindof UICollectionViewLayoutAttributes *> *layoutAttributes = [NSMutableArray new];
    
    for (SGLStaggeredGridLayoutAttributes *attributes in self.cachedAttributes) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            [layoutAttributes addObject:attributes];
        }
    }

    return [layoutAttributes copy];
}

// NSIndexPathで指定される要素のレイアウト情報を返す
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cachedAttributes[indexPath.item];
}

// UICollectionView をスクロールしたタイミングでレイアウトを invalidete をする場合は YES を返す
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}

- (void)prepareLayout
{
    // [1] レイアウト情報をキャッシュ済みの場合は処理を終了する
    if (self.cachedAttributes.count > 0) {
        return;
    }
    
    NSInteger column = 0;
    
    // [2] セルの幅を計算する
    CGFloat totalHorizontalMargin = (kCellMargin * (kNumberOfColumns - 1));
    CGFloat cellWidth =  (self.contentWidth - totalHorizontalMargin) / kNumberOfColumns;
    
    // [3] 「セルの原点 x」の配列を計算する
    NSMutableArray<NSNumber *> *cellOriginXList = [NSMutableArray new];
    
    for (NSInteger i = 0; i < kNumberOfColumns; i++) {
        CGFloat originX = i * (cellWidth + kCellMargin);
        [cellOriginXList addObject:@(originX)];
    }
    
    // [4] カラムごとの「現在計算対象にしているセルの原点 y」を格納した配列を計算する
    NSMutableArray<NSNumber *> *currentCellOriginYList = [NSMutableArray new];
    
    for (NSInteger i = 0; i < kNumberOfColumns; i++) {
        [currentCellOriginYList addObject:@(0.0f)];
    }
    
    // [5] 各セルのサイズ・原点座標を計算する
    for (NSInteger item = 0; item < [self.collectionView numberOfItemsInSection:0]; item++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
        
        // [6] セルの写真部分・ボディ部分のそれぞれの高さを取得する
        CGFloat imageHeight = [self.delegate collectionView:self.collectionView
                                  heightForImageAtIndexPath:indexPath
                                                      width:cellWidth];
        CGFloat bodyHeight = [self.delegate collectionView:self.collectionView
                                  heightForBodyAtIndexPath:indexPath
                                                     width:cellWidth];
        CGFloat cellHeight = imageHeight + bodyHeight;
        
        // [7] セルの frame を作成する
        CGRect cellFrame = CGRectMake(cellOriginXList[column].floatValue,
                                      currentCellOriginYList[column].floatValue,
                                      cellWidth,
                                      cellHeight);
        
        // [8] SGLStaggeredGridLayoutAttributes オブジェクトを作成して、cachedAttributes プロパティに格納する
        SGLStaggeredGridLayoutAttributes *attributes = [SGLStaggeredGridLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.imageHeight = imageHeight;
        attributes.frame = cellFrame;
        [self.cachedAttributes addObject:attributes];
        
        // [9] UICollectionView のコンテンツの高さを計算して contentHeight プロパティに格納する
        self.contentHeight = MAX(self.contentHeight, CGRectGetMaxY(cellFrame));
        
        // [10] 次のセルの原点 y を計算する
        currentCellOriginYList[column] = @(currentCellOriginYList[column].floatValue + cellHeight + kCellMargin);
        
        // [11] 次のカラムを決める
        __block NSInteger nextColumn = 0;
        __block NSNumber *minOriginY = @(MAXFLOAT);
        [currentCellOriginYList enumerateObjectsUsingBlock:^(NSNumber *originY, NSUInteger index, BOOL *stop) {
            if ([originY compare:minOriginY] == NSOrderedAscending) {
                minOriginY = originY;
                nextColumn = index;
            }
        }];
        
        column = nextColumn;
    }
}

// UICollectionViewLayoutAttributes のサブクラスのクラスオブジェクトを返す
+ (Class)layoutAttributesClass
{
    return [SGLStaggeredGridLayoutAttributes class];
}

@end
