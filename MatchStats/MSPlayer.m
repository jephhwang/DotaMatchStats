//
//  MSPlayer.m
//  MatchStats
//
//  Created by Jeff Wang on 2/1/13.
//  Copyright (c) 2013 Jeff Wang. All rights reserved.
//

#import "MSPlayer.h"

@implementation MSPlayer
- (id)initWithDict:(NSDictionary*)playerDict
{
  self = [super init];
  if(self){
    self.playerInfo = playerDict;
    
  }
  return self;
}

- (NSNumber *)heroID
{
  return [self.playerInfo objectForKey:@"hero_id"];
}

-(NSNumber *)kills {
  return [self.playerInfo objectForKey:@"kills"];
}

-(NSNumber *)accountID
{
  return [self.playerInfo objectForKey:@"account_id"];
}

- (NSNumber *)assists
{
  return [self.playerInfo objectForKey:@"assists"];
}

- (NSNumber *)deaths
{
  return [self.playerInfo objectForKey:@"deaths"];
}

- (NSNumber *)endLevel
{
    return [self.playerInfo objectForKey:@"level"];
}

- (NSNumber *)xpm
{
    return [self.playerInfo objectForKey:@"xp_per_min"];
}

- (NSNumber *)gpm
{
    return [self.playerInfo objectForKey:@"gold_per_min"];
}

- (NSNumber *)cs
{
    return [self.playerInfo objectForKey:@"last_hits"];
}

- (NSNumber *)denies
{
    return [self.playerInfo objectForKey:@"denies"];
}

@end
