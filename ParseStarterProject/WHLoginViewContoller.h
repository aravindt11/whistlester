//
//  WHLoginViewContoller.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 8/15/14.
//
///

#import <Parse/Parse.h>
#import "FUIButton.h"
#import "FUITextField.h"

@interface WHLoginViewContoller : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet FUITextField *email;
@property (weak, nonatomic) IBOutlet FUITextField *password;
@property (weak, nonatomic) IBOutlet FUIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *forgotPassword;
- (IBAction)passwordReset:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *headerLable;
- (IBAction)login:(id)sender;
- (IBAction)dismiss:(id)sender;






@property (weak, nonatomic) IBOutlet UIImage *backGround;
@property (weak, nonatomic) IBOutlet FUIButton *loginAction;
@end
