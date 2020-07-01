//
//  MoviesGridViewController.m
//  Flix
//
//  Created by Fiona Barry on 6/25/20.
//  Copyright © 2020 fbarry. All rights reserved.
//

#import "MoviesGridViewController.h"
#import "MovieCollectionCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"
#import "Utilities.h"
#import "MoviesAPIManager.h"

@interface MoviesGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *movies;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation MoviesGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    self.collectionView.frame = self.view.frame;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    
    CGFloat postersPerRow = 3;
    CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postersPerRow - 1)) / postersPerRow;
    CGFloat itemHeight = itemWidth * 1.5;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    [self fetchMovies];
}

- (void) fetchMovies {
    [self.activityIndicator startAnimating];
    
    MoviesAPIManager *manager = [MoviesAPIManager new];
    [manager fetchMovies:^(NSMutableArray *movies, NSError *error) {
        if (error) {
            [Utilities showAlertWithTitle:@"Cannot Load Movies"
                         message:@"The Internet connection appears to be offline."
                     buttonTitle:@"Try Again"
                   buttonHandler:^(UIAlertAction *action) { [self fetchMovies]; }
                secondButtonTitle:nil
            secondButtonHandler:nil
                inViewController:self];
        }
        else {
            self.movies = movies;
            [self.collectionView reloadData];
        }
        [self.activityIndicator stopAnimating];
    }];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MovieCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionCell" forIndexPath:indexPath];
    Movie *movie = self.movies[indexPath.item];
        
    if (movie.posterURL) {
        [cell.posterView setImageWithURL:movie.posterURL];
    }
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UICollectionViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
    Movie *movie = self.movies[indexPath.item];
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.movie = movie;
}


@end
