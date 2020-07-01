//
//  Movie.h
//  Flix
//
//  Created by Fiona Barry on 7/1/20.
//  Copyright © 2020 fbarry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descriptionText;
@property (nonatomic, strong) NSString *idStr;
@property (nonatomic, strong) NSURL *posterURL;
@property (nonatomic, strong) NSURL *backdropURL;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSMutableArray *)moviesWithDictionaries:(NSArray *)dictionaries;

@end

NS_ASSUME_NONNULL_END
