//
//  VideoViewController.m
//  Flix
//
//  Created by Fiona Barry on 6/26/20.
//  Copyright © 2020 fbarry. All rights reserved.
//

#import "VideoViewController.h"
#import <WebKit/WebKit.h>

@interface VideoViewController ()

@property (weak, nonatomic) IBOutlet WKWebView *webKitView;

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Place the URL in a URL Request.
    NSURLRequest *request = [NSURLRequest requestWithURL:self.link
                                        cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                        timeoutInterval:10.0];
    // Load Request into WebView.
    [self.webKitView loadRequest:request];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
