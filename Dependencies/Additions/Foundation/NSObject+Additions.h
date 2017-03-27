//
//  NSObject(Additions).h
//  TDependencies
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (Additions)

+ (NSString *)className;
- (NSString *)className;

+ (id)instanceWithXib:(NSString *)xibName;
+ (id)instanceFromXib;

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;


@end
