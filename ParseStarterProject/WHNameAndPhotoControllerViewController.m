//
//  nameAndPhotoControllerViewController.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 2/21/14.
//
//

#import "WHNameAndPhotoControllerViewController.h"
#import "YRDropdownView.h"
#import "AppDelegate.h"

@interface WHNameAndPhotoControllerViewController () <FDTakeDelegate>

@end



@implementation WHNameAndPhotoControllerViewController
@synthesize images,backGround;

int count=0;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.images = [[NSMutableArray alloc] init];
    for (int i=1; i<5; i++) {
       NSString *concat=[NSString stringWithFormat:@"image%d",i];
        UIImage *image = [UIImage imageNamed:[concat stringByAppendingString:@".png"]];
        
       
       
        UIGraphicsBeginImageContext(CGSizeMake(300, 300));
        [image drawInRect: CGRectMake(0, 0, 300, 300)];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // Upload image
        imageUser=UIImageJPEGRepresentation(smallImage, 0.05f);
        

        
        
        [self.images addObject:image];

    }
    
    
    [nickName setDelegate:self];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
   
   
    
}

 -(void)dismissKeyboard {
   [nickName resignFirstResponder];
}

- (IBAction)forward:(id)sender {
   
    count++;
    
    if (count==4) {
        count=0;
    }
        
    
    profilepic.image=[self.images objectAtIndex:count];
    
    
}

- (IBAction)back:(id)sender {
    
    count--;
    if (count==-1) {
        count=3;
    }
    
    profilepic.image=[self.images objectAtIndex:count];
}
- (void)takeController:(FDTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(NSDictionary *)info
{
    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [photo drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Upload image
    imageUser=UIImageJPEGRepresentation(smallImage, 0.05f);
    
    
    
    profilepic.image=smallImage;
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Take picture"])
    {
        
        self.takeController=[[FDTakeController alloc] init];
        self.takeController.delegate = self;
        self.takeController.allowsEditingPhoto=YES;
        [self.takeController takePhotoOrChooseFromLibrary];
        
        
    }
    if([title isEqualToString: @"logout"])
    {
        
        [PFUser logOut];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        UIViewController *mainViewContoller = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"welcomeView"];
        
        [[[[UIApplication sharedApplication] delegate] window] setRootViewController:mainViewContoller];
        

        
        
    }


    
  
}
-(void)takePicture:(id)sender
{
    [[[UIAlertView alloc] initWithTitle:@"Take An Anonymous Picture"
                                message:@"Please don't reveal your identity as other user can view your profile picture."
                               delegate:self
                      cancelButtonTitle:@"Cancel"
                      otherButtonTitles:@"Take picture",nil] show];



    
}


- (IBAction)saveDetail:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sex;
    NSString *sexInfo = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
    
    NSString *trimmedString=[nickName.text stringByReplacingOccurrencesOfString:@" "  withString:@""];

    if ([trimmedString isEqual:@""] ) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Nick name can't be empty"
                                                            message:@"Please enter nick name to create a new user"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
        [alertView show];

        
    }
    else
    {
    [[PFUser currentUser]  setObject:sexInfo forKey:@"sex"];
     [[PFUser currentUser]  setObject:nickName.text forKey:@"nickname"];
    
    

    
       [self uploadImage];
    }
    
    
    
    

}


-(void)verifyNickname:(id)sender
{
    
    NSString *trimmedString=[nickName.text stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    if ([trimmedString isEqual:@""] ) {
        
getStated.enabled=FALSE;
    }
    else
    {
    
    PFQuery *query= [PFUser query];


    [query  findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
           
            // Do something with the found objects
            if(objects.count==0)
            {
                getStated.enabled=TRUE;
            }
            for (PFObject *userObject in objects) {
                
                NSString *playerName = [userObject objectForKey:@"nickname"];
                if ([nickName.text caseInsensitiveCompare:playerName]==NSOrderedSame) {
                    [YRDropdownView showDropdownInView:self.view
                                                 title:@"Warning"
                                                detail:@"Nick Name Already Taken" image:nil animated:YES hideAfter:3.0];
                    getStated.enabled=FALSE;
                    break;
                    
                }
                else
                {
                    
                    getStated.enabled=TRUE;
                  
                }
                
            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    }
    
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return NO;
}

- (void)uploadImage
{
    
    
    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [profilepic.image drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Upload image
    imageUser=UIImageJPEGRepresentation(smallImage, 0.05f);
    

    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageUser];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = @"Uploading";
    [HUD show:YES];
    

    [self.view addSubview:HUD];
    
    // Set determinate mode
       // Save PFFile
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            
            // The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
            // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
          
            
            
              [[PFUser currentUser]  setObject:imageFile forKey:@"imageFile"];
            
            
            [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (!error) {
                    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
                   
                    
                    // Set custom view mode
                    HUD.mode = MBProgressHUDModeCustomView;
                    
                    HUD.delegate = self;
                    
                    [HUD show:YES];
                    
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
                    WHMainTabController *myVC = (WHMainTabController *)[storyboard instantiateViewControllerWithIdentifier:@"nickName"];
                    
                    
                    
                    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                   
                    
                    appDelegate.tabBarController=myVC;
                     [self dismissKeyboard];
                      [HUD hide:YES];
                    
                  [[[[UIApplication sharedApplication] delegate] window] setRootViewController:myVC];
                     [self dismissViewControllerAnimated:YES completion:nil];
                    
                    
                }
                else{
                    [HUD hide:YES];
                    // Log details of the failure
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                }
            }];
        }
        else{
            [HUD hide:YES];
            // Log details of the failure
            
            [[[UIAlertView alloc] initWithTitle:@"Network Issue"
                                        message:@"Please try again in few seconds"
                                       delegate:nil
                              cancelButtonTitle:@"ok"
                              otherButtonTitles:nil] show];
            [self presentViewController:self animated:NO completion:nil];
            
            [userinfo delete];
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    } progressBlock:^(int percentDone) {
        // Update your progress spinner here. percentDone will be between 0 and 100.
        HUD.progress = (float)percentDone/100;
    }];
}







#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
   
    [HUD removeFromSuperview];
	HUD = nil;
}

- (IBAction)logout:(id)sender {
    
    
    
    [[[UIAlertView alloc] initWithTitle:@"This action will log you out"
                                message:@"We need following infomration below to access the application."
                               delegate:self
                      cancelButtonTitle:@"cancel"
                      otherButtonTitles:@"logout",nil] show];
    
}
@end
