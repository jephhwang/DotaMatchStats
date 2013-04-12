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

const int testMatchID = 107459482;


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
    self.navigationController.navigationBar.topItem.title = [NSString stringWithFormat:@"Match %u", testMatchID];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //do main thread shit here.
            //UI stuff ALWAYS goes on the main thread otherwise things will explode.
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        });
        
        // do background shit here.
        //Fetching Match Info
        NSNumber *matchID = [NSNumber numberWithInt:testMatchID];
        NSURL *fetchURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?match_id=%d&key=FEA2FFAE6A7DCDAA954FA9138E35B351", [matchID integerValue]]];
        NSData *data = [[NSData alloc] initWithContentsOfURL:fetchURL];
        NSError *error;
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            
            self.match = [[MSMatch alloc] initWithDict:dataDictionary];
            [self createdataSrc];
            //[self apiTest];
            
        });
    });
}

- (void)createdataSrc
{
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSInvocationOperation *op = [[NSInvocationOperation alloc]
                                 initWithTarget:self
                                 selector:@selector(performProfileFetch)
                                 object:nil];
    NSInvocationOperation *op1 = [[NSInvocationOperation alloc]
                                  initWithTarget:self
                                  selector:@selector(updateUI:)
                                  object:op];
    [op1 addDependency:op];
    [queue addOperation:op];
    [queue addOperation:op1];


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

-(void)updateUI:(NSInvocationOperation *)previousOp {
    //update whatever tableview reads from here
    NSArray *displayNames = [previousOp result];
    //do whatever you were doing before w/displayNames here
    NSMutableArray *dataSrc = [NSMutableArray arrayWithCapacity:10];
    /*
    NSArray *playerArray = [NSArray arrayWithObjects:self.match.player0,self.match.player1,self.match.player2,self.match.player3,self.match.player4,self.match.player5,self.match.player6,self.match.player7,self.match.player8,self.match.player9, nil];
    */
    NSArray *playerArray = [self.match getPlayerArray];
    NSLogDebug(@"%@", [displayNames description]);
    for (int i = 0; i<10; i++) {
        
        NSNumber *k = [[playerArray objectAtIndex:i] kills];
        NSNumber *d = [[playerArray objectAtIndex:i] deaths];
        NSNumber *a = [[playerArray objectAtIndex:i] assists];
        NSNumber *level = [[playerArray objectAtIndex:i] endLevel];
        NSNumber *xpm = [[playerArray objectAtIndex:i] xpm];
        NSNumber *gpm = [[playerArray objectAtIndex:i] gpm];
        NSNumber *cs = [[playerArray objectAtIndex:i] cs];
        NSNumber *denies = [[playerArray objectAtIndex:i] denies];
        
        NSNumber *accountID = [displayNames objectAtIndex:i];
        NSString *kdaStr = [NSString stringWithFormat:@"%d/%d/%d", [k integerValue],
                            [d integerValue],
                            [a integerValue]];
        NSNumber *heroID = [[playerArray objectAtIndex:i] heroID];
        NSMutableDictionary *p0dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       accountID, @"PlayerName",
                                       heroID, @"HeroID",
                                       kdaStr, @"KDA",
                                       level, @"level",
                                       xpm, @"xpm",
                                       gpm, @"gpm",
                                       cs, @"cs",
                                       denies, @"denies",nil];
        
        [dataSrc addObject:p0dict];
    }
    self.dataSrc = dataSrc;
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

-(NSArray*)performProfileFetch {
    NSArray *accountIDs = [self.match getListOfAccountIDs];
    NSMutableArray *displayNames = [[NSMutableArray alloc] init];
    
    NSMutableString *url = [[NSMutableString alloc] init];
    [url appendString:@"http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=FEA2FFAE6A7DCDAA954FA9138E35B351&steamids="];
    NSString *appendIDs = [self stringWithTokens:accountIDs];
    [url appendString:appendIDs];
    NSURL *fetchURL = [NSURL URLWithString:url];
    NSData *data = [[NSData alloc] initWithContentsOfURL:fetchURL];
    NSError *error;
    NSDictionary *profileDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSDictionary *responseData = [profileDictionary objectForKey:@"response"];
    NSArray *playerArray = [responseData objectForKey:@"players"];
    
    //convert the 64bit back to 32bit ID and add to dict
    NSMutableDictionary *IDtoDisplayName = [[NSMutableDictionary alloc] init];
    for (NSDictionary *d in playerArray){
        NSString *temp = [d objectForKey:@"steamid"];
        unsigned long long id64 = [temp longLongValue];
        unsigned long long id32 = id64 - 76561197960265728;
        [IDtoDisplayName setObject:[d objectForKey:@"personaname"] forKey:[NSNumber numberWithInt:(int)id32]];
    }
    
    //Checks if IDs have corresponding display name
    NSArray *IDsWithDisplayName = [IDtoDisplayName allKeys];
    for (NSNumber *num in accountIDs) {
        if ([IDsWithDisplayName indexOfObject:num] != NSNotFound) {
            [displayNames addObject:[IDtoDisplayName objectForKey:num]];
        }
        else{
            [displayNames addObject:@"Anonymous"];
        }
    }
    
    return [NSArray arrayWithArray:displayNames];
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

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    if (row <= 4) {
        cell.backgroundColor = [[UIColor alloc] initWithRed:124.0f/255.0f green:205.0f/255.0f blue:124.0f/255.0f alpha:1];
    }
    else{
        cell.backgroundColor = [[UIColor alloc] initWithRed:139.0f/255.0f green:62.0f/255.0f blue:47.0f/255.0f alpha:1];
    }
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
    NSString *imageName = [MSMatch getHeroNameWithID:[heroID integerValue]];
    
    UIImage *playerimage= [UIImage imageNamed:[NSString stringWithFormat:@"%@_sb.png", imageName]];
    cell.imageView.image = playerimage;
    
    //cell.textLabel.text = [NSString stringWithFormat:@"%d", [str integerValue]];
    cell.textLabel.text = str;
   
    cell.detailTextLabel.text = [NSString stringWithFormat:@"KDA: %@",subtext];
   
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MSDetailViewController *detailController = [[MSDetailViewController alloc] initWithNibName:@"MSDetailViewController"
                                                                                        bundle:nil];
    detailController.parentView = self;
    detailController.playerNum = [NSNumber numberWithInt:[indexPath row]];
    [self.navigationController pushViewController:detailController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

@end
