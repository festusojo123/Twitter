//
//  TweetCell.h
//  twitter
//
//  Created by festusojo on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

//declaring tweet properties so that these may be altered and appear updated in TimelineView Controller
@property (weak, nonatomic) IBOutlet UILabel *tweetNameBody;
@property (weak, nonatomic) IBOutlet UILabel *tweetBodyView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicView;
@property (nonatomic, strong) Tweet *tweet;
@property (weak, nonatomic) IBOutlet UILabel *twitterHandleView;
@property (weak, nonatomic) IBOutlet UILabel *dateView;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountView;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountView;
@property (weak, nonatomic) IBOutlet UIButton *favoriter;
@property (weak, nonatomic) IBOutlet UIButton *retweeter;

@end

NS_ASSUME_NONNULL_END
