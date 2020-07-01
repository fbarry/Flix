//
//  Movie.m
//  Flix
//
//  Created by Fiona Barry on 7/1/20.
//  Copyright © 2020 fbarry. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    self.idStr = dictionary[@"id"];
    self.title = dictionary[@"title"];
    self.descriptionText = dictionary[@"overview"];
    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    
    if ([dictionary[@"poster_path"] isKindOfClass:[NSString class]]) {
        NSString *posterURLString = dictionary[@"poster_path"];
        NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
        NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
        self.posterURL = posterURL;
    }
    
    if ([dictionary[@"backdrop_path"] isKindOfClass:[NSString class]]) {
        NSString *backdropURLString = dictionary[@"backdrop_path"];
        NSString *fullBackdropURLString = [baseURLString stringByAppendingString:backdropURLString];
        NSURL *backdropURL = [NSURL URLWithString:fullBackdropURLString];
        self.backdropURL = backdropURL;
    }
    
    return self;
}

+ (NSMutableArray *)moviesWithDictionaries:(NSArray *)dictionaries {
    
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in dictionaries) {
        Movie *movie = [[Movie alloc] initWithDictionary:dictionary];
        [movies addObject:movie];
    }
    
    return movies;
}

@end
