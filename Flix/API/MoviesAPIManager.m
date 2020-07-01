//
//  MoviesAPIManager.m
//  Flix
//
//  Created by Fiona Barry on 7/1/20.
//  Copyright © 2020 fbarry. All rights reserved.
//

#import "MoviesAPIManager.h"
#import "Movie.h"

@implementation MoviesAPIManager

- (id)init {
    self = [super init];

    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];

    return self;
}

- (void)fetchMoviesWithURL:(NSURL *)url withCompletion:(void(^)(NSMutableArray *movies, NSError *error))completion {
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
            completion(nil, error);
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSArray *dictionaries = dataDictionary[@"results"];
            NSMutableArray *movies = [Movie moviesWithDictionaries:dictionaries];

            completion(movies, nil);
        }
    }];
    [task resume];
}

- (void)fetchVideosForMovieWithID:(NSString *)idStr withCompletion:(void(^)(NSDictionary *video, NSError *error))completion {
    NSString *stringURL = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/%@/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US", idStr];
    NSURL *url = [NSURL URLWithString:stringURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error != nil) {
                completion(nil, error);
            }
            else {
                NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
                NSDictionary *videos = dataDictionary[@"results"];
                
                for (NSDictionary *video in videos) {
                    if ([video[@"type"] isEqualToString:@"Trailer"] && [video[@"site"] isEqualToString:@"YouTube"]) {
                        completion(video, nil);
                        break;
                    }
                }
                
                completion(nil, nil);
            }
       }];
    [task resume];
}

@end
