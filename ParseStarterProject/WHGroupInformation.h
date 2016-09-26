//
//  WHGroupInformation.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 7/29/14.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "FDTakeController.h"
#import "MBProgressHUD.h"

@interface WHGroupInformation : UITableViewController <UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate,FDTakeDelegate,MBProgressHUDDelegate>
{
MBProgressHUD *HUD;
MBProgressHUD *refreshHUD;
}
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (nonatomic, strong) PFObject *group;
@property (weak, nonatomic) IBOutlet UILabel *desciption;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UILabel *groupType;
@property (weak, nonatomic) IBOutlet UIButton *memberButton;

- (IBAction)takephoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *adminlogo;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIButton *badge;
- (IBAction)leaveGroup:(id)sender;
@property FDTakeController *takeController;
@end
