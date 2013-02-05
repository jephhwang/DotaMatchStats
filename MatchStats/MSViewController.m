//
//  MSViewController.m
//  MatchStats
//
//  Created by Jeff Wang on 2/1/13.
//  Copyright (c) 2013 Jeff Wang. All rights reserved.
//

#import "MSViewController.h"
#import "MSDetailViewController.h"
#import "MSPlayer.h"
#import "MSMatch.h"

@interface MSViewController ()
-(NSString *)stringWithTokens:(NSArray *)tokens;
-(void)apiTest;
@end

@implementation MSViewController

#pragma helper functions


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //set up a dummy data source here
    
    
    //UI Setup
    self.navigationController.navigationBar.topItem.title = @"Radiant";
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //do main thread shit here.
            //UI stuff ALWAYS goes on the main thread otherwise things will explode.
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        });
        
        // do background shit here.
        //Fetching Match Info
        NSNumber *matchID = [NSNumber numberWithInt:107459482];
        NSURL *fetchURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?match_id=%d&key=FEA2FFAE6A7DCDAA954FA9138E35B351", [matchID integerValue]]];
        NSData *data = [[NSData alloc] initWithContentsOfURL:fetchURL];
        NSError *error;
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
            self.match = [[MSMatch alloc] initWithDict:dataDictionary];
            //fetching player0 data
            /*
             NSURL *player0Url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=FEA2FFAE6A7DCDAA954FA9138E35B351&steamids=%d",[[self.match.player0 getAccountID] integerValue]]];
             NSData *player0data = [[NSData alloc] initWithContentsOfURL:player0Url];
             NSError *error;
             NSDictionary *player0profile = [NSJSONSerialization JSONObjectWithData:player0data options:0 error:&error];
             NSLog(@"%@", [player0profile description]);
             
             self.dataSrc = [[NSMutableArray alloc] initWithObjects:[self.match.player0 getAccountID], nil];
             */
            
            //self.dataSrc = [[NSMutableArray alloc] initWithObjects:@"jephh", @"pandaran", @"bcao", nil];
            self.dataSrc = [self createdataSrc];
            [self.tableView reloadData];
            //[self apiTest];
            
        });
    });
}

- (NSMutableArray*)createdataSrc
{
    NSMutableArray *dataSrc = [NSMutableArray arrayWithCapacity:10];
    NSArray *playerArray = [NSArray arrayWithObjects:self.match.player0,self.match.player1,self.match.player2,self.match.player3,self.match.player4,self.match.player5,self.match.player6,self.match.player7,self.match.player8,self.match.player9, nil];
    NSArray *displayNames = [self getDisplayNames];
    
    for (int i = 0; i<[playerArray count]; i++) {
        
        NSNumber *k = [[playerArray objectAtIndex:i] kills];
        NSNumber *d = [[playerArray objectAtIndex:i] deaths];
        NSNumber *a = [[playerArray objectAtIndex:i] assists];
        
        NSNumber *accountID = [displayNames objectAtIndex:i];
        NSString *kdaStr = [NSString stringWithFormat:@"%d/%d/%d", [k integerValue],
                            [d integerValue],
                            [a integerValue]];
        NSNumber *heroID = [[playerArray objectAtIndex:i] heroID];
        NSLog(@"%d",[heroID integerValue]);
        
        NSMutableDictionary *p0dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       accountID, @"PlayerName",
                                       heroID, @"HeroID",
                                       kdaStr, @"KDA", nil];
        
        [dataSrc addObject:p0dict];
    }
    
    return dataSrc;
}

-(NSString *)stringWithTokens:(NSArray *)tokens {
    NSMutableString *a = [[NSMutableString alloc] init];
    for (NSString *s in tokens) {
        if (s) {
            unsigned int steamid = [s integerValue];
            unsigned long long steamid64 = 76561197960265728;
            steamid64 += (unsigned long long)steamid;
            [a appendString:[NSString stringWithFormat:@"%llu,", steamid64]];
        }
    }
    return [[NSString alloc] initWithString:a];
}

- (NSArray*)getDisplayNames
{
        NSArray *accountIDs = [self.match getListOfAccountIDs];
        NSMutableArray *displayNames = [[NSMutableArray alloc] init];

        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
     
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            });
            NSMutableString *url = [[NSMutableString alloc] init];
            [url appendString:@"http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=FEA2FFAE6A7DCDAA954FA9138E35B351&steamids="];
            NSString *appendIDs = [self stringWithTokens:accountIDs];
            [url appendString:appendIDs];
            NSURL *fetchURL = [NSURL URLWithString:url];
            NSData *data = [[NSData alloc] initWithContentsOfURL:fetchURL];
            NSError *error;
            NSDictionary *profileDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSLogDebug(@"%@", [profileDictionary description]);
            /*
            NSDictionary *responseData = [profileDictionary objectForKey:@"response"];
            NSArray *playerArray = [responseData objectForKey:@"players"];
            for (NSDictionary *d in playerArray){
                    if([d count] != 0)
                    [displayNames addObject:[d objectForKey:@"personaname"]];
             
            }
             */
     
        });
     
    //return [NSArray arrayWithArray:displayNames];
    
    return [self.match getListOfAccountIDs];
}

- (void)apiTest
{
    @try {
        unsigned int steamid = 92107391;
        unsigned long long steamid64 = 76561197960265728;
        steamid64 += (unsigned long long)steamid;
        NSLogDebug(@"%llu", steamid64);
        NSURL *fetchURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=FEA2FFAE6A7DCDAA954FA9138E35B351&steamids=%llu", steamid64]];
        //NSURL *fetchURL = [NSURL URLWithString:@"http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=FEA2FFAE6A7DCDAA954FA9138E35B351&steamids=76561198052373119"];
        NSData *data = [[NSData alloc] initWithContentsOfURL:fetchURL];
        NSError *error;
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) NSLogDebug(@"%@", [error localizedDescription]);
        NSLog([dataDictionary description]);
    }
    @catch (NSException *e) {
        NSLogDebug(@"something got fked");
}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSrc count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    NSInteger row = [indexPath row];
    NSString *str = [[self.dataSrc objectAtIndex:row] objectForKey:@"PlayerName"];
    NSString *subtext = [[self.dataSrc objectAtIndex:row] objectForKey:@"KDA"];
    NSNumber *heroID = [[self.dataSrc objectAtIndex:row] objectForKey:@"HeroID"];
    NSString *imageName = [self.match getHeroNameWithID:[heroID integerValue]];
    
    UIImage *playerimage= [UIImage imageNamed:[NSString stringWithFormat:@"%@_sb.png", imageName]];
    cell.imageView.image = playerimage;
    
    if([str integerValue] == -1)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"Anonymous"];
    }
    else{
        cell.textLabel.text = [NSString stringWithFormat:@"%d", [str integerValue]];
    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"KDA: %@",subtext];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSDetailViewController *detailController = [[MSDetailViewController alloc] initWithNibName:@"MSDetailViewController"
                                                                                        bundle:nil];
    [self.navigationController pushViewController:detailController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

@end
