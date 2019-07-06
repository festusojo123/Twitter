//
//  APIManager.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "APIManager.h"
#import "Tweet.h"
#import "ComposeViewController.h"

static NSString * const baseURLString = @"https://api.twitter.com";
static NSString * const consumerKey = @"5lUJuO5AUpPUCez4ewYDFrtgh";
static NSString * const consumerSecret = @"s5ynGqXzstUZwFPxVyMDkYh197qvHOcVM3kwv1o2TKhS1avCdS";

@interface APIManager()

@end

@implementation APIManager

//this first method makes sure the APIManager's results can be used throughout files when first instantiated
+ (instancetype)shared {
    static APIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
//instaniates the APIManager 
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSString *key = consumerKey;
    NSString *secret = consumerSecret;
    // Check for launch arguments override
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"]) {
        key = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"];
    }
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-secret"]) {
        secret = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-secret"];
    }
    //this handles the OAuth login
    self = [super initWithBaseURL:baseURL consumerKey:key consumerSecret:secret];
    if (self) {       
    }
    return self;
}

//this handles liking the tweet
- (void)favorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion{
    //liking tweet endpoint, per Twitter's API
    NSString *urlString = @"1.1/favorites/create.json";
    NSDictionary *parameters = @{@"id": tweet.idStr};
    //post request to post this new updated info to the Tweet Dictionary before being added to array later
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

//this handles unliking a tweet
- (void)unfavorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion{
     //unliking tweet endpoint, per Twitter's API
    NSString *urlString = @"1.1/favorites/destroy.json";
    NSDictionary *parameters = @{@"id": tweet.idStr};
    //post request to post this new updated info to the Tweet Dictionary before being added to array later
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

//this handles retweeting a tweet
- (void)rt:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion{
     //retweeting tweet endpoint, per Twitter's API    
    NSString *urlString = [NSString stringWithFormat: @"1.1/statuses/retweet/%@.json",tweet.idStr];
    NSDictionary *parameters = @{@"id": tweet.idStr};
    //post request to post this new updated info to the Tweet Dictionary before being added to array later
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

//this handles unretweeting a tweet
- (void)unrt:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion{
     //unretweeting tweet endpoint, per Twitter's API      
    NSString *urlString = [NSString stringWithFormat: @"1.1/statuses/unretweet/%@.json",tweet.idStr];
    NSDictionary *parameters = @{@"id": tweet.idStr};
    //post request to post this new updated info to the Tweet Dictionary before being added to array later
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

//Updates the authenticating user's current status, also known as Tweeting
- (void)postStatusWithText:(NSString *)text completion:(void (^)(Tweet *, NSError *))completion{
    //update twitter endpoint, per Twitter's API   
    NSString *urlString = @"1.1/statuses/update.json";
    NSDictionary *parameters = @{@"status": text};
    //post request to allow tweeting to commence 
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

//goes back to the timeline page
- (void)getHomeTimelineWithCompletion:(void(^)(NSArray *tweets, NSError *error))completion {
    // Create a GET Request, no new info to POST
    [self GET:@"1.1/statuses/home_timeline.json"
   parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nullable tweetDictionaries) {
       // Success
       NSMutableArray *tweets  = [Tweet tweetsWithArray:tweetDictionaries];
       completion(tweets, nil);
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       // There was a problem, this goes in to the error output
       completion(nil, error);
   }];
}

@end
