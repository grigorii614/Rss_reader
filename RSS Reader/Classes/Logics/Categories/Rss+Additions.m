//
//  Makeup+Additions.m
//  Makeup
//
//  Created by Grigoriy Zaliva on 22.12.16.
//  Copyright © 2016 Grigoriy Zaliva. All rights reserved.
//

#import "Rss+Additions.h"

@implementation Rss (Additions)

+ (Rss *) getRssById:(NSString *) rss_id
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id = %@", rss_id];
    NSArray *results = [Rss MR_findAllSortedBy:@"sort_order" ascending:YES withPredicate:predicate inContext:CONTEXT];
    
    if (results.count == 1)
        return [results objectAtIndex:0];
    else
        return nil;
}

+ (BOOL) saveRssByLink:(NSString *)link
{
    Rss *rss = [Rss CREATE_ENTITY];
    rss.link = link;
    rss.rss_id = [NSString stringWithFormat:@"%zd", RANDOM_INT(1, 1000)];
    
    [Manager saveDB:nil];

    return YES;
}

+ (NSArray *) getAllRss
{
    return [Rss MR_findAll];
}

/*- (void) setMakeup:(Makeup *) makeup fromDictionary:(NSDictionary *)dictionary
{
    NSString *_id = NULL_TO_NIL(dictionary[@"id"]);
    if (_id) makeup.id = [NSString stringWithFormat:@"%@", _id];
    
    NSString *title = NULL_TO_NIL(dictionary[@"title"]);
    if (title) makeup.title = [NSString stringWithFormat:@"%@", title];
    
    NSString *description_ = NULL_TO_NIL(dictionary[@"description"]);
    if (description_) makeup.description_ = [NSString stringWithFormat:@"%@", description_];
    
    NSString *image = NULL_TO_NIL(dictionary[@"image"]);
    if (image) makeup.image = [NSString stringWithFormat:@"%@", image];
    
    NSString *price = NULL_TO_NIL(dictionary[@"price_(ios)"]);
    if (price) makeup.price = [NSString stringWithFormat:@"%@", price];
    
    NSString *sort_order = NULL_TO_NIL(dictionary[@"sort_order"]);
    if (sort_order) makeup.sort_order = [dictionary[@"sort_order"] intValue];
    
    makeup.productId = [NSString stringWithFormat:@"%@", [Makeup getProductId:title]];
}*/

@end
