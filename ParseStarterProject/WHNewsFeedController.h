//
//  WHNewsFeedController.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 7/2/14.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "FeedCell3.h"
#import "UIColor+FlatUI.h"
#import "FUISegmentedControl.h"
#import "MBProgressHUD.h"


@interface WHNewsFeedController : PFQueryTableViewController <UITableViewDataSource, UITableViewDelegate,MBProgressHUDDelegate,UIAlertViewDelegate>


@property (nonatomic, weak) IBOutlet UITableView* feedTableView;
@property (weak, nonatomic) IBOutlet FUISegmentedControl *segment;
- (IBAction)flag:(id)sender;
@property (nonatomic, strong) MBProgressHUD *HUD;

@property (nonatomic, strong) NSMutableArray *userInfo;
@property (nonatomic, strong) NSArray *groupInfo;

@property  bool tab;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) NSMutableArray *user;
@property (nonatomic, strong) NSMutableArray *group;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, assign) BOOL showStatusBar;
@property   FeedCell3 *cells;

@property   id pointerCell;

- (IBAction)like:(id)sender;
- (IBAction)unlike:(id)sender;






- (IBAction)delete1:(id)sender;

@end
