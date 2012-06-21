//
//  FormulaireAnnonceMail.m
//  Immosud
//
//  Created by Christophe Bergé on 21/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FormulaireAnnonceMail.h"

@implementation FormulaireAnnonceMail

@synthesize delegate=_delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(formulaireGetAnnonce:) name:@"formulaireGetAnnonce" object: nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"formulaireAnnonceReady" object: @"formulaireAnnonceReady"];
    
    UIColor *fond = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.view.backgroundColor = fond;
    [fond release];
    
    //self.view.backgroundColor = [UIColor whiteColor];
    
    //HEADER
    UIImageView *enTete = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header.png"]];
    [enTete setFrame:CGRectMake(0,0,320,50)];
    [self.view addSubview:enTete];
    [enTete release];
    
    //SCROLL VIEW
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, 320, 480)];
    scrollView.showsVerticalScrollIndicator = YES;
    
    [scrollView setContentSize:CGSizeMake(320, 1200)];
    [scrollView setScrollEnabled:YES];
    [self.view addSubview:scrollView];
    
    [scrollView flashScrollIndicators];
    [scrollView release];
    
    //BOUTON RETOUR
    UIButton *boutonRetour = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonRetour.showsTouchWhenHighlighted = NO;
    boutonRetour.tag = 6;
    
    [boutonRetour setFrame:CGRectMake(10,7,50,30)];
    [boutonRetour addTarget:self action:@selector(done:) 
           forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *image = [UIImage imageNamed:@"bouton-retour.png"];
    [boutonRetour setImage:image forState:UIControlStateNormal];
    
    [self.view addSubview:boutonRetour];
    
    /*--- FORMULAIRE DE CONTACT ---*/
    //NOM
    labelNom = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 100, 30)];
    labelNom.text = @"NOM:";
    [scrollView addSubview:labelNom];
    [labelNom release];
    
    nomTF = [[UITextField alloc] initWithFrame:CGRectMake(30, 30, 250, 30)];
    nomTF.borderStyle = UITextBorderStyleRoundedRect;
    [nomTF becomeFirstResponder];
    [scrollView addSubview:nomTF];
    [nomTF release];
    
    //TELEPHONE
    labelTelephone = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, 150, 30)];
    labelTelephone.text = @"TELEPHONE:";
    [scrollView addSubview:labelTelephone];
    [labelTelephone release];
    
    telephoneTF = [[UITextField alloc] initWithFrame:CGRectMake(30, 90, 250, 30)];
    telephoneTF.borderStyle = UITextBorderStyleRoundedRect;
    telephoneTF.keyboardType = UIKeyboardTypePhonePad;
    [scrollView addSubview:telephoneTF];
    [telephoneTF release];
    
    //EMAIL
    labelEmail = [[UILabel alloc] initWithFrame:CGRectMake(30, 120, 150, 30)];
    labelEmail.text = @"EMAIL:";
    [scrollView addSubview:labelEmail];
    [labelEmail release];
    
    emailTF = [[UITextField alloc] initWithFrame:CGRectMake(30, 150, 250, 30)];
    emailTF.borderStyle = UITextBorderStyleRoundedRect;
    emailTF.keyboardType = UIKeyboardTypeEmailAddress;
    [scrollView addSubview:emailTF];
    [emailTF release];
    
    //QUESTION
    labelQuestion = [[UILabel alloc] initWithFrame:CGRectMake(30, 180, 150, 30)];
    labelQuestion.text = @"QUESTION:";
    [scrollView addSubview:labelQuestion];
    [labelQuestion release];
    
    questionTF = [[UITextField alloc] initWithFrame:CGRectMake(30, 210, 250, 30)];
    questionTF.borderStyle = UITextBorderStyleRoundedRect;
    [scrollView addSubview:questionTF];
    [questionTF release];
    
    //BOUTON ENVOYER
    boutonEnvoyer = [UIButton buttonWithType:UIButtonTypeCustom];
    boutonEnvoyer.showsTouchWhenHighlighted = NO;
    boutonEnvoyer.tag = 1;
    
    [boutonEnvoyer setFrame:CGRectMake(55,270,200,50)];
    [boutonEnvoyer addTarget:self action:@selector(buttonPushed:) 
            forControlEvents:UIControlEventTouchUpInside];
    
    image = [UIImage imageNamed:@"bouton-envoyer.png"];
    [boutonEnvoyer setImage:image forState:UIControlStateNormal];
    
    [scrollView addSubview:boutonEnvoyer];
    
    /*--- FORMULAIRE DE CONTACT ---*/
    
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

- (void)buttonPushed:(id)sender
{
    NSLog(@"ENVOI DE MAIL A IMMOSUD");
    
    NSString *nom = [NSString stringWithString:@"Nom:"];
    if(nomTF.text == nil){
        nomTF.text = @"";
    }
    nom = [nom stringByAppendingFormat:@"\t%@\n",nomTF.text];
    
    NSString *telephone = [NSString stringWithString:@"Telephone:"];
    if(telephoneTF.text == nil){
        telephoneTF.text = @"";
    }
    telephone = [telephone stringByAppendingFormat:@"\t%@\n",telephoneTF.text];
    
    NSString *email = [NSString stringWithString:@"Email:"];
    if(emailTF.text == nil){
        emailTF.text = @"";
    }
    email = [email stringByAppendingFormat:@"\t%@\n",emailTF.text];
    
    NSString *question = [NSString stringWithString:@"Message:"];
    if(questionTF.text == nil){
        questionTF.text = @"";
    }
    question = [question stringByAppendingFormat:@"\t%@\n",questionTF.text];
    
    NSString *htmlBody = [NSString stringWithFormat:@"Bonjour,\nUn internaute souhaite des informations sur un bien :\n\nR&eacute;f.:\t%@\n\n%@\n%@\n%@\n%@\n\nBonne r&eacute;ception.\nCordialement,\n---\nDemande d'informations transmise par Akios.fr", 
                          [lAnnonce valueForKey:@"ref"],
                          nom,
                          telephone,
                          email,
                          question];
    
    //NSLog(@"html: %@", htmlBody);
    
    NSString *escapedBody = [(NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)htmlBody, NULL, CFSTR("?=&+"), kCFStringEncodingISOLatin1) autorelease];
    
    NSLog(@"html: %@", escapedBody);
    
    NSError *error = nil;
    NSString *fullPath;
    NSString *texte;
    
    error = nil;
    
    fullPath = [[NSBundle mainBundle] pathForResource:@"email-agence" ofType:@"txt"];
    texte = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:&error];
    
    NSString *mailtoPrefix = [[NSString stringWithFormat:@"mailto:%@?subject=IMMOSUD-Akios / Demande d'informations sur le bien : \"%@\"&body=", texte, [lAnnonce valueForKey:@"ref"]] stringByAddingPercentEscapesUsingEncoding:NSISOLatin1StringEncoding];
    
    NSString *mailtoStr = [mailtoPrefix stringByAppendingString:escapedBody];
    
    NSLog(@"mail: %@", mailtoStr);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailtoStr]];
}

- (void)done:(id)sender
{
    [self.delegate formulaireAnnonceMailDidFinish:self];
}

- (void)dealloc
{
    [super dealloc];
}

- (void) formulaireGetAnnonce:(NSNotification *)notify {
	lAnnonce = [[Annonce alloc] init];
    lAnnonce = [notify object];
}

@end
