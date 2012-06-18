//
//  AfficheAnnonceControllerModifierFavoris.h
//  Immosud
//
//  Created by Christophe Bergé on 12/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//  CLASSE CREEE POUR MODIFIER RECHERCHE FAVORIS

#import <UIKit/UIKit.h>
#import "ArrayWithIndex.h"
#import "Annonce.h"
#import "DiapoController3.h"
#import "AFOpenFlowViewDiapo.h"
#import "ProgressViewContoller.h"
#import "FormulaireAnnonce.h"
#import "ImmosudAppDelegate.h"

@class ImmosudAppDelegate;

@interface AfficheAnnonceControllerModifierFavoris : UIViewController <DiapoController3Delegate, FormulaireAnnonceDelegate>{
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
