//
//  MoviesViewController.m
//  Flix
//
//  Created by Fiona Barry on 6/24/20.
//  Copyright © 2020 fbarry. All rights reserved.
//

#import "MoviesViewController.h"
#import "DetailsViewController.h"
#import "MovieCellTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "Utilities.h"
#import "MoviesGridViewController.h"
#import "Movie.h"
#import "MoviesAPIManager.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *movies;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation MoviesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self fetchMovies];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void) fetchMovies {
    [self.activityIndicator startAnimating];
    
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    
    MoviesAPIManager *manager = [MoviesAPIManager new];
    [manager fetchMoviesWithURL:url withCompletion:^(NSMutableArray *movies, NSError *error) {
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
            [self.tableView reloadData];
        }
        [self.refreshControl endRefreshing];
        [self.activityIndicator stopAnimating];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    Movie *movie = self.movies[indexPath.row];
    
    cell.titleLabel.text = movie.title;
    cell.descriptionLabel.text = movie.descriptionText;
    
    if (movie.posterURL) {
        [cell.posterView setImageWithURL:movie.posterURL];
    }
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    Movie *movie = self.movies[indexPath.row];
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.movie = movie;
}

@end
