//
//  ContactViewController.m
//  Immosud
//
//  Created by Christophe Bergé on 14/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ContactViewController.h"


@implementation ContactViewController

- (void)geolocViewControllerDidFinish:(GeolocViewController *)controller
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
    
    //COULEUR DE FOND
    UIColor *fond = /*[UIColor whiteColor]*/[[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = fond;
    [fond release];
    //self.view.backgroundColor = [UIColor whiteColor];
    
    //HEADER
    UIImageView *enTete = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
    [enTete setFrame:CGRectMake(0,0,320,50)];
    [self.view addSubview:enTete];
    [enTete release];
    
    //BANDEAU CONTACT
    UIImageView *bandeauContact = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bandeau-contact.png"]];
    [bandeauContact setFrame:CGRectMake(0,50,320,20)];
    [self.view addSubview:bandeauContact];
    [bandeauContact release];
    
    /*--- BOUTON GEOLOC ---*/
    UIButton *boutonGeoloc = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonGeoloc setFrame:CGRectMake(20, 80, 280, 70)];
	[boutonGeoloc setUserInteractionEnabled:YES];
	[boutonGeoloc addTarget:self action:@selector(buttonPushed:) 
           forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image = [UIImage imageNamed:@"geoloc.png"];
	[boutonGeoloc setImage:image forState:UIControlStateNormal];
    
    boutonGeoloc.showsTouchWhenHighlighted = NO;
    boutonGeoloc.tag = 1;
	
	[self.view addSubview:boutonGeoloc];
    /*--- BOUTON GEOLOC ---*/
    
    /*--- BOUTON TELEPHONE ---*/
    UIButton *boutonTelephone = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonTelephone setFrame:CGRectMake(20, 160, 135, 70)];
	[boutonTelephone setUserInteractionEnabled:YES];
	[boutonTelephone addTarget:self action:@selector(buttonPushed:) 
            forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"telephone.png"];
	[boutonTelephone setImage:image forState:UIControlStateNormal];
    
    boutonTelephone.showsTouchWhenHighlighted = NO;
    boutonTelephone.tag = 2;
	
	[self.view addSubview:boutonTelephone];
    /*--- BOUTON TELEPHONE ---*/
    
    /*--- LABEL TELEPHONE ---*/
    UILabel *labelTelephone = [[UILabel alloc] initWithFrame:CGRectMake(45, 205, 135, 30)];
    labelTelephone.font = [UIFont fontWithName:@"Arial-BoldMT" size:12];
    //labelTelephone.textColor = [UIColor whiteColor];
    labelTelephone.backgroundColor = [UIColor clearColor];
    
    NSError *error = nil;
    NSString *fullPath;
    NSString *texte;
    
    fullPath = [[NSBundle mainBundle] pathForResource:@"telephone-agence" ofType:@"txt"];
    texte = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:&error];
    
    labelTelephone.text = texte;
    
    [self.view addSubview:labelTelephone];
    
    [labelTelephone release];
    /*--- LABEL TELEPHONE ---*/
    
    /*--- BOUTON SITE AGENCE ---*/
    UIButton *boutonSiteAgence = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonSiteAgence setFrame:CGRectMake(165, 160, 135, 70)];
	[boutonSiteAgence setUserInteractionEnabled:YES];
	[boutonSiteAgence addTarget:self action:@selector(buttonPushed:) 
         forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"visitez-notre-site.png"];
	[boutonSiteAgence setImage:image forState:UIControlStateNormal];
    
    boutonSiteAgence.showsTouchWhenHighlighted = NO;
    boutonSiteAgence.tag = 6;
	
	[self.view addSubview:boutonSiteAgence];
    /*--- BOUTON SITE AGENCE ---*/
    
    /*--- BOUTON EMAIL ---*/
    UIButton *boutonEmail = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonEmail setFrame:CGRectMake(20, 240, 280, 70)];
	[boutonEmail setUserInteractionEnabled:YES];
	[boutonEmail addTarget:self action:@selector(buttonPushed:) 
              forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"email.png"];
	[boutonEmail setImage:image forState:UIControlStateNormal];
    
    boutonEmail.showsTouchWhenHighlighted = NO;
    boutonEmail.tag = 3;
	
	[self.view addSubview:boutonEmail];
    /*--- BOUTON EMAIL ---*/
    
    /*--- LABEL EMAIL ---*/
    UILabel *labelEmail = [[UILabel alloc] initWithFrame:CGRectMake(95, 260, 200, 30)];
    labelEmail.font = [UIFont fontWithName:@"Arial-BoldMT" size:14];
    //labelEmail.textColor = [UIColor whiteColor];
    labelEmail.backgroundColor = [UIColor clearColor];
    
    error = nil;
    
    fullPath = [[NSBundle mainBundle] pathForResource:@"email-agence" ofType:@"txt"];
    texte = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:&error];
    
    labelEmail.text = texte;
    
    [self.view addSubview:labelEmail];
    
    [labelEmail release];
    /*--- LABEL EMAIL ---*/
    
    /*--- BOUTON EMAIL RECOMMANDATION ---*/
    UIButton *boutonEmailR = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonEmailR setFrame:CGRectMake(20, 320, 135, 70)];
	[boutonEmailR setUserInteractionEnabled:YES];
	[boutonEmailR addTarget:self action:@selector(buttonPushed:) 
          forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"recommander.png"];
	[boutonEmailR setImage:image forState:UIControlStateNormal];
    
    boutonEmailR.showsTouchWhenHighlighted = NO;
    boutonEmailR.tag = 4;
	
	[self.view addSubview:boutonEmailR];
    /*--- BOUTON EMAIL RECOMMANDATION ---*/
    /*--- BOUTON SITE AKIOS ---*/
    UIButton *boutonSite = [UIButton buttonWithType:UIButtonTypeCustom];
	
	[boutonSite setFrame:CGRectMake(165, 320, 135, 70)];
	[boutonSite setUserInteractionEnabled:YES];
	[boutonSite addTarget:self action:@selector(buttonPushed:) 
           forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"site_akios.png"];
	[boutonSite setImage:image forState:UIControlStateNormal];
    
    boutonSite.showsTouchWhenHighlighted = NO;
    boutonSite.tag = 5;
	
	[self.view addSubview:boutonSite];
    /*--- BOUTON SITE AKIOS ---*/
}

- (void) buttonPushed:(id)sender
{
	UIButton *button = sender;
    
	switch (button.tag) {
        NSError *error = nil;
        NSString *fullPath;
        NSString *texte;

		case 1:
            NSLog(@"geoloc.");
            GeolocViewController *geoLoc = [[GeolocViewController alloc] init];
            geoLoc.delegate = self;
            geoLoc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentModalViewController:geoLoc animated:YES];
            [geoLoc release];
			break;
		case 2:
            NSLog(@"tel.");
            
            error = nil;
            
            fullPath = [[NSBundle mainBundle] pathForResource:@"telephone-agence" ofType:@"txt"];
            texte = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:&error];
            
            texte = [texte stringByReplacingOccurrencesOfString:@"." withString:@""];
            texte = [texte substringFromIndex:1];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:
                                                        [NSString stringWithFormat:@"tel://+33%@",texte]]];
            break;
        case 3:
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
        case 4:
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
        case 5:
            NSLog(@"Site Akios");
            NSString *urlAkios = [[NSString stringWithFormat:@"http://www.akios.fr/"] stringByAddingPercentEscapesUsingEncoding:NSISOLatin1StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlAkios]];
            break;
        case 6:
            NSLog(@"Site Agence");
            error = nil;
            
            fullPath = [[NSBundle mainBundle] pathForResource:@"site-agence" ofType:@"txt"];
            texte = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:&error];
            
            NSString *urlAgence = [[NSString stringWithFormat:texte] stringByAddingPercentEscapesUsingEncoding:NSISOLatin1StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlAgence]];
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

@end
