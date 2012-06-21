//
//  FormulaireAnnonceMail.h
//  Immosud
//
//  Created by Christophe Bergé on 21/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Annonce.h"

@protocol FormulaireAnnonceMailDelegate;

@interface FormulaireAnnonceMail : UIViewController{
    Annonce *lAnnonce;
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

@property (nonatomic, assign) id <FormulaireAnnonceMailDelegate> delegate;

@end

@protocol FormulaireAnnonceMailDelegate
- (void)formulaireAnnonceMailDidFinish:(FormulaireAnnonceMail *)controller;

@end

