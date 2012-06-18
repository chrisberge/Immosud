//
//  Agence.m
//  Immosud
//
//  Created by Christophe Bergé on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Agence.h"

@implementation Agence

@synthesize titre,
            responsable,
            adresse,
            cp,
            ville,
            fixe,
            mobile,
            email;

- (void) dealloc {
    [titre release];
	[responsable release];
	[adresse release];
    [cp release];
	[ville release];
	[fixe release];
	[mobile release];
    [email release];
	[super dealloc];
}

@end
