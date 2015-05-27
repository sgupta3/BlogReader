//
//  TableViewController.m
//  BlogReader
//
//  Created by Sahil Gupta on 2015-05-19.
//  Copyright (c) 2015 SahilGupta. All rights reserved.
//

#import "TableViewController.h"
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
        NSString *thumbnailURLString = [indBlogPostDictionary objectForKey:@"thumbnail"];
        if([thumbnailURLString isKindOfClass:[NSString class]]) {
            blogPost.thumbnailURL = [NSURL URLWithString:[indBlogPostDictionary objectForKey:@"thumbnail"]];
        }
        
        blogPost.datePublished = [indBlogPostDictionary objectForKey:@"date"];
        
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
    
    cell.imageView.image = image;
    cell.textLabel.text = currentBlogPost.title;
    NSString *detailFormattedTextLabel = [NSString stringWithFormat:@"%@ | %@",currentBlogPost.author,currentBlogPost.formattedDate];
    cell.detailTextLabel.text = detailFormattedTextLabel;
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
