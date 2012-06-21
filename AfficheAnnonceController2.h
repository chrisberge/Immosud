//
//  AfficheAnnonceController2.h
//  Immosud
//
//  Created by Christophe Bergé on 13/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  CLASSE UTILISEE POUR MOTEUR DE RECHERCHE

#import <UIKit/UIKit.h>
#import "ArrayWithIndex.h"
#import "Annonce.h"
#import "DiapoController3.h"
#import "AFOpenFlowViewDiapo.h"
#import "ProgressViewContoller.h"
#import "FormulaireAnnonceMail.h"
#import "ImmosudAppDelegate.h"

@class ImmosudAppDelegate;

@interface AfficheAnnonceController2 : UIViewController <DiapoController3Delegate, FormulaireAnnonceMailDelegate>{
    Annonce *lAnnonce;
    //Agence *lAgence;
	NSMutableArray *imagesArray;
	ArrayWithIndex *arrayWithIndex;
    AFOpenFlowViewDiapo *myOpenFlowView;
    UIScrollView *scrollView;
    ProgressViewContoller *pvc;
    UIButton *boutonRetour;
    ImmosudAppDelegate *appDelegate;
}

@end
