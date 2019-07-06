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
    //these are the states for the two buttons and says when they'll be gray or green/red upon selection
    [self.favoriter setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    [self.favoriter setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected];
    [self.retweeter setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    [self.retweeter setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //the beginning of the protocol for the button's selected status
    [super setSelected:selected animated:animated];
}

//this is for retweeting
- (IBAction)didTapRT:(id)sender {// TODO: Update the local tweet model
    //if the tweet is new, its unselected
    //this first option assumes the button has been pressed before already
    if (self.tweet.retweeted){
        //this will make its status unretweeted, unselected, and decrease the RT count by 1
        self.tweet.retweeted = NO;
        self.retweeter.selected = NO;
        self.tweet.retweetCount -= 1;
        
    // this refreshes it to update page UI
    [self refreshData];
    
    // this sends a POST request to the POST RT/create endpoint to send a new rendering of the tweet
    [[APIManager shared] unrt:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            //for debugging
            NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
        }
    }];
}
    else{
        //fresh tweet, hitting the button will allow it be retweeted, the APIManager's outlet 
        //takes care of it being retweeted onto your timeline
        self.tweet.retweeted = YES;
        self.retweeter.selected = YES;
        self.tweet.retweetCount += 1;
        
        //updates cell UI by refreshing
        [self refreshData];
        
        // sends a POST request to the POST RT/create endpoint
        [[APIManager shared] rt:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
}

//this is for liking or favoriting a blank tweet
- (IBAction)didTapLike:(id)sender {
    //if the tweet is new, its unselected
    //this first option assumes the button has been pressed before already
    if (self.tweet.favorited){
    //the like goes away because it's been liked before and the count decreases 
    self.tweet.favorited = NO;
    self.favoriter.selected = NO;
    self.tweet.favoriteCount -= 1;
        
    //refreshes tweet data to update cell UI
    [self refreshData];
    
    //send a POST request to the POST favorites/create endpoint
    [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            //debugging 
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
}
    else{
        //fresh tweet, hitting the button will allow it be liked
        self.tweet.favorited = YES;
        self.favoriter.selected = YES;
        self.tweet.favoriteCount += 1;
        
        //updates cell UI by refreshing data
        [self refreshData];
        
        //send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                //for debugging in the console log 
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
}

- (void) refreshData {
    //set labels to respective text
    //we take each of the text fields provided from the Tweet file and now reset them so we
    //always have a fresh copy
    self.tweet = _tweet;
    self.tweetNameBody.text = _tweet.user.name;
    NSLog(@"%@", _tweet.user);
    self.twitterHandleView.text = _tweet.user.screenName;
    NSLog(@"%@", _tweet.idStr);
    self.tweetBodyView.text = _tweet.text;
    NSLog(@"%@", _tweet.text);
    self.dateView.text = _tweet.createdAtString;
    //this is for the url of the picture
    NSString *URLmodel= _tweet.user.profilePic;
    NSURL *profileURL = [NSURL URLWithString:URLmodel];
    self.profilePicView.image = nil;
    [self.profilePicView setImageWithURL:profileURL];
    //only true part of interest, but we do everything because other things may update as well
    self.favoriteCountView.text = [@(_tweet.favoriteCount) stringValue];
    self.retweetCountView.text = [@(_tweet.retweetCount) stringValue];
}

@end
