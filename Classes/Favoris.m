//
//  Favoris.m
//  Immosud
//
//  Created by Christophe Bergé on 24/07/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Favoris.h"


@implementation Favoris

@synthesize whichView, rechercheMulti, tableauAnnonces1, annonceSelected, criteres2;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    appDelegate = (ImmosudAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    tableauAnnonces1 = [[NSMutableArray alloc] init];
    criteres2 = [[NSMutableDictionary alloc] init];
    rechercheMulti = [[RootViewControllerModifierFavoris alloc] init];
    annonceSelected = [[Annonce alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(afficheAnnonceFavorisReady:) name:@"afficheAnnonceFavorisReady" object: nil];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, 320, 480)];
    [scrollView setContentSize:CGSizeMake(320, 750)];
    [scrollView setScrollEnabled:YES];
    [self.view addSubview:scrollView];
    
    //COULEUR DE FOND
    UIColor *fond = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = fond;
    [fond release];
    //self.view.backgroundColor = [UIColor whiteColor];
    
    //HEADER
    UIImageView *enTete = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
    [enTete setFrame:CGRectMake(0,0,320,50)];
    [self.view addSubview:enTete];
    [enTete release];
    
    //BANDEAU FAVORIS
    UIImageView *bandeauFavoris = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bandeau-favoris.png"]];
    [bandeauFavoris setFrame:CGRectMake(0,50,320,20)];
    [self.view addSubview:bandeauFavoris];
    [bandeauFavoris release];
    
    //BANDEAU BIENS FAVORIS
    UIImageView *bandeauBiensFavoris = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bandeau-selection-de-biens.png"]];
    [bandeauBiensFavoris setFrame:CGRectMake(0,5,320,20)];
    [scrollView addSubview:bandeauBiensFavoris];
    [bandeauBiensFavoris release];
    
    //BANDEAU RECHERCHE RECENTES
    UIImageView *bandeauRecherche = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bandeau-mes-recherches-recentes.png"]];
    [bandeauRecherche setFrame:CGRectMake(0,190,320,20)];
    [scrollView addSubview:bandeauRecherche];
    [bandeauRecherche release];
    
    isConnectionErrorPrinted = NO;
    
    /*--- QUEUE POUR LES REQUETES HTTP ---*/
    networkQueue = [[ASINetworkQueue alloc] init];
    [networkQueue reset];
	[networkQueue setRequestDidFinishSelector:@selector(requestDone:)];
	[networkQueue setRequestDidFailSelector:@selector(requestFailed:)];
	[networkQueue setDelegate:self];
    /*--- QUEUE POUR LES REQUETES HTTP ---*/
    
    /*--- BOUTONS ---*/
    
    /*---- BIENS FAVORIS ----*/
    /*----- 1ER BIEN -----*/
    /*------ INFOS ------*/
    boutonBien1 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonBien1 setFrame:CGRectMake(10, 30, 200, 70)];
	[boutonBien1 setUserInteractionEnabled:YES];
	[boutonBien1 addTarget:self action:@selector(buttonInfosPushed:) 
            forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image = [UIImage imageNamed:@"espace-informations.png"];
	[boutonBien1 setImage:image forState:UIControlStateNormal];
    
    boutonBien1.showsTouchWhenHighlighted = NO;
    boutonBien1.tag = 101;
	
	[scrollView addSubview:boutonBien1];
    /*------ INFOS ------*/
    /*------ SUPPRIMER ------*/
    UIButton *supprimerBien1 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[supprimerBien1 setFrame:CGRectMake(220, 30, 90, 45)];
	[supprimerBien1 setUserInteractionEnabled:YES];
	[supprimerBien1 addTarget:self action:@selector(buttonSupprimerPushed:) 
               forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"bouton-supprimer.png"];
	[supprimerBien1 setImage:image forState:UIControlStateNormal];
    
    supprimerBien1.showsTouchWhenHighlighted = NO;
    supprimerBien1.tag = 111;
	
	[scrollView addSubview:supprimerBien1];
    /*------ SUPPRIMER ------*/
    /*----- 1ER BIEN -----*/
    
    /*----- 2EME BIEN -----*/
    /*------ INFOS ------*/
    boutonBien2 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonBien2 setFrame:CGRectMake(10, 110, 200, 70)];
	[boutonBien2 setUserInteractionEnabled:YES];
	[boutonBien2 addTarget:self action:@selector(buttonInfosPushed:) 
          forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"espace-informations.png"];
	[boutonBien2 setImage:image forState:UIControlStateNormal];
    
    boutonBien2.showsTouchWhenHighlighted = NO;
    boutonBien2.tag = 201;
	
	[scrollView addSubview:boutonBien2];
    /*------ INFOS ------*/
    /*------ SUPPRIMER ------*/
    UIButton *supprimerBien2 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[supprimerBien2 setFrame:CGRectMake(220, 110, 90, 45)];
	[supprimerBien2 setUserInteractionEnabled:YES];
	[supprimerBien2 addTarget:self action:@selector(buttonSupprimerPushed:) 
             forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"bouton-supprimer.png"];
	[supprimerBien2 setImage:image forState:UIControlStateNormal];
    
    supprimerBien2.showsTouchWhenHighlighted = NO;
    supprimerBien2.tag = 222;
	
	[scrollView addSubview:supprimerBien2];
    /*------ SUPPRIMER ------*/
    /*----- 2ER BIEN -----*/
    
    /*---- BIENS FAVORIS ----*/
    
    /*---- RECHERCHES RECENTES ----*/
    /*----- 1ERE RANGEE -----*/
    /*------ INFOS ------*/
    boutonRangee1 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonRangee1 setFrame:CGRectMake(10, 220, 200, 100)];
	[boutonRangee1 setUserInteractionEnabled:YES];
	[boutonRangee1 addTarget:self action:@selector(buttonInfosPushed:) 
            forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"espace-informations.png"];
	[boutonRangee1 setImage:image forState:UIControlStateNormal];
    
    boutonRangee1.showsTouchWhenHighlighted = NO;
    boutonRangee1.tag = 1;
	
	[scrollView addSubview:boutonRangee1];
    /*------ INFOS ------*/
    /*------ MODIFIER ------*/
    UIButton *modifierRangee1 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[modifierRangee1 setFrame:CGRectMake(220, 220, 90, 45)];
	[modifierRangee1 setUserInteractionEnabled:YES];
	[modifierRangee1 addTarget:self action:@selector(buttonModifierPushed:) 
            forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"bouton-modifier.png"];
	[modifierRangee1 setImage:image forState:UIControlStateNormal];
    
    modifierRangee1.showsTouchWhenHighlighted = NO;
    modifierRangee1.tag = 11;
	
	[scrollView addSubview:modifierRangee1];
    /*------ MODIFIER ------*/
    /*------ SUPPRIMER ------*/
    UIButton *supprimerRangee1 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[supprimerRangee1 setFrame:CGRectMake(220, 275, 90, 45)];
	[supprimerRangee1 setUserInteractionEnabled:YES];
	[supprimerRangee1 addTarget:self action:@selector(buttonSupprimerPushed:) 
              forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"bouton-supprimer.png"];
	[supprimerRangee1 setImage:image forState:UIControlStateNormal];
    
    supprimerRangee1.showsTouchWhenHighlighted = NO;
    supprimerRangee1.tag = 21;
	
	[scrollView addSubview:supprimerRangee1];
    /*------ SUPPRIMER ------*/
    /*----- 1ERE RANGEE -----*/
    /*----- 2EME RANGEE -----*/
    /*------ INFOS ------*/
    boutonRangee2 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonRangee2 setFrame:CGRectMake(10, 330, 200, 100)];
	[boutonRangee2 setUserInteractionEnabled:YES];
	[boutonRangee2 addTarget:self action:@selector(buttonInfosPushed:) 
            forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"espace-informations.png"];
	[boutonRangee2 setImage:image forState:UIControlStateNormal];
    
    boutonRangee2.showsTouchWhenHighlighted = NO;
    boutonRangee2.tag = 2;
	
	[scrollView addSubview:boutonRangee2];
    /*------ INFOS ------*/
    /*------ MODIFIER ------*/
    UIButton *modifierRangee2 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[modifierRangee2 setFrame:CGRectMake(220, 330, 90, 45)];
	[modifierRangee2 setUserInteractionEnabled:YES];
	[modifierRangee2 addTarget:self action:@selector(buttonModifierPushed:) 
              forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"bouton-modifier.png"];
	[modifierRangee2 setImage:image forState:UIControlStateNormal];
    
    modifierRangee2.showsTouchWhenHighlighted = NO;
    modifierRangee2.tag = 12;
	
	[scrollView addSubview:modifierRangee2];
    /*------ MODIFIER ------*/
    /*------ SUPPRIMER ------*/
    UIButton *supprimerRangee2 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[supprimerRangee2 setFrame:CGRectMake(220, 385, 90, 45)];
	[supprimerRangee2 setUserInteractionEnabled:YES];
	[supprimerRangee2 addTarget:self action:@selector(buttonSupprimerPushed:) 
               forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"bouton-supprimer.png"];
	[supprimerRangee2 setImage:image forState:UIControlStateNormal];
    
    supprimerRangee2.showsTouchWhenHighlighted = NO;
    supprimerRangee2.tag = 22;
	
	[scrollView addSubview:supprimerRangee2];
    /*------ SUPPRIMER ------*/
    /*----- 2EME RANGEE -----*/
    /*----- 3EME RANGEE -----*/
    /*------ INFOS ------*/
    boutonRangee3 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonRangee3 setFrame:CGRectMake(10, 440, 200, 100)];
	[boutonRangee3 setUserInteractionEnabled:YES];
	[boutonRangee3 addTarget:self action:@selector(buttonInfosPushed:) 
            forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"espace-informations.png"];
	[boutonRangee3 setImage:image forState:UIControlStateNormal];
    
    boutonRangee3.showsTouchWhenHighlighted = NO;
    boutonRangee3.tag = 3;
	
	[scrollView addSubview:boutonRangee3];
    /*------ INFOS ------*/
    /*------ MODIFIER ------*/
    UIButton *modifierRangee3 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[modifierRangee3 setFrame:CGRectMake(220, 440, 90, 45)];
	[modifierRangee3 setUserInteractionEnabled:YES];
	[modifierRangee3 addTarget:self action:@selector(buttonModifierPushed:) 
              forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"bouton-modifier.png"];
	[modifierRangee3 setImage:image forState:UIControlStateNormal];
    
    modifierRangee3.showsTouchWhenHighlighted = NO;
    modifierRangee3.tag = 13;
	
	[scrollView addSubview:modifierRangee3];
    /*------ MODIFIER ------*/
    /*------ SUPPRIMER ------*/
    UIButton *supprimerRangee3 = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[supprimerRangee3 setFrame:CGRectMake(220, 495, 90, 45)];
	[supprimerRangee3 setUserInteractionEnabled:YES];
	[supprimerRangee3 addTarget:self action:@selector(buttonSupprimerPushed:) 
               forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"bouton-supprimer.png"];
	[supprimerRangee3 setImage:image forState:UIControlStateNormal];
    
    supprimerRangee3.showsTouchWhenHighlighted = NO;
    supprimerRangee3.tag = 23;
	
	[scrollView addSubview:supprimerRangee3];
    /*------ SUPPRIMER ------*/
    /*----- 3EME RANGEE -----*/
    /*---- RECHERCHES RECENTES ----*/
    
    /*--- BOUTONS ---*/
    
    /*--- MODELE: RETROUVER LES RECHERCHES ET BIENS SAUVES ET AFFICHER DANS LES BOUTONS ---*/
    /*---- RECHERCHES ----*/
    recherchesSauvees = [[NSMutableArray alloc] init];
    
    int xLabel = 0;
    int wLabel = 200;
    
    //TYPES DE BIENS
    labelType1 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 5, wLabel, 20)];
    labelType2 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 5, wLabel, 20)];
    labelType3 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 5, wLabel, 20)];
    
    labelType3.backgroundColor = labelType2.backgroundColor = labelType1.backgroundColor = [UIColor clearColor];
    labelType3.text = labelType2.text = labelType1.text = @"Aucun critères";
    labelType3.textAlignment = labelType2.textAlignment = labelType1.textAlignment = UITextAlignmentCenter;
    labelType1.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
    //labelType1.textColor = [UIColor colorWithRed:(51.0/255.0) green:(50.0/255.0) blue:(50.0/255.0) alpha:1.0];
    labelType3.font = labelType2.font = labelType1.font;
    labelType3.textColor = labelType2.textColor = labelType1.textColor;
    
    [boutonRangee1 addSubview:labelType1];
    [boutonRangee2 addSubview:labelType2];
    [boutonRangee3 addSubview:labelType3];
    
    //VILLES
    labelVille1 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 25, wLabel, 20)];
    labelVille2 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 25, wLabel, 20)];
    labelVille3 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 25, wLabel, 20)];
    
    labelVille3.backgroundColor = labelVille2.backgroundColor = labelVille1.backgroundColor = [UIColor clearColor];
    labelVille3.text = labelVille2.text = labelVille1.text = @"";
    labelVille3.textAlignment = labelVille2.textAlignment = labelVille1.textAlignment = UITextAlignmentCenter;
    labelVille1.font = [UIFont fontWithName:@"Arial-BoldMT" size:16];
    //labelVille1.textColor = [UIColor colorWithRed:(255.0/255.0) green:(247.0/255.0) blue:(205.0/255.0) alpha:1.0];
    labelVille3.font = labelVille2.font = labelVille1.font;
    labelVille3.textColor = labelVille2.textColor = labelVille1.textColor;
    
    [boutonRangee1 addSubview:labelVille1];
    [boutonRangee2 addSubview:labelVille2];
    [boutonRangee3 addSubview:labelVille3];
    
    //PRIX
    labelPrix1 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 50, wLabel, 20)];
    labelPrix2 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 50, wLabel, 20)];
    labelPrix3 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 50, wLabel, 20)];
    
    labelPrix3.backgroundColor = labelPrix2.backgroundColor = labelPrix1.backgroundColor = [UIColor clearColor];
    labelPrix3.text = labelPrix2.text = labelPrix1.text = @"";
    labelPrix3.textAlignment = labelPrix2.textAlignment = labelPrix1.textAlignment = UITextAlignmentCenter;
    labelPrix1.font = [UIFont fontWithName:@"Arial" size:12];
    //labelPrix1.textColor = [UIColor colorWithRed:(42.0/255.0) green:(42.0/255.0) blue:(42.0/255.0) alpha:1.0];
    labelPrix3.font = labelPrix2.font = labelPrix1.font;
    labelPrix3.textColor = labelPrix2.textColor = labelPrix1.textColor;
    
    [boutonRangee1 addSubview:labelPrix1];
    [boutonRangee2 addSubview:labelPrix2];
    [boutonRangee3 addSubview:labelPrix3];
    
    //SURFACES
    labelSurface1 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 70, wLabel, 20)];
    labelSurface2 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 70, wLabel, 20)];
    labelSurface3 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 70, wLabel, 20)];
    
    labelSurface3.backgroundColor = labelSurface2.backgroundColor = labelSurface1.backgroundColor = [UIColor clearColor];
    labelSurface3.text = labelSurface2.text = labelSurface1.text = @"";
    labelSurface3.textAlignment = labelSurface2.textAlignment = labelSurface1.textAlignment = UITextAlignmentCenter;
    labelSurface1.font = [UIFont fontWithName:@"Arial" size:12];
    //labelSurface1.textColor = [UIColor colorWithRed:(42.0/255.0) green:(42.0/255.0) blue:(42.0/255.0) alpha:1.0];
    labelSurface3.font = labelSurface2.font = labelSurface1.font;
    labelSurface3.textColor = labelSurface2.textColor = labelSurface1.textColor;
    
    [boutonRangee1 addSubview:labelSurface1];
    [boutonRangee2 addSubview:labelSurface2];
    [boutonRangee3 addSubview:labelSurface3];
    /*---- RECHERCHES ----*/
    /*---- BIENS ----*/
    biensSauves = [[NSMutableArray alloc] init];
    
    xLabel = 67;
    wLabel = 130;
    
    //VILLES
    labelVilleBien1 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 5, wLabel, 20)];
    labelVilleBien2 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 5, wLabel, 20)];
    
    labelVilleBien2.backgroundColor = labelVilleBien1.backgroundColor = [UIColor clearColor];
    labelVilleBien2.text = labelVilleBien1.text = @"";
    labelVilleBien2.textAlignment = labelVilleBien1.textAlignment = UITextAlignmentLeft;
    labelVilleBien1.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    //labelVilleBien1.textColor = [UIColor colorWithRed:(255.0/255.0) green:(247.0/255.0) blue:(205.0/255.0) alpha:1.0];
    labelVilleBien2.font = labelVilleBien1.font;
    labelVilleBien2.textColor = labelVilleBien1.textColor;
    
    [boutonBien1 addSubview:labelVilleBien1];
    [boutonBien2 addSubview:labelVilleBien2];
    
    //PRIX
    labelPrixBien1 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 25, wLabel, 20)];
    labelPrixBien2 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 25, wLabel, 20)];
    
    labelPrixBien2.backgroundColor = labelPrixBien1.backgroundColor = [UIColor clearColor];
    labelPrixBien2.text = labelPrixBien1.text = @"";
    labelPrixBien2.textAlignment = labelPrixBien1.textAlignment = UITextAlignmentLeft;
    labelPrixBien1.font = [UIFont fontWithName:@"Arial" size:12];
    //labelPrixBien1.textColor = [UIColor colorWithRed:(42.0/255.0) green:(42.0/255.0) blue:(42.0/255.0) alpha:1.0];
    labelPrixBien2.font = labelPrixBien1.font;
    labelPrixBien2.textColor = labelPrixBien1.textColor;
    
    [boutonBien1 addSubview:labelPrixBien1];
    [boutonBien2 addSubview:labelPrixBien2];
    
    //SURFACES
    labelSurfaceBien1 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 40, wLabel, 20)];
    labelSurfaceBien2 = [[UILabel alloc] initWithFrame:CGRectMake(xLabel, 40, wLabel, 20)];
    
    labelSurfaceBien2.backgroundColor = labelSurfaceBien1.backgroundColor = [UIColor clearColor];
    labelSurfaceBien2.text = labelSurfaceBien1.text = @"";
    labelSurfaceBien2.textAlignment = labelSurfaceBien1.textAlignment = UITextAlignmentLeft;
    labelSurfaceBien1.font = [UIFont fontWithName:@"Arial" size:12];
    //labelSurfaceBien1.textColor = [UIColor colorWithRed:(42.0/255.0) green:(42.0/255.0) blue:(42.0/255.0) alpha:1.0];
    labelSurfaceBien2.font = labelSurfaceBien1.font;
    labelSurfaceBien2.textColor = labelSurfaceBien1.textColor;
    
    [boutonBien1 addSubview:labelSurfaceBien1];
    [boutonBien2 addSubview:labelSurfaceBien2];
    
    //PHOTOS
    imgBien1 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 60, 60)];
    imgBien2 = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 60, 60)];
    
    [boutonBien1 addSubview:imgBien1];
    [boutonBien2 addSubview:imgBien2];
    /*---- BIENS ----*/
    /*--- MODELE: RETROUVER LES RECHERCHES ET BIENS SAUVES ET AFFICHER DANS LES BOUTONS ---*/
}

- (void) buttonInfosPushed:(id)sender
{
	UIButton *button = sender;
	switch (button.tag) {
		case 1:
            NSLog(@"Recherche 1");
            [tableauAnnonces1 removeAllObjects];
            [self makeRequest:0];
			break;
		case 2:
            NSLog(@"Recherche 2");
            [tableauAnnonces1 removeAllObjects];
            [self makeRequest:1];
            break;
        case 3:
            NSLog(@"Recherche 3");
            [tableauAnnonces1 removeAllObjects];
            [self makeRequest:2];
            break;
        case 101:
            NSLog(@"Bien 1");
            NSDictionary *bien1 = [NSDictionary dictionaryWithDictionary:[biensSauves objectAtIndex:0]];
            
            if(bien1 != nil)
            {
                [annonceSelected setValue:[bien1 valueForKey:@"ref"] forKey:@"ref"];
                [annonceSelected setValue:[bien1 valueForKey:@"nb_pieces"] forKey:@"nb_pieces"];
                [annonceSelected setValue:[bien1 valueForKey:@"surface"] forKey:@"surface"];
                [annonceSelected setValue:[bien1 valueForKey:@"ville"] forKey:@"ville"];
                [annonceSelected setValue:[bien1 valueForKey:@"cp"] forKey:@"cp"];
                [annonceSelected setValue:[bien1 valueForKey:@"prix"] forKey:@"prix"];
                [annonceSelected setValue:[bien1 valueForKey:@"descriptif"] forKey:@"descriptif"];
                [annonceSelected setValue:[bien1 valueForKey:@"photos"] forKey:@"photos"];
                [annonceSelected setValue:[bien1 valueForKey:@"bilan_ce"] forKey:@"bilan_ce"];
                [annonceSelected setValue:[bien1 valueForKey:@"bilan_ges"] forKey:@"bilan_ges"];
                [annonceSelected setValue:[bien1 valueForKey:@"etage"] forKey:@"etage"];
                [annonceSelected setValue:[bien1 valueForKey:@"ascenseur"] forKey:@"ascenseur"];
                [annonceSelected setValue:[bien1 valueForKey:@"chauffage"] forKey:@"chauffage"];
                [annonceSelected setValue:[bien1 valueForKey:@"code"] forKey:@"code"];
                
                appDelegate.annonceBiensFavoris = annonceSelected;
            }
            
            [NSThread detachNewThreadSelector:@selector(printHUD) toTarget:self withObject:nil];
            
            AfficheAnnonceController4 *afficheAnnonceController1 = [[AfficheAnnonceController4 alloc] init];
            [self.navigationController pushViewController:afficheAnnonceController1 animated:YES];
            [afficheAnnonceController1 release];
            break;
        case 201:
            NSLog(@"Bien 2");
            NSDictionary *bien2 = [NSDictionary dictionaryWithDictionary:[biensSauves lastObject]];
            
            if(bien2 != nil)
            {
                [annonceSelected setValue:[bien2 valueForKey:@"ref"] forKey:@"ref"];
                [annonceSelected setValue:[bien2 valueForKey:@"nb_pieces"] forKey:@"nb_pieces"];
                [annonceSelected setValue:[bien2 valueForKey:@"surface"] forKey:@"surface"];
                [annonceSelected setValue:[bien2 valueForKey:@"ville"] forKey:@"ville"];
                [annonceSelected setValue:[bien2 valueForKey:@"cp"] forKey:@"cp"];
                [annonceSelected setValue:[bien2 valueForKey:@"prix"] forKey:@"prix"];
                [annonceSelected setValue:[bien2 valueForKey:@"descriptif"] forKey:@"descriptif"];
                [annonceSelected setValue:[bien2 valueForKey:@"photos"] forKey:@"photos"];
                [annonceSelected setValue:[bien2 valueForKey:@"bilan_ce"] forKey:@"bilan_ce"];
                [annonceSelected setValue:[bien2 valueForKey:@"bilan_ges"] forKey:@"bilan_ges"];
                [annonceSelected setValue:[bien2 valueForKey:@"etage"] forKey:@"etage"];
                [annonceSelected setValue:[bien2 valueForKey:@"ascenseur"] forKey:@"ascenseur"];
                [annonceSelected setValue:[bien2 valueForKey:@"chauffage"] forKey:@"chauffage"];
                [annonceSelected setValue:[bien2 valueForKey:@"code"] forKey:@"code"];
                
                appDelegate.annonceBiensFavoris = annonceSelected;
            }
            
            [NSThread detachNewThreadSelector:@selector(printHUD) toTarget:self withObject:nil];
            
            AfficheAnnonceController4 *afficheAnnonceController2 = [[AfficheAnnonceController4 alloc] init];
            [self.navigationController pushViewController:afficheAnnonceController2 animated:YES];
            [afficheAnnonceController2 release];
            break;
        default:
			break;
	}
}

- (void) printHUD{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    pvc = [[ProgressViewContoller alloc] init];
    [self.navigationController.view addSubview:pvc.view];
    
    [pool release];
    
}

- (void)makeRequest:(int)num{
    appDelegate.whichView = @"favoris";

    NSMutableDictionary *criteres1 = [recherchesSauvees objectAtIndex:num];
    
    NSString *bodyString = @"http://www.akios.fr/immobilier/smart_phone.php?part=Immosud&id_agence=IMMOSUD_PORTAIL&";
    
    NSEnumerator *enume;
    NSString *key;
    
    enume = [criteres1 keyEnumerator];
    BOOL isFirstObject = YES;
    NSString *esperluette = @"";
    
    [criteres2 removeAllObjects];
    
    while((key = [enume nextObject])) {
        if ([criteres1 objectForKey:key] != @"") {
            if (!isFirstObject) {
                esperluette = @"&";
            }
            else{
                isFirstObject = NO;
            }
            bodyString = [bodyString stringByAppendingFormat:@"%@%@=%@",esperluette, key, [criteres1 valueForKey:key]];
            bodyString = [bodyString stringByAddingPercentEscapesUsingEncoding:NSISOLatin1StringEncoding];
            [criteres2 setObject:[criteres1 objectForKey:key] forKey:key];
        }
    }
    
    NSLog(@"bodyString:%@\n",bodyString);
    bodyString2 = bodyString;
    
    ASIHTTPRequest *request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:bodyString]] autorelease];
    [request setUserInfo:[NSDictionary dictionaryWithObject:[NSString stringWithString:@"recherche multicriteres"] forKey:@"name"]];
    [networkQueue addOperation:request];
    
    [networkQueue go];
}

- (void)requestDone:(ASIHTTPRequest *)request
{
	NSData *responseData = [request responseData];
    
    NSLog(@"dataBrute long: %d",[responseData length]);
    
    NSString * string = [[NSString alloc] initWithData:responseData encoding:NSISOLatin1StringEncoding];
    NSLog(@"REPONSE DU WEB: \"%@\"\n",string);
    
    NSError *error = nil;
    
    if ([string length] > 0) {
        
        NSUInteger zap = 60;
        
        NSData *dataString = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        NSData *data = [[NSData alloc] initWithData:[dataString subdataWithRange:NSMakeRange(59, [dataString length] - zap)]];
        
        //ON PARSE DU XML
        
        /*--- POUR LE TEST OFF LINE ---
         NSFileManager *fileManager = [NSFileManager defaultManager];
         NSString *xmlSamplePath = [[NSBundle mainBundle] pathForResource:@"Biens" ofType:@"xml"];
         data = [fileManager contentsAtPath:xmlSamplePath];
         string = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
         NSLog(@"REPONSE DU WEB: %@\n",string);
         */
        
        if ([string rangeOfString:@"<biens></biens>"].length != 0) {
            //AUCUNE ANNONCES
            NSDictionary *userInfo = [NSDictionary 
                                      dictionaryWithObject:@"Aucun bien ne correspond à ces critères dans notre base de données."
                                      forKey:NSLocalizedDescriptionKey];
            
            error =[NSError errorWithDomain:@"Aucun bien trouvé."
                                       code:1 userInfo:userInfo];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aucun bien trouvé"
                                                            message:[error localizedDescription]
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        else{
            NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
            XMLParser *parser = [[XMLParser alloc] initXMLParser];
            
            [xmlParser setDelegate:parser];
            
            BOOL success = [xmlParser parse];
            
            if(success)
                NSLog(@"No Errors on XML parsing.");
            else
                NSLog(@"Error on XML parsing!!!");
            
            AfficheListeAnnoncesController3 *afficheListeAnnoncesController = 
            [[AfficheListeAnnoncesController3 alloc] init];
            [self.navigationController pushViewController:afficheListeAnnoncesController animated:YES];
            [afficheListeAnnoncesController release];
            
        }
        [string release];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    UIAlertView *alert;
    
    NSLog(@"Connection failed! Error - %@",
          [error localizedDescription]);
    
    if (!isConnectionErrorPrinted) {
        alert = [[UIAlertView alloc] initWithTitle:@"Erreur de connection."
                                           message:[error localizedDescription]
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
        [alert show];
        [alert release];
        isConnectionErrorPrinted = YES;
    }
}

- (void) buttonModifierPushed:(id)sender
{
	UIButton *button = sender;
    
	switch (button.tag) {
		case 11:
            NSLog(@"Mod Recherche 1");
            appDelegate.whichView = @"favoris_modifier";
            
            [self.navigationController pushViewController:rechercheMulti animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"rechercheSauveeFavoris"
                                                                object:[recherchesSauvees objectAtIndex:0]];
			break;
		case 12:
            NSLog(@"Mod Recherche 2");
            appDelegate.whichView = @"favoris_modifier";
            
            [self.navigationController pushViewController:rechercheMulti animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"rechercheSauveeFavoris"
                                                                object:[recherchesSauvees objectAtIndex:1]];
            break;
        case 13:
            NSLog(@"Mod Recherche 3");
            appDelegate.whichView = @"favoris_modifier";
            
            [self.navigationController pushViewController:rechercheMulti animated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"rechercheSauveeFavoris"
                                                                object:[recherchesSauvees objectAtIndex:2]];
            break;
        default:
			break;
	}
}

- (void) buttonSupprimerPushed:(id)sender
{
	UIButton *button = sender;
	switch (button.tag) {
		case 21:
            [self effaceRecherche:1];
            break;
		case 22:
            [self effaceRecherche:2];
            break;
        case 23:
            [self effaceRecherche:3];
            break;
        case 111:
            NSLog(@"EFFACER BIEN FAVORI 1");
            [self effaceBien:1];
            break;
        case 222:
            NSLog(@"EFFACER BIEN FAVORI 2");
            [self effaceBien:2];
            break;
        default:
			break;
	}
}

- (void) effaceRecherche:(int)num{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    [fileManager removeItemAtPath:
     [directory stringByAppendingPathComponent:[NSString stringWithFormat:@"%d.plist",num]]
                            error:NULL];

    switch (num) {
        case 1:
            labelType1.text = @"Aucun critères";
            labelVille1.text = @"";
            labelSurface1.text = @"";
            labelPrix1.text = @"";
            boutonRangee1.userInteractionEnabled = NO;
            break;
        case 2:
            labelType2.text = @"Aucun critères";
            labelVille2.text = @"";
            labelSurface2.text = @"";
            labelPrix2.text = @"";
            boutonRangee2.userInteractionEnabled = NO;
            break;
        case 3:
            labelType3.text = @"Aucun critères";
            labelVille3.text = @"";
            labelSurface3.text = @"";
            labelPrix3.text = @"";
            boutonRangee3.userInteractionEnabled = NO;
            break;
        default:
            break;
    }
}

- (void) effaceBien:(int)num{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    [fileManager removeItemAtPath:
     [directory stringByAppendingPathComponent:[NSString stringWithFormat:@"bien%d.plist",num]]
                            error:NULL];
    
    switch (num) {
        case 1:
            labelVilleBien1.text = @"";
            labelSurfaceBien1.text = @"";
            labelPrixBien1.text = @"";
            [imgBien1 removeFromSuperview];
            boutonBien1.userInteractionEnabled = NO;
            break;
        case 2:
            labelVilleBien2.text = @"";
            labelSurfaceBien2.text = @"";
            labelPrixBien2.text = @"";
            [imgBien2 removeFromSuperview];
            boutonBien2.userInteractionEnabled = NO;
            break;
        default:
            break;
    }
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) getRecherches{
    [recherchesSauvees removeAllObjects];
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
	NSMutableDictionary *recherche;
    
    noRecherche = YES;
    int i = 0;
	for (i = 0; i < 3; i++) {
		[recherchesSauvees addObject:@""];
		
		recherche = [NSMutableDictionary dictionaryWithContentsOfFile:
					 [directory stringByAppendingPathComponent:
					  [NSString stringWithFormat:@"%d.plist",i+1]]];
		
		if (recherche != nil) {
            noRecherche = NO;
			[recherchesSauvees replaceObjectAtIndex:i withObject:recherche];
		}
		
	}
    if (noRecherche == NO) {
        i = 0;
        for (i = 0; i < 3; i++) {
            @try{
                recherche = [recherchesSauvees objectAtIndex:i];
            }
            @catch(NSException* ex){
                break;
            }
            NSLog(@"recherche%d: %@", i, recherche);
            
            if(recherche == nil)
            {
                switch (i) {
                    case 0:
                        boutonRangee1.userInteractionEnabled = NO;
                    break;
                    case 1:
                        boutonRangee2.userInteractionEnabled = NO;
                        break;
                    case 2:
                        boutonRangee3.userInteractionEnabled = NO;
                        break;
                    default:
                        break;
                }
            }
            
            if (recherche != @"") {
                
                switch (i) {
                    case 0:
                        boutonRangee1.userInteractionEnabled = YES;
                        break;
                    case 1:
                        boutonRangee2.userInteractionEnabled = YES;
                        break;
                    case 2:
                        boutonRangee3.userInteractionEnabled = YES;
                        break;
                    default:
                        break;
                }
                
                NSString *typesInt = [recherche objectForKey:@"types"];
                
                NSArray *types = [typesInt componentsSeparatedByString:@","];
                NSString *typeString = @"";
                
                for (NSString *type in types) {
                    if (type != @"") {
                        
                        switch ([type intValue]) {
                            case 0:
                                typeString = [typeString stringByAppendingString:@"Appartement "];
                                break;
                            case 1:
                                typeString = [typeString stringByAppendingString:@"Maison "];
                                break;
                            case 2:
                                typeString = [typeString stringByAppendingString:@"Terrain "];
                                break;
                            case 3:
                                typeString = [typeString stringByAppendingString:@"Bureau "];
                                break;
                            case 4:
                                typeString = [typeString stringByAppendingString:@"Commerce "];
                                break;
                            case 5:
                                typeString = [typeString stringByAppendingString:@"Immeuble "];
                                break;
                            case 6:
                                typeString = [typeString stringByAppendingString:@"Parking "];
                                break;
                            case 7:
                                typeString = [typeString stringByAppendingString:@"Autre "];
                                break;
                            default:
                                break;
                        }
                    }
                }
                
                switch (i) {
                    case 0:
                        labelType1.text = typeString;
                        break;
                    case 1:
                        labelType2.text = typeString;
                        break;
                    case 2:
                        labelType3.text = typeString;
                        break;
                    default:
                        break;
                }
                
                NSString *ville = [recherche objectForKey:@"ville1"];
                
                switch (i) {
                    case 0:
                        labelVille1.text = ville;
                        break;
                    case 1:
                        labelVille2.text = ville;
                        break;
                    case 2:
                        labelVille3.text = ville;
                        break;
                    default:
                        break;
                }
                
                NSString *prix_mini = [recherche objectForKey:@"prix_mini"];
                NSString *prix_maxi = [recherche objectForKey:@"prix_maxi"];
                NSString *prix = @"";
                NSLog(@"prix_mini: %@",prix_mini);
                
                if (prix_mini != nil && prix_maxi != nil) {
                    NSNumber *formattedResult;
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    [formatter setGroupingSeparator:@" "];
                    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    
                    formattedResult = [NSNumber numberWithInt:[prix_mini intValue]];
                    prix_mini = [formatter stringForObjectValue:formattedResult];
                    
                    formattedResult = [NSNumber numberWithInt:[prix_maxi intValue]];
                    prix_maxi = [formatter stringForObjectValue:formattedResult];
                    //
                    [formatter release];
                    
                    prix = [NSString stringWithFormat:@"de %@€ à %@€", prix_mini, prix_maxi];
                }
                
                if (prix_mini != nil && prix_maxi == nil) {
                    NSNumber *formattedResult;
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    [formatter setGroupingSeparator:@" "];
                    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    
                    formattedResult = [NSNumber numberWithInt:[prix_mini intValue]];
                    prix_mini = [formatter stringForObjectValue:formattedResult];
                    
                    [formatter release];
                    
                    prix = [NSString stringWithFormat:@"à partir de %@€", prix_mini];
                }
                
                if (prix_mini == nil && prix_maxi != nil) {
                    NSNumber *formattedResult;
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    [formatter setGroupingSeparator:@" "];
                    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    
                    formattedResult = [NSNumber numberWithInt:[prix_maxi intValue]];
                    prix_maxi = [formatter stringForObjectValue:formattedResult];
                    
                    [formatter release];
                    
                    prix = [NSString stringWithFormat:@"jusqu'à %@€", prix_maxi];
                }
                
                switch (i) {
                    case 0:
                        labelPrix1.text = prix;
                        break;
                    case 1:
                        labelPrix2.text = prix;
                        break;
                    case 2:
                        labelPrix3.text = prix;
                        break;
                    default:
                        break;
                }
                
                NSString *surface_mini = [recherche objectForKey:@"surface_mini"];
                NSString *surface_maxi = [recherche objectForKey:@"surface_maxi"];
                NSString *surface = @"";
                
                if (surface_mini != nil && surface_maxi != nil) {
                    NSNumber *formattedResult;
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    [formatter setGroupingSeparator:@" "];
                    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    
                    formattedResult = [NSNumber numberWithInt:[surface_mini intValue]];
                    surface_mini = [formatter stringForObjectValue:formattedResult];
                    
                    formattedResult = [NSNumber numberWithInt:[surface_maxi intValue]];
                    surface_maxi = [formatter stringForObjectValue:formattedResult];
                    
                    [formatter release];
                    //€
                    surface = [NSString stringWithFormat:@"de %@m² à %@m²", surface_mini, surface_maxi];
                }
                
                if (surface_mini != nil && surface_maxi == nil) {
                    NSNumber *formattedResult;
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    [formatter setGroupingSeparator:@" "];
                    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    
                    formattedResult = [NSNumber numberWithInt:[surface_mini intValue]];
                    surface_mini = [formatter stringForObjectValue:formattedResult];
                    
                    [formatter release];
                    
                    surface = [NSString stringWithFormat:@"à partir de %@m²", surface_mini];
                }
                
                if (surface_mini == nil && surface_maxi != nil) {
                    NSNumber *formattedResult;
                    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                    [formatter setGroupingSeparator:@" "];
                    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                    
                    formattedResult = [NSNumber numberWithInt:[surface_maxi intValue]];
                    surface_maxi = [formatter stringForObjectValue:formattedResult];
                    
                    [formatter release];
                    
                    surface = [NSString stringWithFormat:@"jusqu'à %@m²", surface_maxi];
                }
                
                switch (i) {
                    case 0:
                        labelSurface1.text = surface;
                        break;
                    case 1:
                        labelSurface2.text = surface;
                        break;
                    case 2:
                        labelSurface3.text = surface;
                        break;
                    default:
                        break;
                }
                
            }
        }
    }
}

- (void) getBiens{
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSDictionary *bien1 = [NSDictionary dictionaryWithContentsOfFile:
                           [directory stringByAppendingPathComponent:@"bien1.plist"]];
    
    NSDictionary *bien2 = [NSDictionary dictionaryWithContentsOfFile:
                           [directory stringByAppendingPathComponent:@"bien2.plist"]];
    
    if (bien1 == nil) {
        boutonBien1.userInteractionEnabled = NO;
    }
    
    if (bien2 == nil) {
        boutonBien2.userInteractionEnabled = NO;
    }
    
    if (bien1 != nil) {
        boutonBien1.userInteractionEnabled = YES;
        [biensSauves addObject:bien1];
        
        /*--- AFFICHAGE DES INFOS ---*/
        NSString *prix = [bien1 valueForKey:@"prix"];
        
        NSNumber *formattedResult;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setGroupingSeparator:@" "];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
        formattedResult = [NSNumber numberWithInt:[prix intValue]];
        prix = [formatter stringForObjectValue:formattedResult];
        
        NSString *prixPrint = [NSString stringWithFormat:@"%@ €", prix];
        
        [formatter release];
        
        labelPrixBien1.text = prixPrint;
        
        NSString *ville = [bien1 valueForKey:@"ville"];
        ville = [ville stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *cp = [bien1 valueForKey:@"cp"];
        cp = [cp stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *villePrint = [NSString stringWithFormat:@"%@ - %@", ville, cp];
        
        labelVilleBien1.text = villePrint;
        
        NSString *surface = [bien1 valueForKey:@"surface"];
        surface = [surface stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *nb_pieces = [bien1 valueForKey:@"nb_pieces"];
        nb_pieces = [nb_pieces stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *surfacePrint = [NSString stringWithFormat:@"%@ piece(s) - %@ m²", nb_pieces, surface];
        
        labelSurfaceBien1.text = surfacePrint;
        
        NSString *string = [bien1 valueForKey:@"photos"];
        NSLog(@"string photos: %@",string);
        
        /*UIImage *image= [UIImage imageNamed:@"appareil-photo-photographie-icone-6076-64.png"];
        
        [imgBien1 setImage:image];*/
        
        [NSThread detachNewThreadSelector:@selector(loadImage:) toTarget:self withObject:[NSArray arrayWithObjects:imgBien1, string, nil]];
        /*--- AFFICHAGE DES INFOS ---*/
    }
    
    if (bien2 != nil) {
        boutonBien2.userInteractionEnabled = YES;
        [biensSauves addObject:bien2];
        
        /*--- AFFICHAGE DES INFOS ---*/
        NSString *prix = [bien2 valueForKey:@"prix"];
        
        NSNumber *formattedResult;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setGroupingSeparator:@" "];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
        formattedResult = [NSNumber numberWithInt:[prix intValue]];
        prix = [formatter stringForObjectValue:formattedResult];
        
        NSString *prixPrint = [NSString stringWithFormat:@"%@ €", prix];
        
        [formatter release];
        
        labelPrixBien2.text = prixPrint;
        
        NSString *ville = [bien2 valueForKey:@"ville"];
        ville = [ville stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *cp = [bien2 valueForKey:@"cp"];
        cp = [cp stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *villePrint = [NSString stringWithFormat:@"%@ - %@", ville, cp];
        
        labelVilleBien2.text = villePrint;
        
        NSString *surface = [bien2 valueForKey:@"surface"];
        surface = [surface stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *nb_pieces = [bien2 valueForKey:@"nb_pieces"];
        nb_pieces = [nb_pieces stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSString *surfacePrint = [NSString stringWithFormat:@"%@ piece(s) - %@ m²", nb_pieces, surface];
        
        labelSurfaceBien2.text = surfacePrint;
        
        NSString *string = [bien2 valueForKey:@"photos"];
        NSLog(@"string photos: %@",string);
        
        /*UIImage *image= [UIImage imageNamed:@"appareil-photo-photographie-icone-6076-64.png"];
        
        [imgBien1 setImage:image];*/
        
        [NSThread detachNewThreadSelector:@selector(loadImage:) toTarget:self withObject:[NSArray arrayWithObjects:imgBien2, string, nil]];
        /*--- AFFICHAGE DES INFOS ---*/
    }
}

- (void) loadImage:(NSArray *)tableau{
    NSAutoreleasePool *pool;
    pool = [[NSAutoreleasePool alloc]init];
    
    UIImageView *imgViewBien = [tableau objectAtIndex:0];
	NSString *string = [tableau objectAtIndex:1];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([string length] > 0) {
        NSMutableArray * images;
		images = [[NSMutableArray alloc] initWithArray:[string componentsSeparatedByString:@","]];
		NSData* imageData = [[NSData alloc]initWithContentsOfURL:
                             [NSURL URLWithString:
                              [NSString stringWithFormat:@"%@",
                               [images objectAtIndex:0]]]];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        
        
        [imgViewBien setImage:image];
        
        [images	release];
        [imageData release];
        [image release];
        [pool release];
    }
}

- (void) afficheAnnonceFavorisReady:(NSNotification *)notify {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"afficheAnnonceFavoris" object: annonceSelected];
}

- (void) viewWillAppear:(BOOL)animated{
    [self getRecherches];
    [self getBiens];
}

- (void) viewWillDisappear:(BOOL)animated{
    UIView *view;
    
    for (view in [self.navigationController.view subviews]) {
        if (view == pvc.view) {
            [pvc.view removeFromSuperview];
        }
    }
}

- (void)dealloc {
    [recherchesSauvees release];
    [biensSauves release];
    
    [labelType1 release];
    [labelType2 release];
    [labelType3 release];
    
    [labelVille1 release];
    [labelVille2 release];
    [labelVille3 release];
    
    [labelPrix1 release];
    [labelPrix2 release];
    [labelPrix3 release];
    
    [labelSurface1 release];
    [labelSurface2 release];
    [labelSurface3 release];
    
    [rechercheMulti release];
    [tableauAnnonces1 release];
    [criteres2 release];
    
    [labelPrixBien1 release];
    [labelPrixBien2 release];
    
    [labelVilleBien1 release];
    [labelVilleBien2 release];
    
    [labelSurfaceBien1 release];
    [labelSurfaceBien2 release];
    
    [imgBien1 release];
    [imgBien2 release];
    
    [pvc release];
    [annonceSelected release];
    
    [super dealloc];
}


@end
