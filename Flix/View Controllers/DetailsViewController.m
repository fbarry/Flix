//
//  DetailsViewController.m
//  Flix
//
//  Created by Fiona Barry on 6/24/20.
//  Copyright © 2020 fbarry. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) UIAlertController *alertController;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.activityIndicator startAnimating];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";

    self.backdropView.image = nil;
    if ([self.movie[@"backdrop_path"] isKindOfClass:[NSString class]]) {
        NSString *backdropURLString = self.movie[@"backdrop_path"];
        NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
        NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
        [self.backdropView setImageWithURL:backdropURL];
    }
    
    self.posterView.image = nil;
    if ([self.movie[@"poster_path"] isKindOfClass:[NSString class]]) {
        NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
        NSString *posterURLString = self.movie[@"poster_path"];
        NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
        NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
        [self.posterView setImageWithURL:posterURL];
    }
    
    self.titleLabel.text = self.movie[@"title"];
    self.descriptionLabel.text = self.movie[@"overview"];
    
    [self.activityIndicator stopAnimating];
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
