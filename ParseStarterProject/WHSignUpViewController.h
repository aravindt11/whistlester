//
//  SignUpViewController.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 9/9/14.
//
//

#import <UIKit/UIKit.h>
#import "FUIButton.h"
#import "FUITextField.h"
#import <Parse/Parse.h>


@interface WHSignUpViewController : UIViewController
@property (weak, nonatomic) IBOutlet FUITextField *email;
@property (weak, nonatomic) IBOutlet FUITextField *password;
@property (weak, nonatomic) IBOutlet FUIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIImage *backGround;

@property (weak, nonatomic) IBOutlet UILabel *headerLable;
- (IBAction)login:(id)sender;
- (IBAction)dismiss:(id)sender;


@end
