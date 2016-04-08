//
//  SGLStaggeredGridLayout.h
//  StaggeredGridLayout
//
//  Created by Shingo Hiraya on 2016/03/17.
//  Copyright © 2016年 Shingo Hiraya. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SGLStaggeredGridLayoutDelegate;

@interface SGLStaggeredGridLayout : UICollectionViewLayout

@property (nonatomic, weak) id<SGLStaggeredGridLayoutDelegate> delegate;

@end

@protocol SGLStaggeredGridLayoutDelegate <NSObject>

- (CGFloat)collectionView:(UICollectionView *)collectionView
heightForImageAtIndexPath:(NSIndexPath *)indexPath
                    width:(CGFloat)width;

- (CGFloat)collectionView:(UICollectionView *)collectionView
 heightForBodyAtIndexPath:(NSIndexPath *)indexPath
                    width:(CGFloat)width;

@end