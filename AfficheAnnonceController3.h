//
//  AfficheAnnonceController3.h
//  Immosud
//
//  Created by Christophe Bergé on 13/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  CLASSE CREEE POUR ONGLET AGENCE (MODAL VIEW)

#import <UIKit/UIKit.h>
#import "ArrayWithIndex.h"
#import "Annonce.h"
#import "DiapoController3.h"
#import "AFOpenFlowViewDiapo.h"
#import "ProgressViewContoller.h"
#import "FormulaireAnnonceMail.h"

@protocol AgenceModalViewFicheDelegate;

@interface AfficheAnnonceController3 : UIViewController <DiapoController3Delegate, FormulaireAnnonceMailDelegate>{
    Annonce *lAnnonce;
    Agence *lAgence;
	NSMutableArray *imagesArray;
	ArrayWithIndex *arrayWithIndex;
    AFOpenFlowViewDiapo *myOpenFlowView;
    UIScrollView *scrollView;
    ProgressViewContoller *pvc;
    UIButton *boutonRetour;
}

@property (nonatomic, assign) id <AgenceModalViewFicheDelegate> delegate;

@end

@protocol AgenceModalViewFicheDelegate
- (void)agenceModalViewFicheDidFinish:(AfficheAnnonceController3 *)controller;
@end
