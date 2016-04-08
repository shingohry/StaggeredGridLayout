//
//  SGLPost.m
//  StaggeredGridLayout
//
//  Created by Shingo Hiraya on 2016/03/17.
//  Copyright © 2016年 Shingo Hiraya. All rights reserved.
//

#import "SGLPost.h"

@implementation SGLPost

#pragma mark - Life Cycle

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        _text = dictionary[@"text"];
        
        NSString *imageName = dictionary[@"imageName"];
        _image = imageName ? [UIImage imageNamed:imageName] : nil;
    }
    
    return self;
}

#pragma mark - Public

+ (NSArray<SGLPost *> *)allPosts
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Posts"
                                                         ofType:@"json"];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    NSArray<NSDictionary *> *jsonPosts = [NSJSONSerialization JSONObjectWithData:fileData
                                                                         options:NSJSONReadingMutableContainers
                                                                           error:nil];
    
    NSMutableArray<SGLPost *> *posts = [NSMutableArray array];
    
    for (NSDictionary *dictionary in jsonPosts) {
        SGLPost *post = [[SGLPost alloc] initWithDictionary:dictionary];
        [posts addObject:post];
    }
    
    return [posts copy];
}

@end
