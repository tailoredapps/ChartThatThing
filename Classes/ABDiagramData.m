//
//  DiagramData.m
//  ChartThatThing
//
//  Created by Hannes Satz on 06/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ABDiagramData.h"


@implementation ABDiagramData
@synthesize name;
@synthesize amount;

-(id)initWithData:(NSString*)tname: (NSInteger*)tamount
{	
	self = [super init];
	self.name = tname;
	self.amount = tamount;
	return self;
}
@end
