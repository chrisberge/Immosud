//
//  ChoixVilleController3.h
//  Immosud
//
//  Created by Christophe Bergé on 04/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ImmosudAppDelegate.h"

@interface ChoixVilleController3 : UIViewController <NSFetchedResultsControllerDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>{
    UITableView *myTableView;
    NSMutableArray *selection;
    NSArray *villes;
    NSFetchedResultsController *resultsController;
    UISearchBar *searchBar;
	BOOL searching;
	BOOL letUserSelectRow;
    NSString *postString;
    
}

@property (nonatomic,retain) NSMutableArray *selection;
@property (nonatomic,retain) NSFetchedResultsController *resultsController;
@property (nonatomic,assign) BOOL searching;
@property (nonatomic,assign) BOOL letUserSelectRow;

- (void) searchTableView:(NSString *)theText;
- (void) doneSearching_Clicked:(id)sender;

@end
