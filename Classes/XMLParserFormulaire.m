//
//  XMLParserFormulaire.m
//  Immosud
//
//  Created by Christophe Bergé on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XMLParserFormulaire.h"

@implementation XMLParserFormulaire

- (XMLParserFormulaire *) initXMLParser {
    
	[super init];
	appDelegate = (ImmosudAppDelegate *)[[UIApplication sharedApplication] delegate];
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
	attributes:(NSDictionary *)attributeDict {
	
	if([elementName isEqualToString:@"agence"]) {
		
		//Initialize the book.
		uneAgence = [[Agence alloc] init];
        
	}
	
	//NSLog(@"Processing Element: %@", elementName);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	
	if(!currentElementValue)
		currentElementValue = [[NSMutableString alloc] initWithString:string];
	else
		[currentElementValue appendString:string];
	
	//NSLog(@"Processing Value: %@", currentElementValue);
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    //NSLog(@"ELEMENT END: %@",elementName);
    
	if([elementName isEqualToString:@"agence"]) {
        [appDelegate.infosAgence removeAllObjects];
        [appDelegate.infosAgence addObject:uneAgence];
        //NSLog(@"INFOS AGENCE: %@", appDelegate.infosAgence);
        
        
		[uneAgence release];
		uneAgence = nil;
	}
	else{
        
        NSString *elementValueString = currentElementValue;
        
        //NSLog(@"element: \"%@\"\nvalue: \"%@\"",elementName, elementValueString);
        
        if([elementName isEqualToString:@"titre"] || [elementName isEqualToString:@"responsable"] || [elementName isEqualToString:@"adresse"]){
            
            if ([elementValueString length] > 5) {
             elementValueString = [elementValueString stringByReplacingCharactersInRange:NSMakeRange(0, 3) withString:@""];   
            }
        }
        
        if (!([elementName isEqualToString:@"titre"]) && !([elementName isEqualToString:@"responsable"]) && !([elementName isEqualToString:@"adresse"])){
            
            if ([elementValueString length] > 0) {
                elementValueString = [elementValueString stringByReplacingOccurrencesOfString:@" " withString:@""];
                elementValueString = [elementValueString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
                elementValueString = [elementValueString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            }
        }
        
        [uneAgence setValue:elementValueString forKey:elementName];
    }
	
	[currentElementValue release];
	currentElementValue = nil;
}

@end
