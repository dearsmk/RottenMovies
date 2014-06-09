//
//  MovieDetailsViewController.h
//  RottenMovies
//
//  Created by Muthukumar S on 6/8/14.
//  Copyright (c) 2014 Muthukumar S. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieDetailsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *movieTitle;
@property (strong, nonatomic) IBOutlet UILabel *movieSynopsis;
@property (strong, nonatomic) IBOutlet UIImageView *moviePoster;

@property(nonatomic, strong) NSArray *movie;
@property(nonatomic) long *movieId;
@property(nonatomic) int myValue;
@property (strong, nonatomic) Movie *selectedMovie;

@end
