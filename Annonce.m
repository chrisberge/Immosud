//
//  Annonce.m
//  RezoImmoTest1
//
//  Created by Christophe Bergé on 01/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Annonce.h"


@implementation Annonce

@synthesize ref,
            nb_pieces,
            surface,
            ville,
            cp,
            prix,
            descriptif,
            bilan_ce,
            bilan_ges,
            etage,
            ascenseur,
            chauffage,
            code,
            photos;

- (void) dealloc {
    [ref release];
	[nb_pieces release];
	[surface release];
	[ville release];
	[cp release];
	[prix release];
	[descriptif release];
    [bilan_ce release];
    [bilan_ges release];
	[photos release];
    [etage release];
    [ascenseur release];
    [chauffage release];
    [code release];
	[super dealloc];
}

@end
