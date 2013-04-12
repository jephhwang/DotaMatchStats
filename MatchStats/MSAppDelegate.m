//
//  MSAppDelegate.m
//  MatchStats
//
//  Created by Jeff Wang on 2/1/13.
//  Copyright (c) 2013 Jeff Wang. All rights reserved.
//

#import "MSAppDelegate.h"

#import "MSMatchViewController.h"
#import "MSMatchListViewController.h"

@implementation MSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    MSMatchListViewController *viewController = [[MSMatchListViewController alloc] initWithNibName:@"MSMatchViewController" bundle:nil];
    /*
  MSMatchViewController *viewController = [[MSMatchViewController alloc] initWithNibName:@"MSMatchViewController"
                                                                        bundle:nil];
     */
  self.navController = [[UINavigationController alloc] initWithRootViewController:viewController];
  self.window.rootViewController = self.navController;
  [self.window makeKeyAndVisible];
    self.heroNames = [NSDictionary dictionaryWithObjectsAndKeys:
                                    @"antimage", [NSNumber numberWithInt:1],
                                      @"axe", [NSNumber numberWithInt:2],
                                    @"bane", [NSNumber numberWithInt:3],
                                    @"bloodseeker", [NSNumber numberWithInt:4],
                                    @"crystal_maiden", [NSNumber numberWithInt:5],
                                    @"drow_ranger", [NSNumber numberWithInt:6],
                                    @"earthshaker", [NSNumber numberWithInt:7],
                                    @"juggernaut", [NSNumber numberWithInt:8],
                                    @"mirana", [NSNumber numberWithInt:9],
                                    @"morphling", [NSNumber numberWithInt:10],
                                      @"nevermore", [NSNumber numberWithInt:11],
                                    @"phantom_lancer", [NSNumber numberWithInt:12],
                                    @"puck", [NSNumber numberWithInt:13],
                                    @"pudge", [NSNumber numberWithInt:14],
                                    @"razor", [NSNumber numberWithInt:15],
                                    @"sand_king", [NSNumber numberWithInt:16],
                                    @"storm_spirit", [NSNumber numberWithInt:17],
                                    @"sven", [NSNumber numberWithInt:18],
                                    @"tiny", [NSNumber numberWithInt:19],
                                    @"vengefulspirit", [NSNumber numberWithInt:20],
                                      @"windrunner", [NSNumber numberWithInt:21],
                                    @"zuus", [NSNumber numberWithInt:22],
                                    @"kunkka", [NSNumber numberWithInt:23],
                                    @"", [NSNumber numberWithInt:24],
                                      @"lina", [NSNumber numberWithInt:25],
                                    @"lion", [NSNumber numberWithInt:26],
                                    @"shadow_shaman", [NSNumber numberWithInt:27],
                                      @"slardar", [NSNumber numberWithInt:28],
                                    @"tidehunter", [NSNumber numberWithInt:29],
                                    @"witch_doctor", [NSNumber numberWithInt:30],
                                    @"", [NSNumber numberWithInt:31],
                                    @"riki", [NSNumber numberWithInt:32],
                                    @"enigma", [NSNumber numberWithInt:33],
                                    @"tinker", [NSNumber numberWithInt:34],
                                    @"sniper", [NSNumber numberWithInt:35],
                                    @"necrolyte", [NSNumber numberWithInt:36],
                                    @"warlock", [NSNumber numberWithInt:37],
                                    @"beastmaster", [NSNumber numberWithInt:38],
                                      @"queenofpain", [NSNumber numberWithInt:39],
                                      @"chaos_knight", [NSNumber numberWithInt:81],
                                      @"nyx_assassin", [NSNumber numberWithInt:88],
                                      @"keeper_of_the_light", [NSNumber numberWithInt:90],
                                      
                                      
                                      
                                      @"troll_warlord", [NSNumber numberWithInt:95],
                                      
                                      nil];
    

  return YES;
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
 {
 }
 */

/*
 // Optional UITabBarControllerDelegate method.
 - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
 {
 }
 */

@end
