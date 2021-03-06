//
//  SGLPost.h
//  StaggeredGridLayout
//
//  Created by Shingo Hiraya on 2016/03/17.
//  Copyright © 2016年 Shingo Hiraya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGLPost : NSObject

@property (nonatomic) NSString *text;
@property (nonatomic) UIImage *image;

+ (NSArray<SGLPost *> *)allPosts;

@end
