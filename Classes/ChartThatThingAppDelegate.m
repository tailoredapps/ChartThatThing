//
//  ChartThatThingAppDelegate.m
//  ChartThatThing
//
//  Created by Hannes Satz on 04/06/2010.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ChartThatThingAppDelegate.h"
#import "ChartThatThingViewController.h"

@implementation ChartThatThingAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
