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
#import "MoviesAPIManager.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) NSDictionary *videos;
@property (strong, nonatomic) NSDictionary *trailerVideo;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;
@property (weak, nonatomic) IBOutlet UILabel *previewLabel;
@property (weak, nonatomic) IBOutlet UIImageView *playImage;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.previewLabel.hidden = YES;
    
    [self fetchVideo];
    
    self.titleLabel.text = self.movie.title;
    self.descriptionLabel.text = self.movie.descriptionText;  
    
    if (self.movie.backdropURL) {
        [self.backdropView setImageWithURL:self.movie.backdropURL];
    }
    
    if (self.movie.posterURL) {
        [self.posterView setImageWithURL:self.movie.posterURL];
    }
}

- (void) fetchVideo {
    MoviesAPIManager *manager = [MoviesAPIManager new];
    [manager fetchVideosForMovieWithID:self.movie.idStr withCompletion:^(NSDictionary *video, NSError *error) {
        if (error) {
            [Utilities showAlertWithTitle:@"Cannot Load Video"
                        message:@"The Internet connection appears to be offline."
                    buttonTitle:@"Try Again"
                  buttonHandler:^(UIAlertAction *action) { [self fetchVideo]; }
              secondButtonTitle:@"Cancel"
            secondButtonHandler:^(UIAlertAction *secondAction) { return; }
               inViewController:self];
        }
        else if (video){
            self.trailerVideo = video;
            self.playImage.hidden = NO;
        }
    }];
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
