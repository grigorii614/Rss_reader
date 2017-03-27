//
//  AppDelegate.h
//  RSS Reader
//
//  Created by Grigoriy Zaliva on 26.03.17.
//  Copyright © 2017 Grigoriy Zaliva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

+ (AppDelegate*) instance;

@end

