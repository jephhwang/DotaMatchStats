//
//  MSDetailViewController.h
//  MatchStats
//
//  Created by Jeff Wang on 2/1/13.
//  Copyright (c) 2013 Jeff Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSViewController.h"

@interface MSDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *heroImage, *item0, *item1, *item2, *item3, *item4, *item5;
@property (strong, nonatomic) IBOutlet UILabel *playerNameLabel, *KDAlabel, *csLabel, *denyLabel, *levelLabel, *gpmLabel, *xpmLabel;
@property (weak, nonatomic) MSViewController *parentView;
@property (nonatomic) NSNumber *playerNum;

@end
