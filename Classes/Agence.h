//
//  Agence.h
//  Immosud
//
//  Created by Christophe Bergé on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Agence : NSObject{
    NSString *titre;
    NSString *responsable;
    NSString *adresse;
    NSString *cp;
    NSString *ville;
    NSString *fixe;
    NSString *mobile;
    NSString *email;
}

@property (nonatomic, retain) NSString *titre;
@property (nonatomic, retain) NSString *responsable;
@property (nonatomic, retain) NSString *adresse;
@property (nonatomic, retain) NSString *cp;
@property (nonatomic, retain) NSString *ville;
@property (nonatomic, retain) NSString *fixe;
@property (nonatomic, retain) NSString *mobile;
@property (nonatomic, retain) NSString *email;

@end
