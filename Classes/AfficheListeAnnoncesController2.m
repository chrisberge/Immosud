//
//  AfficheListeAnnoncesController2.m
//  Immosud
//
//  Created by Christophe Bergé on 12/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AfficheListeAnnoncesController2.h"


@implementation AfficheListeAnnoncesController2

@synthesize /*listeAnnonces, criteres,*/ annonceSelected;

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
    //self.navigationController.navigationBar.hidden = YES;
    //criteres = [[NSMutableDictionary alloc] init];
    //listeAnnonces = [[NSMutableArray alloc] init];
    
    appDelegate = (ImmosudAppDelegate *)[[UIApplication sharedApplication] delegate];
    page = 1;
    bodyString = @"";
    
    listeAnnonces = appDelegate.accueilView.myTableViewController.tableauAnnonces1;
    //criteres = [NSMutableDictionary dictionaryWithDictionary:appDelegate.accueilView.myTableViewController.criteres2];
	criteres = appDelegate.accueilView.myTableViewController.criteres2;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(nextResults:) name:@"nextResults" object: nil];
    
    /*UIColor *fond = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = fond;
    [fond release];*/
    self.view.backgroundColor = [UIColor whiteColor];
    
    //HEADER
    UIImageView *enTete = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
    [enTete setFrame:CGRectMake(0,0,320,50)];
    [self.view addSubview:enTete];
    [enTete release];
    
    //BOUTON RETOUR
    UIButton *boutonRetour = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonRetour.showsTouchWhenHighlighted = NO;
    boutonRetour.tag = 3;
    
    [boutonRetour setFrame:CGRectMake(10,7,50,30)];
    [boutonRetour addTarget:self action:@selector(buttonPushed:) 
           forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image = [UIImage imageNamed:@"bouton-retour.png"];
    [boutonRetour setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonRetour];
    
    //BANDEAU RESULTATS DE RECHERCHE
    UIImageView *bandeauFavoris = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bandeau-resultat-recherche.png"]];
    [bandeauFavoris setFrame:CGRectMake(0,50,320,20)];
    [self.view addSubview:bandeauFavoris];
    [bandeauFavoris release];
    
    //BANDEAU VIERGE
    UIImageView *vierge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bandeau-vierge.png"]];
    [vierge setFrame:CGRectMake(0,72,320,20)];
    [self.view addSubview:vierge];
    [vierge release];
    
    //CRITERES DANS LE BANDEAU
    UIScrollView *textScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 72, 320, 20)];
    textScroll.contentSize = CGSizeMake(640, 20);
    textScroll.userInteractionEnabled = YES;
    textScroll.scrollsToTop = YES;
    
    UITextView *criteresTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 1000, 20)];
    criteresTextView.text = @"";

    NSString *text = @"";
    
    if ([criteres valueForKey:@"transaction"] != @"") {
        if ([criteres valueForKey:@"transaction"] == @"0") {
            text = @"Ventes - ";
        }
        if ([criteres valueForKey:@"transaction"] == @"1") {
            text = @"Locations - ";
        }
    }
    
    if ([criteres valueForKey:@"ville1"] != NULL) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"%@",[criteres valueForKey:@"ville1"]]];
    }
    
    NSString *cp1 = [criteres valueForKey:@"cp1"];
    if (cp1 != NULL) {
        int cp1Int = [cp1 intValue];
        NSString *indice = @"eme";
        if ((cp1Int > 75000) && (cp1Int < 75021)) {
            if (cp1Int == 75001) {
                indice = @"er";
            }
            text = [text stringByAppendingFormat:@" - %d%@ arrondissement",cp1Int - 75000, indice];
        }
        else{
            text = [text stringByAppendingFormat:@" - %@",
                    [NSString stringWithFormat:@"%@",cp1]];
        }
    }
    
    if ([criteres valueForKey:@"prix"] != NULL)
        text = [self setTextMinMax:@"prix" unit:@"€" texte:text];
    
    if ([criteres valueForKey:@"surface"] != NULL)
        text = [self setTextMinMax:@"surface" unit:@"m²" texte:text];
    
    if (([criteres valueForKey:@"nb_pieces_maxi"] != NULL) && ([criteres valueForKey:@"nb_pieces_mini"] != NULL))
        text = [self setTextMinMax:@"nb_pieces" unit:@"piece" texte:text];
    
    criteresTextView.text = text;
    
    criteresTextView.backgroundColor = [UIColor clearColor];
    
    [textScroll addSubview:criteresTextView];
    [self.view addSubview:textScroll];
    
    [criteresTextView release];
    [textScroll release];
    
    //BOUTON TRIS
    //PAR PRIX
    boutonPrix = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonPrix setFrame:CGRectMake(40, 95, 120, 50)];
	[boutonPrix setUserInteractionEnabled:YES];
	[boutonPrix addTarget:self action:@selector(buttonPrixPushed:) 
               forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"prix-middle.png"];
	[boutonPrix setImage:image forState:UIControlStateNormal];
    
    boutonPrix.showsTouchWhenHighlighted = NO;
    boutonPrix.tag = 1;
	
	[self.view addSubview:boutonPrix];
    
    //PAR SURFACE
    boutonSurface = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonSurface setFrame:CGRectMake(162, 95, 120, 50)];
	[boutonSurface setUserInteractionEnabled:YES];
	[boutonSurface addTarget:self action:@selector(buttonSurfacePushed:) 
         forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"m2-middle.png"];
	[boutonSurface setImage:image forState:UIControlStateNormal];
    
    boutonSurface.showsTouchWhenHighlighted = NO;
    boutonSurface.tag = 11;
	
	[self.view addSubview:boutonSurface];
    
    //BANDEAU VIERGE
    vierge = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bandeau-vierge.png"]];
    [vierge setFrame:CGRectMake(0,150,320,20)];
    [self.view addSubview:vierge];
    [vierge release];
    
    //NOMBRE D'ANNONCES DANS BANDEAU
    /*UITextView *nbAnnoncesText = [[UITextView alloc] initWithFrame:CGRectMake(0, 150, 320, 20)];
    int nbAnnonces = [listeAnnonces count];
    
    if (nbAnnonces > 1) {
        nbAnnoncesText.text = [NSString stringWithFormat:@"%d biens trouvés", nbAnnonces];
    }
    else{
        nbAnnoncesText.text = [NSString stringWithFormat:@"1 bien trouvé"];
    }
                               
    nbAnnoncesText.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:nbAnnoncesText];
    
    [nbAnnoncesText release];*/
    
    //TABLE VIEW
    tableView1 = [[UITableView alloc] init];
    [tableView1 setFrame:CGRectMake(0, 170, 320, 250)];
    tableView1.contentSize = CGSizeMake(320, 1000);
    tableView1.delegate = self;
    tableView1.dataSource = self;
    //tableView1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell.png"]];
    tableView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView1];
}

/*- (void) afficheAnnonceReady:(NSNotification *)notify {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"afficheAnnonce" object: annonceSelected];
}*/

- (void) buttonPushed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) buttonPrixPushed:(id)sender
{
	UIButton *button = sender;
    UIImage *image = [UIImage imageNamed:@"m2-middle.png"];
    [boutonSurface setImage:image forState:UIControlStateNormal];
    
    NSSortDescriptor *sortDescriptor;
    NSArray *sortDescriptors;
    NSArray *sortedArray;
	switch (button.tag) {
		case 1:
            button.tag = 2;
            image = [UIImage imageNamed:@"prix-down.png"];
            [button setImage:image forState:UIControlStateNormal];
            //TRIER LES ANNONCES PAR PRIX EN ORDRE DECROISSANT
            
            sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"prix"
                                                          ascending:NO
                                                           selector:@selector(localizedStandardCompare:)] autorelease];
            sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            sortedArray = [listeAnnonces sortedArrayUsingDescriptors:sortDescriptors];
            [listeAnnonces release];
            listeAnnonces = nil;
            listeAnnonces = [[NSMutableArray alloc] initWithArray:sortedArray];
            [tableView1 reloadData];
			break;
		case 2:
            button.tag = 1;
            image = [UIImage imageNamed:@"prix-up.png"];
            [button setImage:image forState:UIControlStateNormal];
            //TRIER LES ANNONCES PAR PRIX EN ORDRE CROISSANT
            sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"prix"
                                                          ascending:YES
                                                           selector:@selector(localizedStandardCompare:)] autorelease];
            sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            sortedArray = [listeAnnonces sortedArrayUsingDescriptors:sortDescriptors];
            [listeAnnonces release];
            listeAnnonces = nil;
            listeAnnonces = [[NSMutableArray alloc] initWithArray:sortedArray];
            [tableView1 reloadData];
            break;
		default:
			break;
	}
}

- (void) buttonSurfacePushed:(id)sender
{
	UIButton *button = sender;
    UIImage *image = [UIImage imageNamed:@"prix-middle.png"];
    [boutonPrix setImage:image forState:UIControlStateNormal];
    
    NSSortDescriptor *sortDescriptor;
    NSArray *sortDescriptors;
    NSArray *sortedArray;
	switch (button.tag) {
		case 11:
            button.tag = 12;
            image = [UIImage imageNamed:@"m2-down.png"];
            [button setImage:image forState:UIControlStateNormal];
            //TRIER LES ANNONCES PAR PRIX EN ORDRE DECROISSANT
            
            sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"surface"
                                                          ascending:NO
                                                           selector:@selector(localizedStandardCompare:)] autorelease];
            sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            sortedArray = [listeAnnonces sortedArrayUsingDescriptors:sortDescriptors];
            [listeAnnonces release];
            listeAnnonces = nil;
            listeAnnonces = [[NSMutableArray alloc] initWithArray:sortedArray];
            [tableView1 reloadData];
			break;
		case 12:
            button.tag = 11;
            image = [UIImage imageNamed:@"m2-up.png"];
            [button setImage:image forState:UIControlStateNormal];
            //TRIER LES ANNONCES PAR PRIX EN ORDRE CROISSANT
            sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"surface"
                                                          ascending:YES
                                                           selector:@selector(localizedStandardCompare:)] autorelease];
            sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            sortedArray = [listeAnnonces sortedArrayUsingDescriptors:sortDescriptors];
            [listeAnnonces release];
            listeAnnonces = nil;
            listeAnnonces = [[NSMutableArray alloc] initWithArray:sortedArray];
            [tableView1 reloadData];
            break;
		default:
			break;
	}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (([listeAnnonces count] % 20) == 0) {
        return [listeAnnonces count] + 1;
    }
    else{
        return [listeAnnonces count];
    }
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    /*if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    /*else{
        UIImage *image= [UIImage imageNamed:@"appareil-photo-photographie-icone-6076-64.png"];
        UIImageView *iv = [[UIImageView alloc] initWithImage:image];
        [cell.imageView addSubview:iv];
        [iv release];
        
    }*/
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    
	// Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
	if (indexPath.row == (20 * page)) {
        cell.textLabel.text = @"Les 20 annonces suivantes";
    }
    else{
        Annonce *uneAnnonce = [listeAnnonces objectAtIndex:indexPath.row];
        
        if (cell.imageView.image == nil) {
        
            UIImage *image= [UIImage imageNamed:@"appareil-photo-photographie-icone-6076-64.png"];
            [cell.imageView setImage:image];
        
            [NSThread detachNewThreadSelector:@selector(loadImage:) toTarget:self withObject:[NSArray arrayWithObjects:cell, uneAnnonce, nil]];
        }
        
        NSNumber *formattedResult;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setGroupingSeparator:@" "];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
        NSString *prix1 = [uneAnnonce valueForKey:@"prix"];
        prix1 = [prix1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        formattedResult = [NSNumber numberWithInt:[prix1 intValue]];
        
        NSString *prix = [formatter stringForObjectValue:formattedResult];
        
        [formatter release];
        
        NSString *ville = [uneAnnonce valueForKey:@"ville"];
        NSString *texte = [[NSString alloc] initWithFormat:@"%@ € - %@",prix,ville];
        
        cell.textLabel.text = texte;
        
        //SOUS TITRE
        NSString *codePostal = [uneAnnonce valueForKey:@"cp"];
        NSString *surface = [uneAnnonce valueForKey:@"surface"];
        NSString *nbPieces = [uneAnnonce valueForKey:@"nb_pieces"];
        nbPieces = [nbPieces stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        NSString *isS = @"";
        
        if ([nbPieces intValue] > 1) {
            isS = @"s";
        }
        
        NSString *subTitle = [[NSString alloc] initWithFormat:@"%@ - %@ m² - %@ piece%@",codePostal,surface,nbPieces,isS];
        cell.detailTextLabel.text = subTitle;
        
        [texte release];
        [subTitle release];
    }
	
    return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    
    [NSThread detachNewThreadSelector:@selector(printHUD) toTarget:self withObject:nil];

    if (indexPath.row == (20 * page)) {
        page++;
        [self getNextResults];
    }
    else{
        annonceSelected = [listeAnnonces objectAtIndex:indexPath.row];
        
        appDelegate.annonceMulti = annonceSelected;
        
        AfficheAnnonceController2 *afficheAnnonceController = [[AfficheAnnonceController2 alloc] init];
        [self.navigationController pushViewController:afficheAnnonceController animated:YES];
        [afficheAnnonceController release];
	}
}

- (void)getNextResults{
    
    /*--- QUEUE POUR LES REQUETES HTTP ---*/
    ASINetworkQueue *networkQueue = [[ASINetworkQueue alloc] init];
    [networkQueue reset];
    [networkQueue setRequestDidFinishSelector:@selector(requestDone:)];
    [networkQueue setRequestDidFailSelector:@selector(requestFailed:)];
    [networkQueue setDelegate:self];
    /*--- QUEUE POUR LES REQUETES HTTP ---*/
    
    appDelegate.whichView = @"listing";
    [appDelegate.tableauAnnonces1 removeAllObjects];
    
    //bodyString = @"http://www.akios.fr/immobilier/smart_phone.php?part=Immosud&id_agence=IMMOSUD_PORTAIL&";
    
    bodyString = [NSString stringWithFormat:@"%@?part=%@&id_agence=%@&",
                  appDelegate.url_serveur,
                  appDelegate.partenaire,
                  appDelegate.id_agence];
    
    NSEnumerator *enume;
    NSString *key;
    
    [criteres setValue:[NSString stringWithFormat:@"%d", page] forKey:@"page"];
    
    enume = [criteres keyEnumerator];
    BOOL isFirstObject = YES;
    NSString *esperluette = @"";
    
    while((key = [enume nextObject])) {
        if ([criteres objectForKey:key] != @"") {
            if (!isFirstObject) {
                esperluette = @"&";
            }
            else{
                isFirstObject = NO;
            }
            bodyString = [bodyString stringByAppendingFormat:@"%@%@=%@",esperluette, key, [criteres valueForKey:key]];
            bodyString = [bodyString stringByAddingPercentEscapesUsingEncoding:NSISOLatin1StringEncoding];
        }
    }
    
    NSLog(@"bodyString: %@", bodyString);
    
    NSURL *url = [NSURL URLWithString:bodyString];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setUserInfo:[NSDictionary dictionaryWithObject:[NSString stringWithString:@"annonces suivantes"] forKey:@"name"]];
    
    [networkQueue addOperation:request];
    [networkQueue go];
}

- (void)requestDone:(ASIHTTPRequest *)request
{
	NSData *responseData = [request responseData];
    
    NSLog(@"dataBrute long: %d",[responseData length]);
    
    NSString * string = [[NSString alloc] initWithData:responseData encoding:NSISOLatin1StringEncoding];
    
    NSLog(@"REPONSE DU WEB: \"%@\"\n",string);
    
    if ([string length] > 0) {
        
        NSUInteger zap = 60;
        
        NSData *dataString = [string dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        
        NSData *data = [[NSData alloc] initWithData:[dataString subdataWithRange:NSMakeRange(59, [dataString length] - zap)]];
        
        //ON PARSE DU XML
        
        /*--- POUR LE TEST OFF LINE ---
         NSFileManager *fileManager = [NSFileManager defaultManager];
         NSString *xmlSamplePath = [[NSBundle mainBundle] pathForResource:@"Biens1" ofType:@"xml"];
         data = [fileManager contentsAtPath:xmlSamplePath];
         string = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding];
         NSLog(@"REPONSE DU WEB: %@\n",string);
         */
        
        if ([string rangeOfString:@"<biens></biens>"].length != 0) {
            //AUCUNE ANNONCES
            return;
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
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"getNextResultsReady" object: @"getNextResultsReady"];
            
            [xmlParser release];
            [parser release];
            
        }
        [string release];
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    UIAlertView *alert;
    
    NSLog(@"Connection failed! Error - %@", [error localizedDescription]);
    
    
    alert = [[UIAlertView alloc] initWithTitle:@"Erreur de connection."
                                       message:[error localizedDescription]
                                      delegate:self
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
    [alert show];
    [alert release];
    [pvc.view removeFromSuperview];
}

- (void) nextResults:(NSNotification *)notify {
    [listeAnnonces addObjectsFromArray:[notify object]];
    NSLog(@"Annonces: %@,\nNb: %d",listeAnnonces, [listeAnnonces count]);
    [pvc.view removeFromSuperview];
    [tableView1 reloadData];
}

- (void) printHUD{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    pvc = [[ProgressViewContoller alloc] init];
    [self.view addSubview:pvc.view];
    
    [pool release];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cell.png"]];
    cell.backgroundColor = [UIColor whiteColor];
}

- (void) loadImage:(NSArray *)tableau{
    NSAutoreleasePool *pool;
    pool = [[NSAutoreleasePool alloc]init];
    
    UITableViewCell *cell = [tableau objectAtIndex:0];
    Annonce *uneAnnonce = [tableau objectAtIndex:1];
    
	NSString *string = [uneAnnonce valueForKey:@"photos"];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    if ([string length] > 0) {
        NSMutableArray * images;
		images = [[NSMutableArray alloc] initWithArray:[string componentsSeparatedByString:@","]];
		NSData* imageData = [[NSData alloc]initWithContentsOfURL:
                             [NSURL URLWithString:
                              [NSString stringWithFormat:@"%@",
                               [images objectAtIndex:0]]]];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        UIImageView *iv = [[UIImageView alloc] initWithImage:image];
        [iv setFrame:CGRectMake(0, 0, 64, 64)];
        [cell.imageView addSubview:iv];
        //[cell.imageView setImage:image];
        
        [images	release];
        [imageData release];
        [image release];
        [iv release];
        [pool release];
    }
}

-(NSString *)setTextMinMax:(NSString *)critere unit:(NSString *)unit texte:(NSString *)text{
    NSString *critMin = [NSString stringWithFormat:@"%@_mini", critere];
    NSString *critMax = [NSString stringWithFormat:@"%@_maxi", critere];
    NSString *sMin = @"";
    NSString *sMax =@"s";
    
    
    if (unit == @"piece") {
        if ([critMin intValue] > 1) {
            sMin = @"s";
        }
    }
    
    if ([criteres valueForKey:critMin] != @"" && [criteres valueForKey:critMax] != @"") {
        
        NSNumber *formattedResult;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setGroupingSeparator:@" "];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
        formattedResult = [NSNumber numberWithInt:[[criteres valueForKey:critMin] intValue]];
        NSString *mini = [formatter stringForObjectValue:formattedResult];
        
        formattedResult = [NSNumber numberWithInt:[[criteres valueForKey:critMax] intValue]];
        NSString *maxi = [formatter stringForObjectValue:formattedResult];
        
        text = [text stringByAppendingFormat:@" - De %@ %@%@ à %@ %@%@",mini, unit, sMin, maxi, unit, sMax];
        
        [formatter release];
    }
    
    if ([criteres valueForKey:critMin] != @"" && [criteres valueForKey:critMax] == @"") {
        
        NSNumber *formattedResult;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setGroupingSeparator:@" "];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
        formattedResult = [NSNumber numberWithInt:[[criteres valueForKey:critMin] intValue]];
        NSString *mini = [formatter stringForObjectValue:formattedResult];
        
        text = [text stringByAppendingFormat:@" - A partir de %@ %@%@",mini, unit, sMin];
        
        [formatter release];
    }
    
    if ([criteres valueForKey:critMin] == @"" && [criteres valueForKey:critMax] != @"") {
        
        NSNumber *formattedResult;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setGroupingSeparator:@" "];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        
        formattedResult = [NSNumber numberWithInt:[[criteres valueForKey:critMax] intValue]];
        NSString *maxi = [formatter stringForObjectValue:formattedResult];
        
        text = [text stringByAppendingFormat:@" - Jusqu'à %@ %@%@",maxi, unit, sMax];
        
        [formatter release];
    }
    return text;
}

- (void) viewWillAppear:(BOOL)animated{
    //[tableView1 reloadData];
}

- (void) viewWillDisappear:(BOOL)animated{
    UIView *view;
    
    for (view in [self.view subviews]) {
        if (view == pvc.view) {
            [pvc.view removeFromSuperview];
        }
    }
}



@end
