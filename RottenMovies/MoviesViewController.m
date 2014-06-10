//
//  MoviesViewController.m
//  RottenMovies
//
//  Created by Muthukumar S on 6/7/14.
//  Copyright (c) 2014 Muthukumar S. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "MovieDetailsViewController.h"
#import "Movie.h"
#import <MBProgressHUD.h>
#import "UIImageView+AFNetworking.h"

#import <QuartzCore/QuartzCore.h>
#import "ODRefreshControl/ODRefreshControl.h"


@interface MoviesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong) NSArray *movies;
@property(nonatomic) long *lastSelectedMovieId;

@property (strong, nonatomic) MBProgressHUD *HUD;
@property (weak, nonatomic) IBOutlet UILabel *networkErrorLable;

@end

@implementation MoviesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Movies";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    self.HUD.dimBackground = YES;
    // Regiser for HUD callbacks so we can remove it from the window at the right time
    self.HUD.delegate = self;
    self.HUD.labelText = @"Loading..";
    [self.HUD show:TRUE];
    
    ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    refreshControl.tintColor = [UIColor grayColor];
    
    [refreshControl addTarget:self action:@selector(refreshTableViewHandler:) forControlEvents:UIControlEventValueChanged];
    [self loadDataFromAPI];
    
 
    
}

- (void) refreshTableViewHandler:(ODRefreshControl*) refreshControl {
    NSLog(@"refresh Handler is being called....");
    [self loadDataFromAPI];
    [refreshControl endRefreshing];
}

-(void) loadDataFromAPI {
    NSLog(@"Load data method is trying to refresh the data....");
    NSString *url = @"http://11api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
    //NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=g9au4hv6khv6wzvzgt55gpqs";
  
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            
            if(data){
                self.networkErrorLable.hidden=YES;
                id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                self.tableView.rowHeight=90;
          
                self.networkErrorLable.hidden=YES;
                NSLog(@"No Connection error occured...%ld", (long)[httpResponse statusCode] );
                self.movies = object[@"movies"];
                [self.tableView reloadData];
                [self.HUD hide:TRUE];
                
                [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
            }else{
                if( connectionError ){
                    
                    NSLog(@"Connection error occured...");
                    [self.HUD hide:TRUE];
                    self.networkErrorLable.text= @"Network Error";
                    self.networkErrorLable.hidden=NO;
                    self.tableView.hidden=YES;
                }
            }
            
        }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"cell for row at index path %d" , indexPath.row );
    
    //UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:nil];
    
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell" ];
    
    NSDictionary *movie = self.movies[indexPath.row];
    
    //cell.textLabel.text = movie[@"title"];
    cell.movieTitleLabel.text = movie[@"title"];
    cell.movieSynopsisLabel.text = movie[@"synopsis"];
    
    NSURL *url = [NSURL URLWithString:[movie[@"posters"] objectForKey:@"thumbnail" ]];
    
    //cell.movilePosterImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[movie[@"posters"] objectForKey:@"thumbnail" ]]]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url];
    
    [request setHTTPShouldHandleCookies:NO];
    [request setHTTPShouldUsePipelining:YES];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    
    __weak MovieCell *weakCell = cell;
    
    [cell.movilePosterImageView setImageWithURLRequest: request
                                placeholderImage:nil
                                         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                             
                                             weakCell.movilePosterImageView.image = image;
                                             
                                         }
     
                                         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                             NSLog(@"image fetch failed!");
                                             [self.HUD hide:TRUE];
                                             
                                         }
     ];
    
    //NSLog(@"thumbnail url is %@" ,[movie[@"posters"] objectForKey:@"thumbnail" ] );
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Displays a message box..
    /*UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // Display Alert Message
    [messageAlert show];*/
    
    //Displays a check mark when user selects row
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    // removes the selected row's background selection
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // change background color of selected cell
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor blueColor]];
    [cell setSelectedBackgroundView:bgColorView];
    

    MovieDetailsViewController *detailViewController = [[MovieDetailsViewController alloc] initWithNibName:@"MovieDetailsViewController" bundle:nil];



    detailViewController.title = @"Details View";
    
    if (detailViewController.view) {
        NSDictionary *movie = self.movies[indexPath.row];
        
        detailViewController.movieTitle.text = [movie objectForKey:@"title"];
        detailViewController.movieSynopsis.text = [movie objectForKey:@"synopsis"];
        
        detailViewController.moviePoster.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: [movie objectForKey:@"posters" ][@"detailed"]]]];
    
    }
    
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    
    
}


- (void)pullme
{
    NSLog(@"this is a pull request....");
}


@end
