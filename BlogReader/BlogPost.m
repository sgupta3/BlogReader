//
//  BlogPost.m
//  BlogReader
//
//  Created by Sahil Gupta on 2015-05-21.
//  Copyright (c) 2015 SahilGupta. All rights reserved.
//

#import "BlogPost.h"

@implementation BlogPost

- (id) initWithTitle: (NSString *)title {
    self = [super init];
    if(self){
        self.title = title;
    }
    return self;
}

+ (id) blogPostWithTitle: (NSString *)title {
    return [[self alloc] initWithTitle:title];
}



@end
