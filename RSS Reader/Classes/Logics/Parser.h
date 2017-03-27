//
//  Manager.h
//  Travel
//
//  Created by Eugene Vegner on 08.05.15.
//  Copyright (c) 2015 Eugene Vegner. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Rss;

@protocol ParserDelegate <NSObject>

@optional

- (void) parserDidFinish;

@end

@interface Parser : NSObject

@property (nonatomic, weak) id <ParserDelegate> delegate;


- (void)parseRss:(Rss *) rss delegate:(id) delegate;

+ (instancetype)instance;

@end
