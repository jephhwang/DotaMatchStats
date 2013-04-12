//
//  MSDetailViewController.m
//  MatchStats
//
//  Created by Jeff Wang on 2/1/13.
//  Copyright (c) 2013 Jeff Wang. All rights reserved.
//

#import "MSDetailViewController.h"
#import "MSViewController.h"
#import "MSMatch.h"

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
    int num = [self.playerNum integerValue];
    self.playerNameLabel.text = [[self.parentView.dataSrc objectAtIndex:num] objectForKey:@"PlayerName"];
    self.KDAlabel.text = [[self.parentView.dataSrc objectAtIndex:num] objectForKey:@"KDA"];
    self.levelLabel.text = [NSString stringWithFormat:@"%@",[[self.parentView.dataSrc objectAtIndex:num] objectForKey:@"level"]];
    self.xpmLabel.text = [NSString stringWithFormat:@"%@",[[self.parentView.dataSrc objectAtIndex:num] objectForKey:@"xpm"]];
    self.gpmLabel.text = [NSString stringWithFormat:@"%@",[[self.parentView.dataSrc objectAtIndex:num] objectForKey:@"gpm"]];
    self.csLabel.text = [NSString stringWithFormat:@"%@",[[self.parentView.dataSrc objectAtIndex:num] objectForKey:@"cs"]];
    self.denyLabel.text = [NSString stringWithFormat:@"%@",[[self.parentView.dataSrc objectAtIndex:num] objectForKey:@"denies"]];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    int num = [self.playerNum integerValue];
    NSNumber *heroIDnum = [[self.parentView.dataSrc objectAtIndex:num] objectForKey:@"HeroID"];
    NSString *imageName = [MSMatch getHeroNameWithID:[heroIDnum integerValue]];
    self.heroImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_sb", imageName]];
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
