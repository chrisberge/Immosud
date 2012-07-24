//
//  Favoris.h
//  Immosud
//
//  Created by Christophe Bergé on 24/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "AfficheListeAnnoncesController3.h"
#import "Annonce.h"
#import "AfficheAnnonceController4.h"
#import "ProgressViewContoller.h"
#import "ImmosudAppDelegate.h"
#import "RootViewControllerModifierFavoris.h"

@class RootViewControllerModifierFavoris;
@class ASINetworkQueue;
@class XMLParser;
@class ImmosudAppDelegate;

@interface Favoris : UIViewController {
    NSMutableArray *recherchesSauvees;
    NSMutableArray *biensSauves;
    
    UIButton *boutonBien1;
    UIButton *boutonBien2;
    
    UIButton *boutonRangee1;
    UIButton *boutonRangee2;
    UIButton *boutonRangee3;
    
    BOOL noRecherche;
    UILabel *labelType1;
    UILabel *labelVille1;
    UILabel *labelPrix1;
    UILabel *labelSurface1;
    
    UILabel *labelType2;
    UILabel *labelVille2;
    UILabel *labelPrix2;
    UILabel *labelSurface2;
    
    UILabel *labelType3;
    UILabel *labelVille3;
    UILabel *labelPrix3;
    UILabel *labelSurface3;
    
    UILabel *labelVilleBien1;
    UILabel *labelVilleBien2;
    
    UILabel *labelPrixBien1;
    UILabel *labelPrixBien2;
    
    UILabel *labelSurfaceBien1;
    UILabel *labelSurfaceBien2;
    
    UIImageView *imgBien1;
    UIImageView *imgBien2;
    
    RootViewControllerModifierFavoris *rechercheMulti;
    NSString *whichView;
    NSMutableArray *tableauAnnonces1;
    
    BOOL isConnectionErrorPrinted;
    ASINetworkQueue *networkQueue;
    NSMutableDictionary *criteres2;
    
    ProgressViewContoller *pvc;
    
    Annonce *annonceSelected;

    NSString *bodyString2;
    ImmosudAppDelegate *appDelegate;
}

@property (nonatomic, assign) NSString *whichView;
@property (nonatomic, retain) RootViewControllerModifierFavoris *rechercheMulti;
@property (nonatomic, copy) NSMutableArray *tableauAnnonces1;
@property (nonatomic, copy) Annonce *annonceSelected;
@property (nonatomic, copy) NSMutableDictionary *criteres2;

@end
