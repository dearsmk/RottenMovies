//
//  MovieDetailsViewController.m
//  RottenMovies
//
//  Created by Muthukumar S on 6/8/14.
//  Copyright (c) 2014 Muthukumar S. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "Movie.h"

@interface MovieDetailsViewController ()


@end

@implementation MovieDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if( self.view){
    // Displays a message box..
    //UIAlertView *messageAlert = [[UIAlertView alloc]
    //                             initWithTitle:@"Data" message:[NSString stringWithFormat:@"test : %d" , self.myValue]  delegate:nil //cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // Display Alert Message
    //[messageAlert show];
    }
    
    /*
    
    //self.movieTitle.text = [NSString stringWithFormat:@"%d", self.myValue];
    //NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/movies/770672122.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
   
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"%@", object);
        
        self.movieTitle.text = [ object objectForKey:@"title"];
        self.movieSynopsis.text = [object objectForKey:@"synopsis"];
        
        self.moviePoster.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:
                                                                                       [object objectForKey:@"posters" ][@"detailed"]]]];
        

        
    }];
    */
    
    //self.movieTitle.text = [self.selectedMovie title];
    //self.movieSynopsis.text = [self.selectedMovie synopsis];
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
