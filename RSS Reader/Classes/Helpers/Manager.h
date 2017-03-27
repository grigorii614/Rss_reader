//
//  Manager.h


#import <Foundation/Foundation.h>

@class Lesson;

@interface Manager : NSObject

+ (instancetype)instance;

+ (void)checkRSS;
+ (void)saveDB:(void (^)(BOOL completion))completion;
+ (BOOL)checkInternetConnection;

@end
