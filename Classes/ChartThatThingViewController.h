//
//  ChartThatThingViewController.h
//  ChartThatThing
//
//  Created by Hannes Satz on 04/06/2010.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CorePlot-CocoaTouch.h"
#import "ABDiagramData.h"
#import <stdlib.h>

@interface ChartThatThingViewController : UIViewController <CPPlotDataSource> 
{
	CPXYGraph *barChart;
	NSMutableArray *dataentries;
	NSMutableArray* barcolors;
}

@property (assign) NSMutableArray *dataentries;
@property (assign) NSMutableArray* barcolors;

@end

