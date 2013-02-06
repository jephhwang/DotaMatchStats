//
//  MSDetailViewController.m
//  MatchStats
//
//  Created by Jeff Wang on 2/1/13.
//  Copyright (c) 2013 Jeff Wang. All rights reserved.
//

#import "MSDetailViewController.h"
#import "MSViewController.h"


@interface MSDetailViewController ()

@end

@implementation MSDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.playerNameLabel.text = [[self.parentView.dataSrc objectAtIndex:[self.playerNum integerValue]] objectForKey:@"PlayerName"];
    self.KDAlabel.text = [[self.parentView.dataSrc objectAtIndex:[self.playerNum integerValue]] objectForKey:@"KDA"];
    self.levelLabel.text = [NSString stringWithFormat:@"%@",[[self.parentView.dataSrc objectAtIndex:[self.playerNum integerValue]] objectForKey:@"level"]];
    self.xpmLabel.text = [NSString stringWithFormat:@"%@",[[self.parentView.dataSrc objectAtIndex:[self.playerNum integerValue]] objectForKey:@"xpm"]];
    self.gpmLabel.text = [NSString stringWithFormat:@"%@",[[self.parentView.dataSrc objectAtIndex:[self.playerNum integerValue]] objectForKey:@"gpm"]];
    self.csLabel.text = [NSString stringWithFormat:@"%@",[[self.parentView.dataSrc objectAtIndex:[self.playerNum integerValue]] objectForKey:@"cs"]];
    self.denyLabel.text = [NSString stringWithFormat:@"%@",[[self.parentView.dataSrc objectAtIndex:[self.playerNum integerValue]] objectForKey:@"denies"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
