//
//  WHProfileViewController.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 7/5/14.
//
//

#import <UIKit/UIKit.h>
#import "FDTakeController.h"
#import "MBProgressHUD.h"

@interface WHProfileViewController :  UIViewController<FDTakeDelegate,MBProgressHUDDelegate, UINavigationControllerDelegate>

{
   
    
    NSData *imageUser;
    
    __weak IBOutlet UILabel *sex;
    __weak IBOutlet UIButton *logoutButton;
    __weak IBOutlet UIImageView *profilepic;
    __weak IBOutlet UILabel *groupCount;
    __weak IBOutlet UILabel *nickname;
    
    MBProgressHUD *HUD;
    MBProgressHUD *refreshHUD;
}
@property UIImage *images;
@property FDTakeController *takeController;
- (IBAction)takePicture:(id)sender;
- (IBAction)logout:(id)sender;
- (IBAction)privacy:(id)sender;


@end
