//
//  DetailsViewController.m
//  Flix
//
//  Created by Fiona Barry on 6/24/20.
//  Copyright © 2020 fbarry. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "VideoViewController.h"
#import "Utilities.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) NSDictionary *videos;
@property (strong, nonatomic) NSDictionary *trailerVideo;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;
@property (weak, nonatomic) IBOutlet UILabel *previewLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.previewLabel.hidden = YES;
    
    NSString *idString = self.movie[@"id"];
    [self fetchVideo:idString];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";

    if ([self.movie[@"backdrop_path"] isKindOfClass:[NSString class]]) {
        NSString *backdropURLString = self.movie[@"backdrop_path"];
        NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
        NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
        [self.backdropView setImageWithURL:backdropURL];
    }
    
    if ([self.movie[@"poster_path"] isKindOfClass:[NSString class]]) {
        NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
        NSString *posterURLString = self.movie[@"poster_path"];
        NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
        NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
        [self.posterView setImageWithURL:posterURL];
    }
    
    self.titleLabel.text = self.movie[@"title"];
    self.descriptionLabel.text = self.movie[@"overview"];    
}

- (void) fetchVideo:(NSString *) idString {
    NSString *stringURL = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US", idString];
    NSURL *url = [NSURL URLWithString:stringURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error != nil) {
                [Utilities showAlertWithTitle:@"Cannot Load Video"
                                      message:@"The Internet connection appears to be offline."
                                  buttonTitle:@"Try Again"
                                buttonHandler:^(UIAlertAction *action) { [self fetchVideo:idString]; }
                            secondButtonTitle:@"Cancel"
                          secondButtonHandler:^(UIAlertAction *secondAction) { [session invalidateAndCancel]; }
                             inViewController:self];
            }
            else {
                NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
                self.videos = dataDictionary[@"results"];
                
                for (NSDictionary *video in self.videos) {
                    if ([video[@"type"] isEqualToString:@"Trailer"] && [video[@"site"] isEqualToString:@"YouTube"]) {
                        self.trailerVideo = video;
                                                    
//                        UIAlertController *videoAlert = [UIAlertController alertControllerWithTitle:@"Video Available"
//                                                                                            message:@"Click on backdrop to view."
//                                                                                     preferredStyle:UIAlertControllerStyleAlert];
//                        [self presentViewController:(UIViewController *)videoAlert animated:YES completion:nil];
//                        [videoAlert dismissViewControllerAnimated:YES completion:nil];
                        
                        break;
                    }
                }
            }
       }];
    [task resume];
}

- (IBAction)backdropClick:(id)sender {
    if (self.trailerVideo) {
        [self performSegueWithIdentifier:@"ToVideo" sender:self];
    }
    else {
        UIAlertController *noVideoAlert = [UIAlertController alertControllerWithTitle:@"No Video Available"
                                                                              message:nil
                                                                       preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:(UIViewController *)noVideoAlert animated:YES completion:nil];
        [noVideoAlert dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    VideoViewController *videoViewController = [segue destinationViewController];
    NSString *stringURL = [NSString stringWithFormat:@"https://www.youtube.com/watch?v=%@", self.trailerVideo[@"key"]];
    videoViewController.link = [NSURL URLWithString:stringURL];
}

@end
