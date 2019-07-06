//
//  ComposeViewController.m
//  twitter
//
//  Created by festusojo on 7/3/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (nonatomic, readwrite, strong) IBOutlet UITextView *ComposeTweetView;
@end

@implementation ComposeViewController

//after tweet successfully posts, it goes back to the timeline
- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

//this sends off the tweet
- (IBAction)tweetAction:(id)sender {
    [[APIManager shared] postStatusWithText:_ComposeTweetView.text completion:^(Tweet *newTweet, NSError *invalidText) {
        //this condition only occurs if it is successful, ands adds the new tweet to the array later
        if (newTweet) {
            NSLog(@"tweet success");
            [self.delegate didTweet:newTweet];
        }
        //if it fails, it will return the error and get into this condition
        else {
            NSLog(@"tweet failed %@", invalidText.localizedDescription);
        }
        //dismisses the page back
        [self dismissViewControllerAnimated:true completion:nil];
    }];
}

//calls itself to make sure page loads
- (void)viewDidLoad {
    [super viewDidLoad];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
