//
//  MSMatchListViewController.h
//  MatchStats
//
//  Created by Jeff Wang on 4/11/13.
//  Copyright (c) 2013 Jeff Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSMatchListViewController : UITableViewController
{
    NSArray *matchList, *heroPlayedList;
}

@property (nonatomic) int playerID;

@end
