//
//  News+Additions.h
//  Makeup
//
//  Created by Grigoriy Zaliva on 27.01.17.
//  Copyright © 2017 Grigoriy Zaliva. All rights reserved.
//

#import "Item+CoreDataClass.h"

@interface Item (Additions)

+ (NSArray *)getAllItems;
+ (NSArray *) getAllItemByRss_Id:(NSString *)rss_Id;
+ (BOOL) saveItemFromDictionary:(NSDictionary *)dictionary rss:(Rss *)rss;

+ (void) removeAllItemsByRss_Id:(NSString *)rss_Id;

@end
