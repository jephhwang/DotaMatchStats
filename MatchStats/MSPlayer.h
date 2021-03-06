//
//  MSPlayer.h
//  MatchStats
//
//  Created by Jeff Wang on 2/1/13.
//  Copyright (c) 2013 Jeff Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSPlayer : NSObject


- (id)initWithDict:(NSDictionary*)playerDict;

@property(strong, readonly, nonatomic) NSNumber *heroID;
@property(strong, readonly, nonatomic) NSNumber *accountID;
@property(strong, readonly, nonatomic) NSNumber *assists;
@property(strong, readonly, nonatomic) NSNumber *deaths;
@property(strong, readonly, nonatomic) NSNumber *kills;
@property(strong, readonly, nonatomic) NSNumber *endLevel;
@property(strong, readonly, nonatomic) NSNumber *xpm;
@property(strong, readonly, nonatomic) NSNumber *gpm;
@property(strong, readonly, nonatomic) NSNumber *cs;
@property(strong, readonly, nonatomic) NSNumber *denies;


@property(nonatomic) NSString* persona;
@property(strong, nonatomic) NSDictionary* playerInfo;

@end
