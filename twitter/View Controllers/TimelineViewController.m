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


@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *tweets;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    cell.profilePicView.image = nil;
    
    Tweet* tweet = self.tweets[indexPath.row];
    User* user = tweet.user;
    cell.tweetNameBody.text = [@(tweet.user) stringValue];
    NSLog(@"%@", tweet.user);
    cell.twitterHandleView.text = tweet.idStr;
    NSLog(@"%@", tweet.idStr);
    cell.tweetBodyView.text = tweet.text;
    NSLog(@"%@", tweet.text);
    cell.dateView.text = tweet.createdAtString;
    
    cell.favoriteCountView.text = [@(tweet.favoriteCount) stringValue];
    cell.retweetCountView.text = [@(tweet.retweetCount) stringValue];
    
   // cell.jbdkbdk.text = tweet.favorited;
   // cell.jbdkbdk.text = tweet.retweeted;
    
    //idk how images work
     //   NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
     //   NSString *posterURLString = movie[@"poster_path"];
     //   NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
        
     //   NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
     //   [cell.profilePicView setImageWithURL:??????];
                            
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
