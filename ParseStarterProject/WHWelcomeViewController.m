//
//  WHWelcomeViewController.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 9/7/14.
//
//

#import "WHWelcomeViewController.h"
#import "FUIButton.h"
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
#import "UIImage+ResizeAdditions.h"
#import <Accelerate/Accelerate.h>
#import "UIImage+ImageEffects.h"
#import "WHLoginViewContoller.h"
#import "WHSignUpViewController.h"
#import "WHMainTabController.h"
#import "AppDelegate.h"


@interface WHWelcomeViewController ()

@end

@implementation WHWelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.signup.buttonColor=[UIColor darkGrayColor];
    self.signup.shadowColor = [UIColor darkGrayColor];
    self.signup.shadowHeight = 3.0f;
    self.signup.cornerRadius = 6.0f;
    self.signup.titleLabel.font = [UIFont boldFlatFontOfSize:15];
    [self.signup setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.signup setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    self.logoName.font=[UIFont boldFlatFontOfSize:25];
    self.compInfo.font=[UIFont italicFlatFontOfSize:20];
    self.login.buttonColor=[UIColor emerlandColor];
    self.login.shadowColor = [UIColor nephritisColor];
    self.login.shadowHeight = 3.0f;
    self.login.cornerRadius = 6.0f;
    self.login.titleLabel.font = [UIFont boldFlatFontOfSize:15];
    [self.login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.login setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    NSLog(@"%@", NSStringFromCGRect([[UIScreen mainScreen] bounds]));
    
    
    
    if ([PFUser currentUser]  ) {
        if ([[PFUser currentUser] objectForKey:@"nickname"]==nil) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
            UIViewController *myVC = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"nameAndPhoto"];
            
            
             [[[[UIApplication sharedApplication] delegate] window] setRootViewController:myVC];
        }
        else
        {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        
        WHMainTabController *myVC = (WHMainTabController *)[storyboard instantiateViewControllerWithIdentifier:@"nickName"];
            
         [[[[UIApplication sharedApplication] delegate] window] setRootViewController:myVC];
    
            
        
        
        }
        
    }
    
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}






- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"login"]) {
        

        WHLoginViewContoller *myVC = segue.destinationViewController;
    UIGraphicsBeginImageContext(self.view.window.frame.size);
    [self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImage* imageOfUnderlyingView = screenshot;
    imageOfUnderlyingView = [imageOfUnderlyingView applyDarkEffect];
    

    
           myVC.backGround=imageOfUnderlyingView;
    }
    
    if ([segue.identifier isEqualToString:@"signup"]) {
        
        
        WHSignUpViewController *myVC = segue.destinationViewController;
        UIGraphicsBeginImageContext(self.view.window.frame.size);
        [self.view.window.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImage* imageOfUnderlyingView = screenshot;
        imageOfUnderlyingView = [imageOfUnderlyingView applyDarkEffect];
        
        
        
        myVC.backGround=imageOfUnderlyingView;
    }
    
        
        
        
    
}


@end
