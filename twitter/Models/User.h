//  User.h
#import <Foundation/Foundation.h>

@interface User : NSObject

// declares the user properties from the main file so it can be used in other files
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSString *profilePic;

// initializes the dictionary of tweets/properties
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
