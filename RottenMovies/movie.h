//
//  movie.h
//  RottenMovies
//
//  Created by Muthukumar S on 6/8/14.
//  Copyright (c) 2014 Muthukumar S. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property NSString *title;
@property NSString *thumbnail;
@property NSString *poster;
@property NSString *synopsis;

@property NSString *muthu;

-(id) initWithRottenTomatoesAPIResponse: (NSDictionary*) data;

@end
