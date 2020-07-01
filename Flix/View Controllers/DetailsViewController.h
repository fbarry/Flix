//
//  DetailsViewController.h
//  Flix
//
//  Created by Fiona Barry on 6/24/20.
//  Copyright © 2020 fbarry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (nonatomic, strong) Movie *movie;

@end

NS_ASSUME_NONNULL_END
