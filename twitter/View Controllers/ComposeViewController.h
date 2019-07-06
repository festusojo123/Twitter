//
//  ComposeViewController.h
//  twitter
//
//  Created by festusojo on 7/3/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate
  //verifies that user did post a tweet so it can be aided to Tweet Array
- (void)didTweet:(Tweet *)tweet;
@end

@interface ComposeViewController : UIViewController
//calls delegate for ComposeView so it may be used in TimelineViewer
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
