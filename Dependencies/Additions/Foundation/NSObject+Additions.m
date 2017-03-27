//
//  NSObject(Additions).m
//  Dependencies
//

#import "NSObject+Additions.h"

@implementation NSObject (Additions)

+ (id)instanceWithXib:(NSString *)xibName
{
    return [[self alloc] initWithNibName:xibName bundle:[NSBundle mainBundle]];
}

+ (id)instanceFromXib
{
	return [self instanceWithXib: NSStringFromClass(self.class)];
}

- (void) performBlock: (void (^)(void)) block afterDelay: (NSTimeInterval) delay
{
    int64_t delta = (int64_t) (1.0e9 * delay);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_main_queue(), block);
}

+ (NSString*) className { return NSStringFromClass(self.class); }
- (NSString*) className { return NSStringFromClass(self.class); }

@end
