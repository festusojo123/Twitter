//
//  LoginViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "LoginViewController.h"
#import "APIManager.h"

@interface LoginViewController ()
@end

@implementation LoginViewController

    
//initial set up to begin loading page
- (void)viewDidLoad {
    [super viewDidLoad];
}

//checks for memory issues
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


//if you tap the login button on this page, you access this
- (IBAction)didTapLogin:(id)sender {
    //APIManager is called for OAuth verification
    [[APIManager shared] loginWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            //segue from login if successful
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
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
