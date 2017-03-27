//
//  Makeup+Additions.h
//  Makeup
//
//  Created by Grigoriy Zaliva on 22.12.16.
//  Copyright © 2016 Grigoriy Zaliva. All rights reserved.
//

#import "Rss+CoreDataClass.h"

@interface Rss (Additions)

+ (NSArray *) getAllRss;
+ (Rss *) getRssById:(NSString *) rss_id;
+ (BOOL) saveRssByLink:(NSString *) link;

@end
