//
//  ChartThatThingAppDelegate.h
//  ChartThatThing
//
//  Created by Hannes Satz on 04/06/2010.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChartThatThingViewController;

@interface ChartThatThingAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    ChartThatThingViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ChartThatThingViewController *viewController;

@end

