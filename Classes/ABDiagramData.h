//
//  DiagramData.h
//  ChartThatThing
//
//  Created by Hannes Satz on 06/06/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ABDiagramData : NSObject {

	NSString *name;
	NSInteger amount;
}

-(id)initWithData:(NSString*)tname: (NSInteger)tamount;


@property (assign) NSString *name;
@property (assign) NSInteger amount;
@end
