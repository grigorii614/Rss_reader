//
//  News+Additions.m
//  Makeup
//
//  Created by Grigoriy Zaliva on 27.01.17.
//  Copyright © 2017 Grigoriy Zaliva. All rights reserved.
//

#import "Item+Additions.h"

@implementation Item (Additions)

+ (NSArray *)getAllItems
{
    return [Item MR_findAll];
}

+ (NSArray *) getAllItemByRss_Id:(NSString *)rss_Id
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"rss_id = %@", rss_Id];
    NSArray *results = [Item MR_findAllSortedBy:@"rss_id" ascending:YES withPredicate:predicate inContext:CONTEXT];
    
    return results;
}

+ (BOOL) saveItemFromDictionary:(NSDictionary *)dictionary rss:(Rss *)rss
{
    Item *item = [Item CREATE_ENTITY];
    
    item.rss_id = rss.rss_id;
    
    NSString *link = NULL_TO_NIL(dictionary[@"link"]);
    if (link) item.link = link;
    
    NSString *title = NULL_TO_NIL(dictionary[@"title"]);
    if (title) item.title = title;
    
    NSString *description = NULL_TO_NIL(dictionary[@"description"]);
    if (description) item.description_ = description;
    
    [Manager saveDB:nil];
    
    return YES;
}

+ (void) removeAllItemsByRss_Id:(NSString *)rss_Id
{
    NSArray *array = [Item getAllItemByRss_Id:rss_Id];
    
    [array enumerateObjectsUsingBlock:^(Item *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj MR_deleteEntityInContext:CONTEXT];
    }];
}

@end
