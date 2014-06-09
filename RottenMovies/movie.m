//
//  movie.m
//  RottenMovies
//
//  Created by Muthukumar S on 6/8/14.
//  Copyright (c) 2014 Muthukumar S. All rights reserved.
//

#import "Movie.h"

@implementation Movie

-(id) initWithRottenTomatoesAPIResponse: (NSDictionary*) data{
    self = [super init];
    if (self) {
        
        NSLog(@"data object is %@" , data );
        
        self.title = [data valueForKey:@"title"];
        self.synopsis = [data valueForKey:@"synopsis"];
        self.thumbnail = [[data valueForKey:@"posters"] valueForKey:@"thumbnail"];
        self.poster = [[data valueForKey:@"posters"] valueForKey:@"original"];
        
    }
    return self;
}

@end
