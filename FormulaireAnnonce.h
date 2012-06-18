//
//  FormulaireAnnonce.h
//  Immosud
//
//  Created by Christophe Bergé on 26/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Annonce.h"
#import "Agence.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"
//#import "XMLParserFormulaire.h"

@class XMLParserFormulaire;

@protocol FormulaireAnnonceDelegate;

@interface FormulaireAnnonce : UIViewController{
    Annonce *lAnnonce;
    Agence *lAgence;
    UILabel *labelNom;
    UILabel *labelTelephone;
    UILabel *labelEmail;
    UILabel *labelQuestion;
    UITextField *nomTF;
    UITextField *telephoneTF;
    UITextField *emailTF;
    UITextField *questionTF;
    UIScrollView *scrollView;
    UIButton *boutonEnvoyer;
}

@property (nonatomic, assign) id <FormulaireAnnonceDelegate> delegate;

@end

@protocol FormulaireAnnonceDelegate
- (void)formulaireAnnonceDidFinish:(FormulaireAnnonce *)controller;

@end
