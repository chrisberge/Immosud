//
//  XMLParserFormulaire.h
//  Immosud
//
//  Created by Christophe Bergé on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Agence.h"
#import "ImmosudAppDelegate.h"

@class ImmosudAppDelegate, Agence;

@interface XMLParserFormulaire : NSObject{
    NSMutableString *currentElementValue;
	Agence *uneAgence;
	ImmosudAppDelegate *appDelegate;
}


- (XMLParserFormulaire *) initXMLParser;

@end
