//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "ComposeViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>;
//View controller has a tableView as a subview
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tweets;
@end

//passing the delegate and data source as part of the contract
@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>;
@end

@implementation TimelineViewController

- (IBAction)logOut:(id)sender {
    [UIApplication sharedApplication].delegate;
    //uses delegate 
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //returns to main function in storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //launches login view after being logged out
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize a UIRefreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    //View controller becomes its dataSource and delegate in viewDidLoad
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //calls itself to further effort
    [self APIRequestCall];
}


- (void)APIRequestCall{
    //Make an API request
    //API manager calls the completion handler passing back data, makes API requests on your behalf
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            //debugging in console, checks if it actually loaded
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.tweets = [NSArray arrayWithArray:tweets];
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}


// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
//View controller stores that data passed into the completion handler
- (void)beginRefresh:(UIRefreshControl *)refreshControl 
    [self APIRequestCall];
    // Tells the refreshControl to stop spinning
    [refreshControl endRefreshing];
}


//checks for memory issues
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//add tweets to array, already converted to this from dictionary by APIManager
- (void)didTweet:(Tweet *)tweet {
    [self.tweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}


//Table view asks its dataSource for numberOfRows & cellForRowAt
//numberOfRows returns the number of items returned from the API
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}


//cellForRow returns an instance of the custom cell with that reuse identifier with it’s elements populated with data at the index asked for
//Define a custom table view cell and set it’s reuse identifier
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //dequeues the prototype cell to be able to keep reloading with new info the API provides 
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.profilePicView.image = nil;
    //these are the fields from each tweet that are displayed in various view controllers
    Tweet* tweet = self.tweets[indexPath.row];
    cell.tweet = tweet;
    cell.tweetNameBody.text = tweet.user.name;
    cell.twitterHandleView.text = tweet.user.screenName;
    cell.tweetBodyView.text = tweet.text;
    cell.dateView.text = tweet.createdAtString;
    cell.favoriteCountView.text = [@(tweet.favoriteCount) stringValue];
    cell.retweetCountView.text = [@(tweet.retweetCount) stringValue];
    //has to use AFN to get profile pic for user using profileURL and has to begin as a string cast as a URL
    NSString *URLmodel= tweet.user.profilePic;
    NSURL *profileURL = [NSURL URLWithString:URLmodel];
    [cell.profilePicView setImageWithURL:profileURL];
    //launches tweet w all info now                          
    return cell;
}


#pragma mark - Navigation
//preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //uses segues for this
    UINavigationController *navigationController = [segue destinationViewController];
    //compose viewer goes to main page after, handled by storyboarding primarily in this project
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}

@end

