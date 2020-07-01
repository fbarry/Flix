//
//  MoviesAPIManager.h
//  Flix
//
//  Created by Fiona Barry on 7/1/20.
//  Copyright © 2020 fbarry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoviesAPIManager : NSObject

@property (nonatomic, strong) NSURLSession *session;

- (void)fetchMoviesWithURL:(NSURL *)url withCompletion:(void(^)(NSMutableArray *movies, NSError *error))completion;

- (void)fetchVideosForMovieWithID:(NSString *)idStr withCompletion:(void(^)(NSDictionary *video, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
