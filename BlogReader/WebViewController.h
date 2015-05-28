//
//  WebViewController.h
//  BlogReader
//
//  Created by Sahil Gupta on 2015-05-27.
//  Copyright (c) 2015 SahilGupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property(strong, nonatomic) NSURL *blogPostURL;

@end
