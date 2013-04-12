//
//  MSMatch.h
//  MatchStats
//
//  Created by Jeff Wang on 2/1/13.
//  Copyright (c) 2013 Jeff Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSPlayer.h"

@interface MSMatch : NSObject {
    NSArray *playerArray;
}


- (id)initWithDict:(NSDictionary* )dict;
+ (NSString*)getHeroNameWithID:(int)heroID;
- (NSArray*)getListOfAccountIDs;
- (NSArray *) getPlayerArray;
-(MSPlayer *)getPlayer:(int)playerNumber;

//@property(strong, nonatomic) MSPlayer *player0,*player1,*player2,*player3,*player4,*player5,*player6,*player7,*player8,*player9;
//@property(strong, nonatomic) NSDictionary *heroNames;
@end
