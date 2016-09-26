//
//  FeedController3.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 5/21/14.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "FeedCell3.h"
#import "WHGroupDisplay.h"

@interface WHGroupController : PFQueryTableViewController <UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate>
{
    NSInteger count;
    bool flag;
}
- (IBAction)share:(id)sender;


- (IBAction)back:(id)sender;

@property (nonatomic, weak) IBOutlet UITableView* feedTableView;

@property (nonatomic, weak) NSMutableArray *userInfo;
@property (nonatomic, weak) NSMutableArray *searchResults;
@property (nonatomic, weak) NSMutableArray *user;
@property (nonatomic, strong) NSMutableArray *group;
@property (nonatomic, weak) UIButton *centerButton;
@property   FeedCell3 *cells;
@property (nonatomic, strong) NSMutableString *forthirstString;
- (IBAction)flag:(id)sender;
@property   WHGroupDisplay *cellGroupDisplay;
@property (nonatomic, weak) UIView *loadingView;

@property   id pointerCell;
- (IBAction)like:(id)sender;
- (IBAction)unlike:(id)sender;
- (IBAction)deleteGroupfeed:(id)sender;

- (IBAction)join:(id)sender;



@end