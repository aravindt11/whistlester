//
//  CreateNewGroup.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 2/27/14.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <Parse/Parse.h>
#import "YRDropdownView.h"
#import "FDTakeController.h"
#import "FUISwitch.h"


@interface WHCreateNewGroup :UITableViewController <UIImagePickerControllerDelegate, MBProgressHUDDelegate,UITextFieldDelegate,UINavigationControllerDelegate,FDTakeDelegate>
{
    MBProgressHUD *HUD;
    MBProgressHUD *refreshHUD;
    bool  flag;
       __weak IBOutlet UIImageView *groupLogo;
    
}
@property (strong, nonatomic) FDTakeController *takeController;
@property (weak, nonatomic) IBOutlet UILabel *info;
@property (weak, nonatomic) IBOutlet UITextField *groupName;
@property (weak, nonatomic) IBOutlet UITextField *groupDescription;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *createGroup;
@property (weak, nonatomic) IBOutlet UIButton *editLogo;
@property (weak, nonatomic) IBOutlet FUISwitch *flatSwitch;
@property (weak, nonatomic) PFObject  *groupSave;





- (IBAction)takePicture:(id)sender;
-(IBAction)verifyGroupname:(id)sender;
-(IBAction)createGroup:(id)sender;

@end
