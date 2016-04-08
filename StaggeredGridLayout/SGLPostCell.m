//
//  SGLPostCell.m
//  StaggeredGridLayout
//
//  Created by Shingo Hiraya on 2016/03/17.
//  Copyright © 2016年 Shingo Hiraya. All rights reserved.
//

#import "SGLPostCell.h"
#import "SGLStaggeredGridLayoutAttributes.h"

@import AVFoundation;

@interface SGLPostCell ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *imageViewHeightLayoutConstraint;
@property (nonatomic, weak) IBOutlet UILabel *commentLabel;

@end

@implementation SGLPostCell

#pragma mark - Accessor

- (void)setPost:(SGLPost *)post
{
    _post = post;
    
    self.imageView.image = post.image;
    self.commentLabel.text = post.text;
}

#pragma mark - UICollectionReusableView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    if ([layoutAttributes isKindOfClass:[SGLStaggeredGridLayoutAttributes class]]) {
        SGLStaggeredGridLayoutAttributes *attributes = (SGLStaggeredGridLayoutAttributes *)layoutAttributes;
        self.imageViewHeightLayoutConstraint.constant = attributes.imageHeight;
    }
}

#pragma mark - Public

// image と セルの幅を基に、ボディ部分に必要な高さを返す
+ (CGFloat)imageHeightWithImage:(UIImage *)image
                      cellWidth:(CGFloat)cellWidth
{
    if (image) {
        CGRect boundingRect =  CGRectMake(0, 0, cellWidth, CGFLOAT_MAX);
        CGRect rect = AVMakeRectWithAspectRatioInsideRect(image.size, boundingRect);
        
        return rect.size.height;
    } else {
        return 0.0f;
    }
}

// text と セルの幅を基に、ボディ部分に必要な高さを返す
+ (CGFloat)bodyHeightWithText:(NSString *)text
                    cellWidth:(CGFloat)cellWidth
{
    CGFloat padding = 4.0f;
    CGFloat width = (cellWidth - padding * 2);
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:10.0f]}
                                     context:nil];
    
    return padding + ceil(rect.size.height) + padding;
}

@end
