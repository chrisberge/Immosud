//
//  AfficheListeAnnoncesControllerModifierFavoris.h
//  Immosud
//
//  Created by Christophe Bergé on 12/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  UTILISEE DEPUIS MODIFIER FAVORIS

#import <UIKit/UIKit.h>
#import "Annonce.h"
#import "AfficheAnnonceControllerModifierFavoris.h"
#import "ProgressViewContoller.h"
#import "XMLParser.h"
#import "ImmosudAppDelegate.h"

@class ImmosudAppDelegate;

@interface AfficheListeAnnoncesControllerModifierFavoris : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *listeAnnonces;
    NSMutableDictionary *criteres;
	Annonce *annonceSelected;
    UITableView *tableView1;
    UIButton *boutonPrix;
    UIButton *boutonSurface;
    ProgressViewContoller *pvc;
    NSString *bodyString;
    int page;
    ImmosudAppDelegate *appDelegate;
}

//@property (nonatomic, copy) NSMutableArray *listeAnnonces;
//@property (nonatomic, copy) NSMutableDictionary *criteres;
@property (nonatomic, copy) Annonce *annonceSelected;

-(NSString *)setTextMinMax:(NSString *)critere unit:(NSString *)unit texte:(NSString *)text;
- (void)getNextResults;

@end
