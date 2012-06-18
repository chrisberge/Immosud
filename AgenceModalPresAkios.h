//
//  AgenceModalPresAkios.h
//  Immosud
//
//  Created by Christophe Bergé on 24/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AgenceModalPresAkiosDelegate;

@interface AgenceModalPresAkios : UIViewController

@property (nonatomic, assign) id <AgenceModalPresAkiosDelegate> delegate;

@end

@protocol AgenceModalPresAkiosDelegate
- (void)agenceModalPresAkiosDidFinish:(AgenceModalPresAkios *)controller;

@end
