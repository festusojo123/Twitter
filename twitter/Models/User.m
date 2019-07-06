//
//  User.m
//  AFNetworking
//
//  Created by festusojo on 7/1/19.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
    //these are the different user categories, specific to a user and repeatable for multiple tweets compared to tweet details that are specific to each particular tweet
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePic = dictionary[@"profile_image_url_https"];
        // Initialize any other properties
    }
    return self;
}
@end
