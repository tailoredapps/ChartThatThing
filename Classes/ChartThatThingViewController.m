//
//  ChartThatThingViewController.m
//  ChartThatThing
//
//  Created by Hannes Satz on 04/06/2010.
//  Copyright AUTBurst 2010. All rights reserved.
//

#import "ChartThatThingViewController.h"

@implementation ChartThatThingViewController


@synthesize dataentries;
@synthesize barcolors;

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}

//Use ViewDidLoad in order to SetUp the Design of the diagram
- (void)viewDidLoad 
{
	[super viewDidLoad];
	
	//generate Testdata
	self.dataentries = [[NSMutableArray alloc] init];
	
	//i simulate 4 entries with increasing values
	NSArray *bevs = [[NSArray alloc] initWithObjects:@"Bier", @"Wein", @"Wurscht", @"Shot", @"Mojito", @"Cocktail", nil];
	
	NSMutableArray *labelLocations = [[NSMutableArray alloc] init];	
	NSArray *offsetmappings = [NSArray arrayWithObjects:[NSNumber numberWithInt:4],[NSNumber numberWithInt:3],[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],[NSNumber numberWithInt:1],nil];
	
	//Change this value to change the number of plots in the diagram
	int amountOfBarPlots = 1;
	
	int i = 0;
	
	for(i=0; i<amountOfBarPlots;i++)
	{
		int r = rand() % 6;
		ABDiagramData *entry = [[ABDiagramData alloc] initWithData:[bevs objectAtIndex:r]:30+i*2+4];
		
		[self.dataentries addObject:entry];
		[labelLocations addObject:[NSNumber numberWithInt:i+1]];
	}
	
	int maxValue = 30+i*2+4 * 1.10;
	//generate TestData END
	//The needed information is the dataentries and the maxValue (in order to calculate the X- and Y-Axis Ranges...
	
	
	
    // Create barChart from theme
	//The barChart is only the Space within the barPlot can be painted
    barChart = [[CPXYGraph alloc] initWithFrame:CGRectZero];
	
	//develop Own theme or use ABdarkgradient one
	CPTheme *theme = [CPTheme themeNamed:kCPDarkGradientTheme];
    [barChart applyTheme:theme];
	
	//This is possible because the view-class is set in the IB as a CPlayerHostingView
	//and not as the standard UIView-class
	CPLayerHostingView *hostingView = (CPLayerHostingView *)self.view;
    hostingView.hostedLayer = barChart;
    barChart.plotAreaFrame.masksToBorder = NO;
	
	//Place the Plottingspace somewhere on the Screen by manipulating the padding parameter
    barChart.paddingLeft = 60.0;
	barChart.paddingTop = 20.0;
	barChart.paddingRight = 20.0;
	barChart.paddingBottom = 60.0;
	
	//Calculate the MAXRange of the Y-Axis and the X-Axis
	
	//The Range of the Y-Axis is the MaxValue plus 10 percent of it. to have a pretty small gap on the top of the highest bar.
	float tenpercentofmaxY = maxValue * 0.1;
	float countofitems = amountOfBarPlots + 1;
	
	//tenpercentofmaxY = Maximum range on the Y-Axis
	//countofitems = Maximum range on the X-Axis
	
	// Add plot space for horizontal bar charts
	//Use here the calculated ranges of the axis.
    CPXYPlotSpace *plotSpace = (CPXYPlotSpace *)barChart.defaultPlotSpace;
    plotSpace.yRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(0.0f) length:CPDecimalFromFloat(maxValue + tenpercentofmaxY)];
    plotSpace.xRange = [CPPlotRange plotRangeWithLocation:CPDecimalFromFloat(0.0f) length:CPDecimalFromFloat(countofitems)];
    
	//adjust the lineStyle of the axis or lines that you draw in the diagram
	CPLineStyle *lineStyle = [CPLineStyle lineStyle];
	lineStyle.lineColor = [CPColor whiteColor];
	lineStyle.lineWidth = 2.0f;
	
	//CPXYAxisSet defines the X- and Y-Axis...assign them with .xAxis or .yAxis
	//A Axis is defined through the Class CPXYAxis
	CPXYAxisSet *axisSet = (CPXYAxisSet *)barChart.axisSet;
    CPXYAxis *x = axisSet.xAxis;
    x.axisLineStyle = nil;
    x.majorTickLineStyle = nil;
    x.minorTickLineStyle = nil;
    x.majorIntervalLength = CPDecimalFromString(@"2");
    x.orthogonalCoordinateDecimal = CPDecimalFromString(@"0");
	//x.title = @"Drinks";
	//The location must be calculated accoriding to the diagram data
	//titleLocation is the XOffSet of the Title
    x.titleLocation = CPDecimalFromFloat(-0.5f);
	//The titleOffset is the YOffSet of the Title
	x.titleOffset = 0;
	
	// Define some custom labels for the data elements
	
	//labelRotation defines in which angle the labels appear on the screen
	x.labelRotation = M_PI/4;
	x.labelingPolicy = CPAxisLabelingPolicyNone;
	
	

	
	
	//Generate Labels according to the testdata
	
	//labelLocations is an Array where you can set at which points on the x-Axis the Labels should appear
		
	NSUInteger labelLocation = 0;
	NSMutableArray *customLabels = [NSMutableArray arrayWithCapacity:[self.dataentries count]];
	for (NSNumber *tickLocation in labelLocations) {
		CPAxisLabel *newLabel = [[CPAxisLabel alloc] initWithText: [[self.dataentries objectAtIndex:labelLocation] name] textStyle:x.labelTextStyle];
		//the tickLocation defines where on the x-Axis the label is displayed
		newLabel.tickLocation = [tickLocation decimalValue];
		//this offset only scales in y-direction of the x-Axis
		newLabel.offset = x.labelOffset + x.majorTickLength;
		newLabel.rotation = M_PI/4;
		[customLabels addObject:newLabel];
		[newLabel release];
		labelLocation ++;
	}
	
	//Assign the generated Labels to the Axis
	x.axisLabels =  [NSSet setWithArray:customLabels];
	
	CPXYAxis *y = axisSet.yAxis;
    y.axisLineStyle = nil;
    y.majorTickLineStyle = nil;
    y.minorTickLineStyle = nil;
	//The IntervallLength is the length between the labeled values on the Axis
	//I dont know the best practise but i assume to display 5 Labels on the screen
	//therefore maxValue/5 = intervallLength
    y.majorIntervalLength = CPDecimalFromFloat(maxValue/5);
    y.orthogonalCoordinateDecimal = CPDecimalFromString(@"0");
	y.title = @"Menge";
	//Offset of the LeftSide of the Screen
	y.titleOffset = 30.0f;
	//OffSet within the YAxis (usually the half of the max YAxis-range would be appropiate
    y.titleLocation = CPDecimalFromFloat(25.0f);
	y.labelRotation = 1;
	
	barcolors = [[NSMutableArray alloc] init];
	
	//Calculate offset of the barPlots
	
	int barPlotOffset = 1;
	if(amountOfBarPlots <= 5)
	{
		barPlotOffset = [[offsetmappings objectAtIndex:amountOfBarPlots-1] intValue];
	}

	
	
	//Set Color of Plot
    CPBarPlot *barPlotr = [CPBarPlot tubularBarPlotWithColor:[CPColor redColor] horizontalBars:NO];
    barPlotr.baseValue = CPDecimalFromString(@"0");
    barPlotr.dataSource = self;
	//use OffSet to place the barchart in the PlotSpace
    barPlotr.barOffset = barPlotOffset;
    barPlotr.identifier = @"Bar Plot Red";
	barPlotr.lineStyle = nil;
	barPlotr.barWidth = 45;
    [barChart addPlot:barPlotr toPlotSpace:plotSpace];
	
	//Register the assigned Plot to the barcolors-Array, which is needed to identifier the layer, which should render
	//the particular barPlot. -> needed to simulate different barPlot Colors in the same diagram
	[barcolors addObject:@"Bar Plot Red"];
	
	
	
	//Set Color of Plot
    CPBarPlot *barPlotg = [CPBarPlot tubularBarPlotWithColor:[CPColor greenColor] horizontalBars:NO];
    barPlotg.baseValue = CPDecimalFromString(@"0");
    barPlotg.dataSource = self;
	//use OffSet to place the barchart in the PlotSpace
    barPlotg.barOffset = barPlotOffset;
	barPlotg.barWidth = 45;
    barPlotg.identifier = @"Bar Plot Green";
	barPlotg.lineStyle = nil;
    [barChart addPlot:barPlotg toPlotSpace:plotSpace];
	
	[barcolors addObject:@"Bar Plot Green"];
	
	//Set Color of Plot
    CPBarPlot *barPloty = [CPBarPlot tubularBarPlotWithColor:[CPColor yellowColor] horizontalBars:NO];
    barPloty.baseValue = CPDecimalFromString(@"0");
    barPloty.dataSource = self;
	//use OffSet to place the barchart in the PlotSpace
    barPloty.barOffset = barPlotOffset;
	barPloty.barWidth = 45;
    barPloty.identifier = @"Bar Plot Yellow";
	//If LineStyle is set to nil, there is no line visible...default is a thin black line
	barPloty.lineStyle = nil;
    [barChart addPlot:barPloty toPlotSpace:plotSpace];
	
	[barcolors addObject:@"Bar Plot Yellow"];
	
	//Set Color of Plot
    CPBarPlot *barPlotb = [CPBarPlot tubularBarPlotWithColor:[CPColor blueColor] horizontalBars:NO];
    barPlotb.baseValue = CPDecimalFromString(@"0");
    barPlotb.dataSource = self;
	//use OffSet to place the barchart in the PlotSpace
    barPlotb.barOffset = barPlotOffset;
	barPlotb.barWidth = 45;
    barPlotb.identifier = @"Bar Plot Blue";
	barPlotb.lineStyle = nil;
    [barChart addPlot:barPlotb toPlotSpace:plotSpace];
	
	[barcolors addObject:@"Bar Plot Blue"];
	
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}



-(NSUInteger)numberOfRecordsForPlot:(CPPlot *)plot {
    return [self.dataentries count];
}

-(NSNumber *)numberForPlot:(CPPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index 
{
    NSDecimalNumber *num = nil;
    if ( [plot isKindOfClass:[CPBarPlot class]] ) {
		switch ( fieldEnum ) {
			case CPBarPlotFieldBarLocation:
				num = (NSDecimalNumber *)[NSDecimalNumber numberWithUnsignedInteger:index];
				break;
			case CPBarPlotFieldBarLength:
			{
				NSUInteger colorindex = index;
				//if there are less colors defined, than entries then start picking the colors from the beginning
				if(index >= [barcolors count])
				{
					colorindex = index - [barcolors count];
					while(colorindex >= [barcolors count])
						colorindex = colorindex - [barcolors count];
				}

				//Assign which color, by fading out the other BarPlot-Layers return of 0 means
				//that the BarPlot has no heigt, therefor it is not visible
				if([barcolors objectAtIndex:colorindex] != plot.identifier)
					return [NSNumber numberWithInt:0];
				//Here set the Value for the one specific x-value.
				//In this case it is the value of the field amount of the ABDiagramData-Object
				//index goes from 0 to (numberofRecordsForPlot - 1)
				num = (NSDecimalNumber *)[NSDecimalNumber numberWithUnsignedInteger:[[self.dataentries objectAtIndex:index] amount] ];
				break;
			}
		}
    }
	
    return num;
}

-(CPFill *) barFillForBarPlot:(CPBarPlot *)barPlot recordIndex:(NSNumber *)index; 
{
	return nil;
}
@end
