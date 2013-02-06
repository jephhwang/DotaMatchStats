//
//  MSViewController.h
//  MatchStats
//
//  Created by Jeff Wang on 2/1/13.
//  Copyright (c) 2013 Jeff Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSMatch;
@interface MSViewController : UITableViewController

- (void)createdataSrc;
- (NSArray*)getDisplayNames;

@property(strong, nonatomic) MSMatch *match;
@property(strong, nonatomic) NSMutableArray *dataSrc;

@end
