//
//  DetailViewCtrl.h
//  RSS Reader
//
//  Created by Grigoriy Zaliva on 27.03.17.
//  Copyright © 2017 Grigoriy Zaliva. All rights reserved.
//

#import "BaseCtrl.h"

@class Item;

@interface DetailViewCtrl : BaseCtrl

@property (nonatomic, retain) Item *item;

@end

