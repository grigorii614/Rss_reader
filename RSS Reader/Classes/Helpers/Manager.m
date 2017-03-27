//
//  Manager.m
//

#import "Manager.h"

@interface Manager ()

@end

@implementation Manager

+ (instancetype)instance {
    static Manager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [Manager new];
    });
    return _instance;
}

+ (void)checkRSS
{
    NSArray *array = [Rss getAllRss];
    if (array.count <= 0)
    {
        [Rss saveRssByLink:@"https://habrahabr.ru/rss"];
        [Rss saveRssByLink:@"http://images.apple.com/main/rss/hotnews/hotnews.rss"];
        [Rss saveRssByLink:@"http://habrahabr.ru/rss"];
    }
}

+ (void)saveDB:(void (^)(BOOL completion))completion
{
    UIApplication *application = [UIApplication sharedApplication];
    
    __block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:bgTask];        bgTask = UIBackgroundTaskInvalid;
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [CONTEXT MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
            [application endBackgroundTask:bgTask];
            bgTask = UIBackgroundTaskInvalid;
            if (completion) {
                completion(YES);
            }
        }];
    });
}

+ (BOOL)checkInternetConnection
{
    NetworkStatus netStatus = [[AppDelegate instance].internetReachability currentReachabilityStatus];
    if(netStatus == ReachableViaWWAN || netStatus == ReachableViaWiFi) return YES;
    else return NO;
}

@end
