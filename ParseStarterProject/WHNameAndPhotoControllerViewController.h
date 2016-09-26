//
//  nameAndPhotoControllerViewController.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 2/21/14.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <Parse/Parse.h>
#import "FDTakeController.h"

@interface WHNameAndPhotoControllerViewController : UIViewController<FDTakeDelegate, MBProgressHUDDelegate,UITextFieldDelegate,UINavigationControllerDelegate>

{
PFObject *userinfo;
    
NSData *imageUser;
    __weak IBOutlet UITextField *nickName;
    __weak IBOutlet UIImageView *profilepic;
    __weak IBOutlet UIButton *getStated;
    __weak IBOutlet UISegmentedControl *sex;
  
    MBProgressHUD *HUD;
    MBProgressHUD *refreshHUD;
    
    
}
@property  (strong, nonatomic) FDTakeController *takeController;
- (IBAction)logout:(id)sender;

@property  (strong, nonatomic) NSMutableArray *images;
@property  (strong, nonatomic) UIImage *backGround;

- (IBAction)forward:(id)sender;
- (IBAction)back:(id)sender;


- (IBAction)takePicture:(id)sender;
- (IBAction)verifyNickname:(id)sender;
- (IBAction)saveDetail:(id)sender;
@end
