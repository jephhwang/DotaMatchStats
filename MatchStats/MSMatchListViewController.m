//
//  MSMatchListViewController.m
//  MatchStats
//
//  Created by Jeff Wang on 4/11/13.
//  Copyright (c) 2013 Jeff Wang. All rights reserved.
//

#import "MSMatchListViewController.h"
#import "MSMatchViewController.h"

@interface MSMatchListViewController ()

@end

@implementation MSMatchListViewController

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
    self.playerID = 54805394;
    
    self.navigationController.navigationBar.topItem.title = [NSString stringWithFormat:@"%u's Matches", self.playerID];
    
    //Fetch Lastest Matches for playerID
    NSURL *fetchURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?account_id=%u&key=FEA2FFAE6A7DCDAA954FA9138E35B351", self.playerID]];
    NSData *data = [[NSData alloc] initWithContentsOfURL:fetchURL];
    NSError *error;
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSDictionary *matches = [[dataDictionary objectForKey:@"result"] objectForKey:@"matches"];
    //NSLogDebug(@"%@", [matches description]);
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[matches count]];
    NSMutableArray *heroPlayedArray = [[NSMutableArray alloc] initWithCapacity:[matches count]];
    
    for (NSDictionary *match in matches) {
        [array addObject:[match objectForKey:@"match_id"]];
        for (NSDictionary *d in [match objectForKey:@"players"])
        {
            if ([[d objectForKey:@"account_id"] integerValue] == self.playerID) {
                [heroPlayedArray addObject:[d objectForKey:@"hero_id"]];
            }
        }
    }
    NSLogDebug(@"%@", [heroPlayedArray description]);
    NSLogDebug(@"%@", [array description]);
    
    matchList = [[NSArray alloc] initWithArray:array];
    heroPlayedList = [[NSArray alloc] initWithArray:heroPlayedArray];


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [matchList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSInteger row = [indexPath row];
    cell.textLabel.text = [[matchList objectAtIndex:row] description];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MSMatchViewController *matchController = [[MSMatchViewController alloc] initWithNibName:@"MSMatchViewController" bundle:nil];
    matchController.currentMatchID = [[matchList objectAtIndex:[indexPath row]] integerValue];
    [self.navigationController pushViewController:matchController animated:YES];
}

@end
