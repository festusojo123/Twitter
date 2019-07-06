//  Tweet.h
#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

// baic properties API takes from each tweet
@property (nonatomic, strong) NSString *idStr; // For favoriting, retweeting & replying
@property (strong, nonatomic) NSString *text; // Text content of tweet
@property (nonatomic) int favoriteCount; // Update favorite count label
@property (nonatomic) BOOL favorited; // Configure favorite button
@property (nonatomic) int retweetCount; // Update favorite count label
@property (nonatomic) BOOL retweeted; // Configure retweet button
@property (strong, nonatomic) User *user; // Contains name, screenname, etc. of tweet author
@property (strong, nonatomic) NSString *createdAtString; // Display date

// same thing, but this data to be used later when RT'ing is enabled
@property (strong, nonatomic) User *retweetedByUser;  // user who retweeted if tweet is retweet
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries;

// Compose Tweets from APIManager.h
- (void)postStatusWithText:(void (^)(NSError *))completion;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
