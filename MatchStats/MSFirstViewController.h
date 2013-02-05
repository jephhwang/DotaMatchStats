//
//  MSFirstViewController.h
//  MatchStats
//
//  Created by Jeff Wang on 2/1/13.
//  Copyright (c) 2013 Jeff Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSMatch.h"

@interface MSFirstViewController : UIViewController

@property(strong, nonatomic) MSMatch* match;
@property(strong, nonatomic) IBOutlet UILabel* player0label;
@property(strong, nonatomic) IBOutlet UILabel* player0hero;
@property(strong, nonatomic) IBOutlet UILabel* player0KDA;

@end
