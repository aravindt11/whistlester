//
//  WHPopUpController.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 8/24/14.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "WHMainTabController.h"

@interface WHPopUpController : PFQueryTableViewController <UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate>
- (IBAction)closeTab:(id)sender;

@end
