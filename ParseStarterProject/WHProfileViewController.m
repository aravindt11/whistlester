//

//  WHProfileViewController.m

//  whistlester

//

//  Created by Aravind Thiyagarajan on 7/5/14.

//

//



#import "WHProfileViewController.h"

#import <Parse/Parse.h>

#import "UIColor+FlatUI.h"

#import "UIFont+FlatUI.h"





@interface WHProfileViewController ()<FDTakeDelegate>



@end



@implementation WHProfileViewController

@synthesize takeController,images;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil

{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        // Custom initialization
        
    }
    
    return self;
    
}



- (void)viewWillAppear:(BOOL)animated

{
    
    [super viewWillAppear:animated];
    
    
    
    PFUser *curentuser=[PFUser currentUser];
    
    
    
    
    
    
    
    
    
    nickname.text=[[curentuser objectForKey:@"nickname"]capitalizedString];
    
    
    
    PFFile *theImage = [curentuser objectForKey:@"imageFile"];
    
    NSData *imageData = [theImage getData];
    
    self.images = [UIImage imageWithData:imageData];
    
    
    
    // PFFile *file=[object objectForKey:@"imageFile"];
    
    profilepic.image=self.images;
    
    if ([curentuser objectForKey:@"groupcount"]==nil) {
         groupCount.text=@"0";
        
    }
    else
    {
    groupCount.text=[NSString stringWithFormat:@"%@",[curentuser objectForKey:@"groupcount"] ];
    }
    sex.text=[curentuser objectForKey:@"sex"];
    
    // Do any additional setup after loading the view.
    
}



- (void)didReceiveMemoryWarning

{
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    
}



/*
 
 #pragma mark - Navigation
 
 
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 
 {
 
 // Get the new view controller using [segue destinationViewController].
 
 // Pass the selected object to the new view controller.
 
 }
 
 */



- (id)initWithCoder:(NSCoder *)decoder

{
    
    
    
    self = [super initWithCoder:decoder];
    
    
    
    if (self) {
        
        [[UILabel appearanceWhenContainedIn:[WHProfileViewController class], nil]
         
         setTextColor:[UIColor blackColor]];
        
        [[UILabel appearanceWhenContainedIn:[WHProfileViewController class], nil]
         
         setFont:[UIFont flatFontOfSize:15]];
        
        
        
        [[logoutButton titleLabel] setFont:[UIFont fontWithName:@"Lato-Light" size:1]];
        
        
        
        
        
    }
    
    return self;
    
}

- (IBAction)logout:(id)sender {
    
        
    
    [PFUser logOut];
    
    
    
    
}

- (IBAction)privacy:(id)sender {
    
  }

- (IBAction)takePicture:(id)sender

{
    
    
    
    self.takeController=[[FDTakeController alloc] init];
    
    self.takeController.delegate = self;
    
    self.takeController.allowsEditingPhoto=YES;
    
    [self.takeController takePhotoOrChooseFromLibrary];
    
    
    
}



- (void)takeController:(FDTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(NSDictionary *)info

{
    
   
    
    
   [self uploadImage:photo];
    
    
    
}





- (void)uploadImage:(UIImage *)photo

{
    
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [photo drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Upload image
    imageUser=UIImageJPEGRepresentation(smallImage, 0.05f);
    
    
    
   
    
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageUser];
    
    // Save PFFile
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:HUD];
    
    
    
    // Set determinate mode
    
    HUD.mode = MBProgressHUDModeDeterminate;
    
    HUD.delegate = self;
    
    HUD.labelText = @"Uploading";
    
    [HUD show:YES];
    
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (!error) {
            
            //Hide determinate HUD
            
            [HUD hide:YES];
            
            
            
            // Show checkmark
            
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            
            [self.view addSubview:HUD];
            
            
            
            // The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
            
            // Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
            
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
            
            
            
            // Set custom view mode
            
            HUD.mode = MBProgressHUDModeCustomView;
            
            
            
            HUD.delegate = self;
            
            
            
            
            
            
            
            
            
            [[PFUser currentUser]  setObject:imageFile forKey:@"imageFile"];
            
            
            
            
            
            [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (!error) {
                    
                    
                    
                   profilepic.image=smallImage;
                                    }
                
                else{
                    
                    [[[UIAlertView alloc] initWithTitle:@"Network Issue"
                      
                                                message:@"Please try again in few seconds"
                      
                                               delegate:nil
                      
                                      cancelButtonTitle:@"ok"
                      
                                      otherButtonTitles:nil] show];
                    
                    //[self presentViewController:self animated:NO completion:nil];
                    
                    
                    
                     profilepic.image=smallImage;
                    
                    
                }
                
            }];
            
        }
        
        else{
            
            
            
            // Log details of the failure
            
            
            
            [[[UIAlertView alloc] initWithTitle:@"Network Issue"
              
                                        message:@"Please try again in few seconds"
              
                                       delegate:nil
              
                              cancelButtonTitle:@"ok"
              
                              otherButtonTitles:nil] show];
            
            //[self presentViewController:self animated:NO completion:nil];
            
            
            
             profilepic.image=smallImage;
            
            
            
        }
        
    }progressBlock:^(int percentDone) {
        
        // Update your progress spinner here. percentDone will be between 0 and 100.
        
        HUD.progress = (float)percentDone/100;
        
    }];
    
}










@end

