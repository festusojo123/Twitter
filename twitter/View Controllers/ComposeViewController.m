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


- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


- (IBAction)tweetAction:(id)sender {
    [[APIManager shared] postStatusWithText:@"hey" completion:^(Tweet *newTweet, NSError *invalidText) {
        if (newTweet) {
            NSLog(@"tweet success");
        }
        else {
            NSLog(@"tweet failed %@", invalidText.localizedDescription);
        }
        [self dismissViewControllerAnimated:true completion:nil];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
