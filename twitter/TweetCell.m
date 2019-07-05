//
//  TweetCell.m
//  twitter
//
//  Created by festusojo on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "APIManager.h"
#import "TimelineViewController.h"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapRT:(id)sender {// TODO: Update the local tweet model
    self.tweet.retweeted = YES;
    self.tweet.retweetCount += 1;
    
    // TODO: Update cell UI
    [self refreshData];
    
    // TODO: Send a POST request to the POST RT/create endpoint
    [[APIManager shared] rt:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
}


- (IBAction)didTapLike:(id)sender {
    // TODO: Update the local tweet model
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    
    // TODO: Update cell UI
    [self refreshData];
    
    // TODO: Send a POST request to the POST favorites/create endpoint
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
}

- (void) refreshData {
    //set labels to respective text?
    self.tweet = _tweet;
    self.tweetNameBody.text = _tweet.user.name;
    NSLog(@"%@", _tweet.user);
    self.twitterHandleView.text = _tweet.user.screenName;
    NSLog(@"%@", _tweet.idStr);
    self.tweetBodyView.text = _tweet.text;
    NSLog(@"%@", _tweet.text);
    self.dateView.text = _tweet.createdAtString;
    
    NSString *URLmodel= _tweet.user.profilePic;
    NSURL *profileURL = [NSURL URLWithString:URLmodel];
    
    self.profilePicView.image = nil;
    [self.profilePicView setImageWithURL:profileURL];
    
    self.favoriteCountView.text = [@(_tweet.favoriteCount) stringValue];
    self.retweetCountView.text = [@(_tweet.retweetCount) stringValue];
}

@end
