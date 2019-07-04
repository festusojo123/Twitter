//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>;

//View controller has a tableView as a subview
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tweets;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize a UIRefreshControl
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    //View controller becomes its dataSource and delegate in viewDidLoad
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self APIRequestCall];
}
    

- (void)APIRequestCall{
        //Make an API request
    //API manager calls the completion handler passing back data, makes API requests on your behalf
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
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
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    
    [self APIRequestCall];

    // Tell the refreshControl to stop spinning
    [refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Table view asks its dataSource for numberOfRows & cellForRowAt
//numberOfRows returns the number of items returned from the API
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}


//cellForRow returns an instance of the custom cell with that reuse identifier with it’s elements populated with data at the index asked for
//Define a custom table view cell and set it’s reuse identifier
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.profilePicView.image = nil;
    
    Tweet* tweet = self.tweets[indexPath.row];
    //User* user = tweet.user;
    cell.tweetNameBody.text = tweet.user.name;
    NSLog(@"%@", tweet.user);
    cell.twitterHandleView.text = tweet.user.screenName;
    NSLog(@"%@", tweet.idStr);
    cell.tweetBodyView.text = tweet.text;
    NSLog(@"%@", tweet.text);
    cell.dateView.text = tweet.createdAtString;
    
    NSString *URLmodel= tweet.user.profilePic;
    NSURL *profileURL = [NSURL URLWithString:URLmodel];
    [cell.profilePicView setImageWithURL:profileURL];
    
    cell.favoriteCountView.text = [@(tweet.favoriteCount) stringValue];
    cell.retweetCountView.text = [@(tweet.retweetCount) stringValue];
    
   // cell.retweeter.switch = tweet.favorited;
   // cell.favoriter.switch = tweet.retweeted;
                            
    return cell;
}

@end

@protocol UITableViewDelegate<NSObject, UIScrollViewDelegate>

@optional

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
