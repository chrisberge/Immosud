//
//  AfficheAnnonceController4.h
//  Immosud
//
//  Created by Christophe Bergé on 08/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//  CLASSE CREEE POUR BIENS FAVORIS

#import <UIKit/UIKit.h>
#import "ArrayWithIndex.h"
#import "Annonce.h"
#import "DiapoController3.h"
#import "AFOpenFlowViewDiapo.h"
#import "ProgressViewContoller.h"
#import "FormulaireAnnonceMail.h"
#import "ImmosudAppDelegate.h"

@class ImmosudAppDelegate;

@interface AfficheAnnonceController4 : UIViewController <DiapoController3Delegate, FormulaireAnnonceMailDelegate>{
    Annonce *lAnnonce;
    Agence *lAgence;
	NSMutableArray *imagesArray;
	ArrayWithIndex *arrayWithIndex;
    AFOpenFlowViewDiapo *myOpenFlowView;
    UIScrollView *scrollView;
    ProgressViewContoller *pvc;
    UIButton *boutonRetour;
    ImmosudAppDelegate *appDelegate;
}

@end
