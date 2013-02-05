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
      NSArray* playerArray = [resultDict objectForKey:@"players"];//Players in JSON
    
      //initialize the players
      
      self.player0 = [[MSPlayer alloc] initWithDict:[playerArray objectAtIndex:0]];
      self.player1 = [[MSPlayer alloc] initWithDict:[playerArray objectAtIndex:1]];
      self.player2 = [[MSPlayer alloc] initWithDict:[playerArray objectAtIndex:2]];
      self.player3 = [[MSPlayer alloc] initWithDict:[playerArray objectAtIndex:3]];
      self.player4 = [[MSPlayer alloc] initWithDict:[playerArray objectAtIndex:4]];
      self.player5 = [[MSPlayer alloc] initWithDict:[playerArray objectAtIndex:5]];
      self.player6 = [[MSPlayer alloc] initWithDict:[playerArray objectAtIndex:6]];
      self.player7 = [[MSPlayer alloc] initWithDict:[playerArray objectAtIndex:7]];
      self.player8 = [[MSPlayer alloc] initWithDict:[playerArray objectAtIndex:8]];
      self.player9 = [[MSPlayer alloc] initWithDict:[playerArray objectAtIndex:9]];
      

  }
  heroNames = [NSDictionary dictionaryWithObject:@"test" forKey:[NSNumber numberWithInt:39]];
  return self;
}

- (NSString*)getHeroNameWithID:(int)heroID
{
  return [heroNames objectForKey:[NSNumber numberWithInt:heroID]];
}

- (NSArray*)getListOfAccountIDs
{
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
            [self.player9 accountID],nil];
}


@end
