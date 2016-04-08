//
//  SGLPostsViewController.m
//  StaggeredGridLayout
//
//  Created by Shingo Hiraya on 2016/03/17.
//  Copyright © 2016年 Shingo Hiraya. All rights reserved.
//

#import "SGLPostsViewController.h"
#import "SGLPost.h"
#import "SGLStaggeredGridLayout.h"
#import "SGLPostCell.h"

@import AVFoundation;

@interface SGLPostsViewController () <SGLStaggeredGridLayoutDelegate>

@property (nonatomic) NSArray<SGLPost *> *posts;

@end

@implementation SGLPostsViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.posts = [SGLPost allPosts];

    self.collectionView.contentInset = UIEdgeInsetsMake(24.0f, 10.0f, 10.0f, 10.0f);
    
    SGLStaggeredGridLayout *layout = (SGLStaggeredGridLayout *)self.collectionView.collectionViewLayout;
    layout.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.posts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SGLPostCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:@"AnnotatedPhotoCell"
                                              forIndexPath:indexPath];
    cell.post = self.posts[indexPath.item];
    
    return cell;
}

#pragma mark - SGLStaggeredGridLayoutDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView
heightForImageAtIndexPath:(NSIndexPath *)indexPath
                    width:(CGFloat)width
{
    return [SGLPostCell imageHeightWithImage:self.posts[indexPath.item].image
                                   cellWidth:width];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
 heightForBodyAtIndexPath:(NSIndexPath *)indexPath
                    width:(CGFloat)width
{
    return [SGLPostCell bodyHeightWithText:self.posts[indexPath.item].text
                                 cellWidth:width];
}

@end
