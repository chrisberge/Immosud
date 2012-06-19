//
//  AgenceViewController.m
//  Immosud
//
//  Created by Christophe Bergé on 14/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AgenceViewController.h"


@implementation AgenceViewController

@synthesize whichView;
@synthesize tableauAnnonces1;

- (void)agenceModalViewDidFinish:(AgenceModalView *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)agenceModalViewFicheDidFinish:(AfficheAnnonceController3 *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)agenceModalVendreDidFinish:(AgenceModalVendre *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)agenceModalEstimationDidFinish:(AgenceModalEstimation *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)agenceModalPresAkiosDidFinish:(AgenceModalPresAkios *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [myOpenFlowView release];
    [tableauAnnonces1 release];
    [networkQueue release];
    [pvc release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(afficheTextReady:) name:@"afficheTextReady" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(coverFlowAgence:) name:@"coverFlowAgence" object: nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(afficheAnnonce3Ready:) name:@"afficheAnnonce3Ready" object: nil];
    
    //COULEUR DE FOND
    UIColor *fond = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = fond;
    [fond release];
    //self.view.backgroundColor = [UIColor blueColor];
    
    //HEADER
    UIImageView *enTete = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
    [enTete setFrame:CGRectMake(0,0,320,50)];
    [self.view addSubview:enTete];
    [enTete release];
    
    //BANDEAU AGENCE
    UIImageView *bandeauFavoris = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bandeau-agence.png"]];
    [bandeauFavoris setFrame:CGRectMake(0,50,320,20)];
    [self.view addSubview:bandeauFavoris];
    [bandeauFavoris release];
    
    //POSITIONS BOUTONS
    int x1 = 30;
    int x2 = 165;
    int y1 = 75;
    int y2 = 135;
    int y3 = 195;
    int w = 120;
    
    /*--- BOUTON ESTIMATION ---*/
    UIButton *boutonEstimation = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonEstimation setFrame:CGRectMake(x1, y1, w, 50)];
	[boutonEstimation setUserInteractionEnabled:YES];
	[boutonEstimation addTarget:self action:@selector(buttonPushed:) 
               forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image = [UIImage imageNamed:@"portail-demande-estimation.png"];
	[boutonEstimation setImage:image forState:UIControlStateNormal];
    
    boutonEstimation.showsTouchWhenHighlighted = NO;
    boutonEstimation.tag = 3;
	
	[self.view addSubview:boutonEstimation];
    /*--- BOUTON ESTIMATION ---*/
    /*--- BOUTON VENDRE ---*/
    UIButton *boutonVendre = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonVendre setFrame:CGRectMake(x2, y1, w, 50)];
	[boutonVendre setUserInteractionEnabled:YES];
	[boutonVendre addTarget:self action:@selector(buttonPushed:) 
               forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"vendre-un-bien.png"];
	[boutonVendre setImage:image forState:UIControlStateNormal];
    
    boutonVendre.showsTouchWhenHighlighted = NO;
    boutonVendre.tag = 2;
	
	[self.view addSubview:boutonVendre];
    /*--- BOUTON VENDRE ---*/
    /*--- BOUTON AGENCE ---*/
    UIButton *boutonAgence = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonAgence setFrame:CGRectMake(x1, y2, w, 50)];
	[boutonAgence setUserInteractionEnabled:YES];
	[boutonAgence addTarget:self action:@selector(buttonPushed:) 
           forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"portail-presentation.png"];
	[boutonAgence setImage:image forState:UIControlStateNormal];
    
    boutonAgence.showsTouchWhenHighlighted = NO;
    boutonAgence.tag = 1;
	
	[self.view addSubview:boutonAgence];
    /*--- BOUTON AGENCE ---*/
    /*--- BOUTON EMAIL ---*/
    UIButton *boutonEmail = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonEmail setFrame:CGRectMake(x2, y2, w, 50)];
	[boutonEmail setUserInteractionEnabled:YES];
	[boutonEmail addTarget:self action:@selector(buttonPushed:) 
          forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"portail-email.png"];
	[boutonEmail setImage:image forState:UIControlStateNormal];
    
    boutonEmail.showsTouchWhenHighlighted = NO;
    boutonEmail.tag = 4;
	
	[self.view addSubview:boutonEmail];
    /*--- BOUTON EMAIL ---*/
    /*--- BOUTON EMAIL RECOMMANDATION ---*/
    UIButton *boutonEmailR = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonEmailR setFrame:CGRectMake(x1, y3, w, 50)];
	[boutonEmailR setUserInteractionEnabled:YES];
	[boutonEmailR addTarget:self action:@selector(buttonPushed:) 
           forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"portail-recommander.png"];
	[boutonEmailR setImage:image forState:UIControlStateNormal];
    
    boutonEmailR.showsTouchWhenHighlighted = NO;
    boutonEmailR.tag = 5;
	
	[self.view addSubview:boutonEmailR];
    /*--- BOUTON EMAIL RECOMMANDATION ---*/
    /*--- BOUTON SITE AKIOS ---*/
    UIButton *boutonSite = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonSite setFrame:CGRectMake(x2, y3, w, 50)];
	[boutonSite setUserInteractionEnabled:YES];
	[boutonSite addTarget:self action:@selector(buttonPushed:) 
         forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"developpement_akios.png"];
	[boutonSite setImage:image forState:UIControlStateNormal];
    
    boutonSite.showsTouchWhenHighlighted = NO;
    boutonSite.tag = 6;
	
	[self.view addSubview:boutonSite];
    /*--- BOUTON SITE AKIOS ---*/
    
    //REQUETE HTTP POUR AVOIR LES BIENS RECENTS
    isConnectionErrorPrinted = NO;
    
    tableauAnnonces1 = [[NSMutableArray alloc] init];
    
    ImmosudAppDelegate *appDelegate = (ImmosudAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.whichView = @"agence";
    
    [NSThread detachNewThreadSelector:@selector(printHUD) toTarget:self withObject:nil];
    [self makeRequest];
    //[self makeCoverFlow];
}

- (void) printHUD{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    pvc = [[ProgressViewContoller alloc] init];
    //[pvc.view setFrame:CGRectMake(0, 0, 320, 480)];
    [self.view addSubview:pvc.view];
    
    [pool release];
    
}

- (void) buttonPushed:(id)sender
{
	UIButton *button = sender;
    AgenceModalView *agenceModalView = [[AgenceModalView alloc] init];
    agenceModalView.delegate = self;
    
    AgenceModalVendre *agenceModalVendre = [[AgenceModalVendre alloc] init];
    agenceModalVendre.delegate = self;
    
    AgenceModalEstimation *agenceModalEstimation = [[AgenceModalEstimation alloc] init];
    agenceModalEstimation.delegate = self;
    
    AgenceModalPresAkios *agenceModalPresAkios = [[AgenceModalPresAkios alloc] init];
    agenceModalPresAkios.delegate = self;
    
	switch (button.tag) {
        NSError *error = nil;
        NSString *fullPath;
        NSString *texte;

		case 1:
            NSLog(@"Agence");
            buttonTag = [NSNumber numberWithInt:button.tag];
            agenceModalView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentModalViewController:agenceModalView animated:YES];
            [agenceModalView release];
			break;
		case 2:
            NSLog(@"Vendre");
            //buttonTag = [NSNumber numberWithInt:button.tag];
            agenceModalVendre.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentModalViewController:agenceModalVendre animated:YES];
            [agenceModalVendre release];
            break;
        case 3:
            NSLog(@"Estimaton");
            //buttonTag = [NSNumber numberWithInt:button.tag];
            agenceModalEstimation.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentModalViewController:agenceModalEstimation animated:YES];
            [agenceModalEstimation release];
            break;
        case 4:
            NSLog(@"email.");
            error = nil;
            
            fullPath = [[NSBundle mainBundle] pathForResource:@"email-agence" ofType:@"txt"];
            texte = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:&error];
            
            NSString *htmlBody = [NSString stringWithFormat:@""]; 
            
            NSString *escapedBody = [(NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)htmlBody, NULL, CFSTR("?=&+"), kCFStringEncodingISOLatin1) autorelease];
            
            NSString *mailtoPrefix = [[NSString stringWithFormat:@"mailto:%@?subject=Demande d'informations&body=",texte] stringByAddingPercentEscapesUsingEncoding:NSISOLatin1StringEncoding];
            
            NSString *mailtoStr = [mailtoPrefix stringByAppendingString:escapedBody];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailtoStr]];
            break;
        case 5:
            NSLog(@"email recommandation.");
            error = nil;
            
            fullPath = [[NSBundle mainBundle] pathForResource:@"nom-appli" ofType:@"txt"];
            texte = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:&error];
            
            NSString *htmlBody2 = [NSString stringWithFormat:@""]; 
            
            NSString *escapedBody2 = [(NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)htmlBody2, NULL, CFSTR("?=&+"), kCFStringEncodingISOLatin1) autorelease];
            
            NSString *mailtoPrefix2 = [[NSString stringWithFormat:@"mailto:?subject=Un ami vous recommande l'application %@&body=",
                                        texte] stringByAddingPercentEscapesUsingEncoding:NSISOLatin1StringEncoding];
            
            NSString *mailtoStr2 = [mailtoPrefix2 stringByAppendingString:escapedBody2];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailtoStr2]];
            break;
        case 6:
            NSLog(@"FLIP PRESENTATION AKIOS");
            buttonTag = [NSNumber numberWithInt:button.tag];
            agenceModalPresAkios.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentModalViewController:agenceModalPresAkios animated:YES];
            [agenceModalPresAkios release];
            break;
		default:
			break;
	}
}

- (void) coverFlowAgence:(NSNotification *)notify{
    NSNumber *num = [notify object];
    
    annonceSelected = [tableauAnnonces1 objectAtIndex:[num intValue]];
    
    [NSThread detachNewThreadSelector:@selector(printHUD) toTarget:self withObject:nil];
    
    AfficheAnnonceController3 *aMVF = [[AfficheAnnonceController3 alloc] init];
    
    aMVF.delegate = self;
    aMVF.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:aMVF animated:YES];
    [aMVF release];
    aMVF = nil;
    
}

- (void) afficheAnnonce3Ready:(NSNotification *)notify {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"afficheAnnonce3" object: annonceSelected];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"whichViewFrom" object: @"Agence"];
    [myOpenFlowView centerOnSelectedCover:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [pvc.view removeFromSuperview];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)afficheTextReady:(NSNotification *)notify{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"afficheText" object: buttonTag];
}

- (void)makeCoverFlow{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *xmlSamplePath = [[NSBundle mainBundle] pathForResource:@"Biens" ofType:@"xml"];
    NSData *data = [fileManager contentsAtPath:xmlSamplePath];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"REPONSE DU WEB: %@\n",string);
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
    XMLParser *parser = [[XMLParser alloc] initXMLParser];
    
    [xmlParser setDelegate:parser];
    
    BOOL success = [xmlParser parse];
    
    if(success)
        NSLog(@"No Errors on XML parsing.");
    else
        NSLog(@"Error on XML parsing!!!");
    
    //COVER FLOW
    NSMutableArray *imagesArray = [[NSMutableArray alloc] init];
    
    for (Annonce *uneAnnonce in tableauAnnonces1) {
        NSString *photos = [uneAnnonce valueForKey:@"photos"];
        NSLog(@"COVERFLOW: \"%@\"",photos);
        photos = [photos stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        //photos = [photos stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if ([photos length] > 0) {
            [imagesArray addObject:[[NSMutableArray arrayWithArray:[photos componentsSeparatedByString:@","]] objectAtIndex:0]];
        }
    }
    
    
    myOpenFlowView = [[AFOpenFlowView alloc] init];
    int num = [imagesArray count];
    [myOpenFlowView setNumberOfImages:num];
    
    [myOpenFlowView setFrame:CGRectMake(10, 260, 300, 130)];
    for (int index = 0; index < num; index++){
        NSData* imageData = [[NSData alloc]initWithContentsOfURL:
                             [NSURL URLWithString:
                              [NSString stringWithFormat:@"%@",
                               [imagesArray objectAtIndex:index]]]];
        if (imageData != nil) {
            UIImage *image = [[UIImage alloc] initWithData:imageData];
            [myOpenFlowView setImage:image forIndex:index];
        }
        [imageData release];
    }
    
    [self.view addSubview:myOpenFlowView];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"whichViewFrom" object: @"Accueil"];
    
    [pvc.view removeFromSuperview];
    
    [xmlParser release];
    [parser release];
}

- (void)makeRequest{
    /*--- QUEUE POUR LES REQUETES HTTP ---*/
    networkQueue = [[ASINetworkQueue alloc] init];
    [networkQueue reset];
	[networkQueue setRequestDidFinishSelector:@selector(requestDone:)];
	[networkQueue setRequestDidFailSelector:@selector(requestFailed:)];
	[networkQueue setDelegate:self];
    /*--- QUEUE POUR LES REQUETES HTTP ---*/
    NSString *bodyString = @"http://www.akios.fr/immobilier/smart_phone.php?part=Immosud&id_agence=IMMOSUD_PORTAIL&coverflow=YES";
    //NSString *bodyString = @"http://zilek.com/akios_query.pl?coverflow=YES";
    
    NSLog(@"bodyString:%@\n",bodyString);
    
    ASIHTTPRequest *request = [[[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:bodyString]] autorelease];
    [request setUserInfo:[NSDictionary dictionaryWithObject:[NSString stringWithString:@"biens recents"] forKey:@"name"]];
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
            
            //COVER FLOW
            NSMutableArray *imagesArray = [[NSMutableArray alloc] init];
            
            for (Annonce *uneAnnonce in tableauAnnonces1) {
                NSString *photos = [uneAnnonce valueForKey:@"photos"];
                photos = [photos stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                //photos = [photos stringByReplacingOccurrencesOfString:@" " withString:@""];
                
                if ([photos length] > 0) {
                    [imagesArray addObject:[[NSMutableArray arrayWithArray:[photos componentsSeparatedByString:@","]] objectAtIndex:0]];
                }
            }
            
            
            myOpenFlowView = [[AFOpenFlowView alloc] init];
            int num = [imagesArray count];
            [myOpenFlowView setNumberOfImages:num];
            
            [myOpenFlowView setFrame:CGRectMake(10, 260, 300, 130)];
            for (int index = 0; index < num; index++){
                NSData* imageData = [[NSData alloc]initWithContentsOfURL:
                                     [NSURL URLWithString:
                                      [NSString stringWithFormat:@"%@",
                                       [imagesArray objectAtIndex:index]]]];
                if (imageData != nil) {
                    UIImage *image = [[UIImage alloc] initWithData:imageData];
                    [myOpenFlowView setImage:image forIndex:index];
                }
                [imageData release];
            }
            
            [self.view insertSubview:myOpenFlowView belowSubview:pvc.view];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"whichViewFrom" object: @"Agence"];
            
            [pvc.view removeFromSuperview];
        }
    }
    [string release];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    UIAlertView *alert;
    
    NSLog(@"Connection failed! Error - %@",
          [error localizedDescription]);
    
    [pvc.view removeFromSuperview];
    
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
    [pvc.view removeFromSuperview];
}

@end
