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
   }


@end
