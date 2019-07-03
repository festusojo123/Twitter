//
//  TweetCell.h
//  twitter
//
//  Created by festusojo on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *tweetNameBody;
@property (weak, nonatomic) IBOutlet UILabel *tweetBodyView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicView;
@property (nonatomic, strong) NSArray *tweets;
@property (weak, nonatomic) IBOutlet UILabel *twitterHandleView;
@property (weak, nonatomic) IBOutlet UILabel *dateView;
@property (weak, nonatomic) IBOutlet UILabel *retweetCountView;
@property (weak, nonatomic) IBOutlet UILabel *favoriteCountView;


@end

NS_ASSUME_NONNULL_END
