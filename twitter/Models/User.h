//  User.h
#import <Foundation/Foundation.h>

@interface User : NSObject

// MARK: Properties
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;

// Create initializer
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

// Add any additional properties here
@end
