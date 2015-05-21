//
//  BlogPost.h
//  BlogReader
//
//  Created by Sahil Gupta on 2015-05-21.
//  Copyright (c) 2015 SahilGupta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogPost : NSObject

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *author;
@property(nonatomic,strong) NSURL *thumbnailURL;
@property(nonatomic,strong) NSString *datePublished;

- (id) initWithTitle: (NSString *)title;
- (NSString *) formattedDate;
+ (id) blogPostWithTitle: (NSString *)title;

@end
