//
//  TableViewController.m
//  BlogReader
//
//  Created by Sahil Gupta on 2015-05-19.
//  Copyright (c) 2015 SahilGupta. All rights reserved.
//

#import "TableViewController.h"
#import "WebViewController.h"
#import "BlogPost.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *blogURL = [NSURL URLWithString:@"http://blog.teamtreehouse.com/api/get_recent_summary"];
    NSData *jsonBlogData = [NSData dataWithContentsOfURL:blogURL];
    NSError *error = nil;
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonBlogData options:0 error:&error];
    
    self.blogPosts = [NSMutableArray array];
    
    NSArray *blogPostsDictionaries = [dataDictionary objectForKey:@"posts"];
    
    for (NSDictionary *indBlogPostDictionary in blogPostsDictionaries) {
        BlogPost *blogPost = [BlogPost blogPostWithTitle:[indBlogPostDictionary objectForKey:@"title"]];
        blogPost.author = [indBlogPostDictionary objectForKey:@"author"];
        blogPost.url = [NSURL URLWithString:[indBlogPostDictionary objectForKey:@"url"]];
        blogPost.datePublished = [indBlogPostDictionary objectForKey:@"date"];
        
        NSString *thumbnailURLString = [indBlogPostDictionary objectForKey:@"thumbnail"];
        if([thumbnailURLString isKindOfClass:[NSString class]]) {
            blogPost.thumbnailURL = [NSURL URLWithString:[indBlogPostDictionary objectForKey:@"thumbnail"]];
        } else {
            blogPost.thumbnailURL = [NSURL URLWithString:@"http://lorempixel.com/400/200/technics/"];
        }
        
        [self.blogPosts addObject:blogPost];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.blogPosts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    BlogPost *currentBlogPost = [self.blogPosts objectAtIndex:indexPath.row];
    
    NSData *imageData = [NSData dataWithContentsOfURL:currentBlogPost.thumbnailURL];
    UIImage *image = [UIImage imageWithData:imageData];
    CGSize thumbnailSize = CGSizeMake(50, 50);
    image = [self imageWithImage:image scaledToSize:thumbnailSize];
    
    
    cell.imageView.image = image;
    cell.textLabel.text = currentBlogPost.title;
    NSString *detailFormattedTextLabel = [NSString stringWithFormat:@"%@ | %@",currentBlogPost.author,currentBlogPost.formattedDate];
    cell.detailTextLabel.text = detailFormattedTextLabel;
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showBlogPost"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        BlogPost *currentBlogPost = [self.blogPosts objectAtIndex:indexPath.row];
        
        WebViewController *webViewController = (WebViewController *)segue.destinationViewController;
        webViewController.blogPostURL = currentBlogPost.url;
    }
}



- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
