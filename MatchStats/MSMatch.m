//
//  MSMatch.m
//  MatchStats
//
//  Created by Jeff Wang on 2/1/13.
//  Copyright (c) 2013 Jeff Wang. All rights reserved.
//

#import "MSMatch.h"

@implementation MSMatch


- (id)initWithDict:(NSDictionary* )dict
{
  self = [super init];
  if(self){
      NSDictionary* resultDict = [dict objectForKey:@"result"];
      NSArray* playerData = [resultDict objectForKey:@"players"];//Players in JSON
      
      NSMutableArray *array = [NSMutableArray arrayWithCapacity:[playerData count]];
      for (int i = 0; i < [playerData count]; i++) {
          array[i] = [[MSPlayer alloc] initWithDict:[playerData objectAtIndex:i]];
      }
      playerArray = [[NSArray alloc] initWithArray:array];
    
      //initialize the players
      
      /*
      self.player0 = [[MSPlayer alloc] initWithDict:[playerData objectAtIndex:0]];
      self.player1 = [[MSPlayer alloc] initWithDict:[playerData objectAtIndex:1]];
      self.player2 = [[MSPlayer alloc] initWithDict:[playerData objectAtIndex:2]];
      self.player3 = [[MSPlayer alloc] initWithDict:[playerData objectAtIndex:3]];
      self.player4 = [[MSPlayer alloc] initWithDict:[playerData objectAtIndex:4]];
      self.player5 = [[MSPlayer alloc] initWithDict:[playerData objectAtIndex:5]];
      self.player6 = [[MSPlayer alloc] initWithDict:[playerData objectAtIndex:6]];
      self.player7 = [[MSPlayer alloc] initWithDict:[playerData objectAtIndex:7]];
      self.player8 = [[MSPlayer alloc] initWithDict:[playerData objectAtIndex:8]];
      self.player9 = [[MSPlayer alloc] initWithDict:[playerData objectAtIndex:9]];
      */

  }
  
  return self;
}

-(MSPlayer *)getPlayer:(int)playerNumber {
    if (playerNumber > [playerArray count]) {
        return NULL;
    }
    return [playerArray objectAtIndex:playerNumber];
}

- (NSArray *)getPlayerArray{
    
    return playerArray;
}

+ (NSString*)getHeroNameWithID:(int)heroID
{
    MSAppDelegate *appDelagate = [[UIApplication sharedApplication] delegate];
    return [appDelagate.heroNames objectForKey:[NSNumber numberWithInt:heroID]];
}

- (NSArray*)getListOfAccountIDs
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[playerArray count]];
    for (int i = 0; i< [playerArray count]; i++) {
        array[i] = [playerArray[i] accountID];
    }
    
    NSArray *returnArray = [[NSArray alloc] initWithArray:array];
    return returnArray;
    /*
    return [NSArray arrayWithObjects:
            [self.player0 accountID],
            [self.player1 accountID],
            [self.player2 accountID],
            [self.player3 accountID],
            [self.player4 accountID],
            [self.player5 accountID],
            [self.player6 accountID],
            [self.player7 accountID],
            [self.player8 accountID],
            [self.player9 accountID],nil]; */
}


@end
