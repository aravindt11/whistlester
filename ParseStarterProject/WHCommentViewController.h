//
//  WHCommentViewController.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 6/25/14.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "FeedCell3.h"
#import "WHcommentTableViewCell.h"

@interface WHCommentViewController : PFQueryTableViewController <UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITableView* feedTableView;

@property (nonatomic, strong) NSMutableArray *userInfo;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (weak, nonatomic) IBOutlet UITextField *comment;
@property (nonatomic, strong) NSMutableArray *user;
@property (nonatomic, strong) NSMutableArray *group;
@property (nonatomic, strong) PFObject *postGot;
- (IBAction)deleteComment:(id)sender;


@property   WHcommentTableViewCell *pointerCell;
@property   id pointerCell1;
//@property (nonatomic, strong) NSString* flag;
@property   FeedCell3 *cells;
- (IBAction)like:(id)sender;
- (IBAction)unlike:(id)sender;

@end
