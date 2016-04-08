//
//  SGLPostCell.h
//  StaggeredGridLayout
//
//  Created by Shingo Hiraya on 2016/03/17.
//  Copyright © 2016年 Shingo Hiraya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGLPost.h"

@interface SGLPostCell : UICollectionViewCell

@property (nonatomic) SGLPost *post;

+ (CGFloat)imageHeightWithImage:(UIImage *)image
                      cellWidth:(CGFloat)cellWidth;

+ (CGFloat)bodyHeightWithText:(NSString *)text
                    cellWidth:(CGFloat)cellWidth;

@end
