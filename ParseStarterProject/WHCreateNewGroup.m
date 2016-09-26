//
//  CreateNewGroup.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 2/27/14.
//
//

#import "WHCreateNewGroup.h"
#import "UIColor+FlatUI.h"
#import "WHGroupController.h"

#import "UIFont+FlatUI.h"


@interface WHCreateNewGroup ()

@end

@implementation WHCreateNewGroup
@synthesize groupSave;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    [[UILabel appearanceWhenContainedIn:[WHCreateNewGroup class], nil]
     
     setFont:[UIFont flatFontOfSize:14]];

    
    [self.groupName setDelegate:self];
    
    [self.groupDescription setDelegate:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    self.createGroup.enabled=false;
    self.flatSwitch.onColor = [UIColor turquoiseColor];
    self.flatSwitch.offColor = [UIColor cloudsColor];
    self.flatSwitch.onBackgroundColor = [UIColor midnightBlueColor];
    self.flatSwitch.offBackgroundColor = [UIColor silverColor];
    self.flatSwitch.on=false;
    [ self.flatSwitch addTarget:self action:@selector(switchToggled:) forControlEvents: UIControlEventValueChanged];
    self.flatSwitch.offLabel.font = [UIFont boldFlatFontOfSize:14];
    self.flatSwitch.onLabel.font = [UIFont boldFlatFontOfSize:14];
    self.info.font=[UIFont italicFlatFontOfSize:10];

}
- (void) switchToggled:(id)sender {
    UISwitch *mySwitch = (UISwitch *)sender;
    if ([mySwitch isOn]) {
       self.info.text=@"Member need personal invite to join the group";
    } else {
        self.info.text=@"Anyone Can join the Group";
    } 
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.groupName resignFirstResponder];
    [self.groupDescription resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]  setStatusBarHidden:NO];
   // self.groupDescription.text=@"";
    // self.groupName.text=@"";
    
}

-(void)createGroup:(id)sender


{
   
    
    PFObject *groupInfo;
    
    NSString *trimmedString=[self.groupName.text stringByReplacingOccurrencesOfString:@" "  withString:@""];
    
    if ([trimmedString isEqual:@""] ) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Group name can't be empty"
                                                            message:@"Please enter Group name to create a new user"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        
        [alertView show];
        
        
    }
    else
    {
    
    groupInfo = [PFObject objectWithClassName:@"group"];
    groupInfo[@"name"] = [self.groupName.text capitalizedString];
    if(self.flatSwitch.isOn)
    {
        groupInfo[@"closed"]=@"true";
    }
    else
    {
        
        groupInfo[@"closed"]=@"false";
    }
    
    groupInfo[@"groupdescription"] = [self.groupDescription.text capitalizedString] ;
    groupInfo[@"admin"]=[PFUser currentUser];
    [groupInfo incrementKey:@"membercount"];
    
    PFUser *user = [PFUser currentUser];
    
    PFRelation *relation = [groupInfo relationForKey:@"member"];
    [relation addObject:user];
    
    
    
    
    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [groupLogo.image drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Upload image
    NSData *imageGroup=UIImageJPEGRepresentation(smallImage, 0.05f);
    
    
    
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageGroup];
    {
        
        [self.view addSubview:HUD];
        
        
        
        
      
        [imageFile save];
        
        
        groupInfo[@"imageFile"]=imageFile;
        
        [groupInfo save];
        
        
        
        PFInstallation *installation = [PFInstallation currentInstallation];
        
        [installation addUniqueObject:[@"group_" stringByAppendingString:[groupInfo objectId] ]forKey:@"channels"];
        [installation saveInBackground];
        
        PFRelation *userRelation=[[PFUser currentUser] relationForKey:@"group"];
        [userRelation addObject:groupInfo];
        [[PFUser currentUser] incrementKey:@"groupcount"];
        [ [PFUser currentUser] saveInBackground];
        
        NSUInteger selectedTabIndex= self.tabBarController.selectedIndex;
        [self.tabBarController.viewControllers[1] popToRootViewControllerAnimated:NO];
        

             self.tabBarController.selectedViewController= self.tabBarController.viewControllers[1];
        
        
        [self.tabBarController.viewControllers[selectedTabIndex] popToRootViewControllerAnimated:NO];
        
        
    }
    }
    
    
}


-(void)verifyGroupname:(id)sender
{
    flag=TRUE;
    self.createGroup.enabled=false;
    NSString *trimmedString=[self.groupName.text stringByReplacingOccurrencesOfString:@" "  withString:@""];
   
    if ([trimmedString isEqual:@""]) {
        self.createGroup.enabled=false;
    }
         else
         {
 NSString *groupName= [self.groupName.text capitalizedString];
    PFQuery *query = [PFQuery queryWithClassName:@"group"];
    [query whereKey:@"name" equalTo:groupName];
    
    [query  findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
           
            // Do something with the found objects
            if(objects.count==0)
            {
                 self.createGroup.enabled=TRUE;
            }
            else
            {
                
                [YRDropdownView showDropdownInView:self.view.window
                                             title:@"Warning"
                                            detail:@"Group Name Already Taken" image:nil animated:YES hideAfter:2.0];
                

                self.createGroup.enabled=false;
            }
        }
        else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
         }
    
    
}

-(void)takePicture:(id)sender
{
    self.takeController=[[FDTakeController alloc] init];
    
    self.takeController.delegate = self;
    
    self.takeController.allowsEditingPhoto=YES;
    
    [self.takeController takePhotoOrChooseFromLibrary];
    
    
}




- (void)takeController:(FDTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(NSDictionary *)info
{
    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [photo drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    groupLogo.image=smallImage;
}


-(void)dismissKeyboard {
    
    [self.groupName resignFirstResponder];
        [self.groupDescription resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    
    self.tabBarController.selectedViewController=self.tabBarController.viewControllers[1];
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PFObject *groupInfo;
    
    
    
    groupInfo = [PFObject objectWithClassName:@"group"];
    groupInfo[@"name"] = [self.groupName.text capitalizedString];
    if(self.flatSwitch.isOn)
    {
        groupInfo[@"closed"]=@"true";
    }
    else
    {
        
        groupInfo[@"closed"]=@"false";
    }
    
    groupInfo[@"groupdescription"] = self.groupDescription.text ;
    groupInfo[@"admin"]=[PFUser currentUser];
    [groupInfo incrementKey:@"membercount"];
    
    PFUser *user = [PFUser currentUser];
    
    PFRelation *relation = [groupInfo relationForKey:@"member"];
    [relation addObject:user];
    

    
    
    
    
    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [groupLogo.image drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Upload image
    NSData *imageGroup=UIImageJPEGRepresentation(smallImage, 0.05f);
    
    
    
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageGroup];
    {
    
    [self.view addSubview:HUD];
    
  
   
    
    
    [imageFile save];
    
    
    groupInfo[@"imageFile"]=imageFile;
    
    [groupInfo save];
   

           
    WHGroupController *WHGroupFeed = segue.destinationViewController;
        
        
    NSMutableArray *groupSearch = [NSMutableArray array];
    [groupSearch addObject:groupInfo];
    WHGroupFeed.group=groupSearch;
        
           WHGroupFeed.navigationController.navigationItem.leftBarButtonItem.title=@"group123";

        
        [WHGroupFeed.navigationItem.leftBarButtonItem setAction:@selector(back:)];
        [WHGroupFeed.navigationItem.leftBarButtonItem setTarget:WHGroupFeed];
    
    PFInstallation *installation = [PFInstallation currentInstallation];
    //installation[@"user"] = [PFUser currentUser];
    [installation addUniqueObject:[@"group_" stringByAppendingString:[groupInfo objectId] ]forKey:@"channels"];
    [installation saveInBackground];
    
    PFRelation *userRelation=[[PFUser currentUser] relationForKey:@"group"];
    [userRelation addObject:groupInfo];
    [[PFUser currentUser] incrementKey:@"groupcount"];
    [ [PFUser currentUser] saveInBackground];

    }
}
    

    

    
    
    
    



@end
