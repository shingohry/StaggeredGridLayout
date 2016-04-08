//
//  SGLStaggeredGridLayoutAttributes.m
//  StaggeredGridLayout
//
//  Created by Shingo Hiraya on 2016/03/17.
//  Copyright © 2016年 Shingo Hiraya. All rights reserved.
//

#import "SGLStaggeredGridLayoutAttributes.h"

@implementation SGLStaggeredGridLayoutAttributes

#pragma mark - Life Cycle

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _imageHeight = 0.0f;
    }
    
    return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone
{
    SGLStaggeredGridLayoutAttributes *copy = [super copyWithZone:zone];
    copy.imageHeight = self.imageHeight;
    
    return copy;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[self class]]) {
        SGLStaggeredGridLayoutAttributes *attributtes = object;
        
        if (attributtes.imageHeight == self.imageHeight) {
            return [super isEqual:attributtes];
        }
    }
    
    return NO;
}

@end
