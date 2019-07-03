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
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        // Initialize any other properties
    }
    return self;
}
@end
