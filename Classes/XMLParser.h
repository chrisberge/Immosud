//
//  XMLParser.h
//  Immosud
//
//  Created by Christophe Bergé on 01/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Annonce.h"
#import "ImmosudAppDelegate.h"

@class ImmosudAppDelegate, Annonce;

@interface XMLParser : NSObject {
	NSMutableString *currentElementValue;
	Annonce *uneAnnonce;
	ImmosudAppDelegate *appDelegate;
}

- (XMLParser *) initXMLParser;

@end
