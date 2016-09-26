//
//  WHGroupInformation.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 7/29/14.
//
//

#import "WHGroupInformation.h"
#import "WHGroupDisplay.h"

#import "WHGroupUser.h"
#import "WHGroupContoller.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "NSDate+Helper.h"
#import "WHEditGroupDescriptionViewController.h"

@interface WHGroupInformation ()

@end

@implementation WHGroupInformation
@synthesize group;
- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
         //[self.navigationController setTitle:[group objectForKey:@"name"] ];
        // UINib *nib = [UINib nibWithNibName:@"WHGroupDisplay" bundle:[NSBundle mainBundle]];
        // UINib *nib =[[NSBundle mainBundle] loadNibNamed:@"WHGroupDisplay" owner:self options:nil];
        // Register this NIB which contains the cell
        //[[self tableView] registerNib:nib
        //   forCellReuseIdentifier:@"WHGroupDisplay"];
      
        
    }
    return self;
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [[UIApplication sharedApplication]  setStatusBarHidden:NO];
    
    CGFloat size = 15.0f;
    UIFont *font = [UIFont flatFontOfSize:15];
   
    UIFontDescriptor *des = [[font fontDescriptor] fontDescriptorByAddingAttributes:@{
                                                                                      UIFontDescriptorTextStyleAttribute: UIFontTextStyleBody, // You can tune this style based on usage
                                                                                      UIFontDescriptorSizeAttribute: @(size)
                                                                                      }];
    
    
    UIFont *finalFont = [UIFont fontWithDescriptor:des size:0.0];
    
    [[UILabel appearanceWhenContainedIn:[WHGroupInformation class], nil]
     setTextColor:[UIColor blackColor]];
    [[UILabel appearanceWhenContainedIn:[WHGroupInformation class], nil]
     setFont:finalFont];
    [super viewDidAppear:animated];
    self.title= [[group objectForKey:@"name"]capitalizedString];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
   
   self.tableView.backgroundColor = [UIColor whiteColor];
    
    self.name.text = [[group objectForKey:@"name"]capitalizedString];
    [self.name setFont:finalFont];
    NSString *descriptionTemp=[group  objectForKey:@"groupdescription"] ;
    if ([descriptionTemp isEqualToString:@"" ] || descriptionTemp==nil ) {
        self.desciption.text = @"";
    }
    else
    {
   self.desciption.text = [[group  objectForKey:@"groupdescription"]capitalizedString];
    [self.desciption setFont:finalFont];
    }
//[self.admin setFont:finalFont];
    [self.date setFont:finalFont];
    
         //self.admin.text = [[[group  objectForKey:@"admin"]objectForKey:@"nickname"]capitalizedString];
        PFFile *theImage = [group objectForKey:@"imageFile"];
        NSData *imageData = [theImage getData];
    
    
     self.adminlogo.clipsToBounds = YES;
     self.adminlogo.layer.cornerRadius =  self.adminlogo.frame.size.height/2;;
     self.adminlogo.layer.borderWidth = 1.0f;
    self.adminlogo.layer.borderColor=[[UIColor peterRiverColor]CGColor];
    
    if([[group objectForKey:@"closed"] isEqualToString:@"true"])
    {
        self.groupType.text=@"closed";
    }
    else
    {
        self.groupType.text=@"Open";
    }

    
    //self.adminlogo.layer.borderColor = [[UIColor peterRiverColor]CGColor];
    

        UIImage *image = [UIImage imageWithData:imageData];
    UIGraphicsBeginImageContext(CGSizeMake(112, 100));
    [image drawInRect: CGRectMake(0, 0, 112, 100)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
        self.adminlogo.image=smallImage;
         NSString *date = [NSDate stringForDisplayFromDate:[group createdAt]];
    self.date.text = date;
    
    NSString *memberCount=[NSString stringWithFormat:@"%@",[group objectForKey:@"membercount"]];
    if ([memberCount integerValue]<5  ) {
         [self.badge setTitle:@"<5" forState:UIControlStateNormal];
        self.memberButton.enabled=false;
                    }
    else
    {
       [self.badge setTitle:memberCount forState:UIControlStateNormal];
    }
    
    CGSize stringsize = [memberCount sizeWithAttributes:
                   @{NSFontAttributeName:
                         finalFont}];
   
    if(stringsize.width>60)
    {
    CGRect      buttonFrame = self.badge.frame;
    
    buttonFrame.size = stringsize;
    self.badge.frame = buttonFrame;
    }
    self.badge.clipsToBounds = YES;
    self.badge.layer.cornerRadius = self.badge.frame.size.height/2;

    if([[[group  objectForKey:@"admin"]objectForKey:@"nickname"] compare:[[PFUser currentUser] objectForKey:@"nickname"]]!=NSOrderedSame)
    {
        self.editButton.hidden=TRUE;
    }
    
   
	
	
		
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    UIEdgeInsets inset = UIEdgeInsetsMake(5, 0, 0, 0);
    self.tableView.contentInset = inset;
    
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */


    
    
    





- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"groupuser"]) {
        
                WHGroupUser *WHGroupUser = segue.destinationViewController;
        
        WHGroupUser.group=self.group;
        
        
        
        
    }
    
    if ([segue.identifier isEqualToString:@"groupDescription"]) {
        
        WHEditGroupDescriptionViewController *Description = segue.destinationViewController;
        
        Description.group=self.group;
        
        
        
        
    }

}

- (IBAction)leaveGroup:(id)sender {
    
        PFObject *currentGroup=self.group;
    //PFRelation *users=[[group objectAtIndex:0] objectForKey:@"member"];
    PFRelation *relation = [currentGroup relationForKey:@"member"];
    [relation removeObject:[PFUser currentUser]];
   NSNumber *count = [NSNumber numberWithInt:-1];
    [currentGroup incrementKey:@"membercount" byAmount:count];
    PFRelation *userRelation=[[PFUser currentUser] relationForKey:@"group"];
    [[PFUser currentUser] incrementKey:@"groupcount" byAmount:count];

    [userRelation removeObject:currentGroup];
    NSArray *allObjects=[[NSArray alloc] initWithObjects:currentGroup,[PFUser currentUser], nil];
    
    [PFObject saveAllInBackground:allObjects block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
            WHGroupContoller *myVC = (WHGroupContoller *)[storyboard instantiateViewControllerWithIdentifier:@"WHGroupContoller"];
           
                 [self.navigationController pushViewController:myVC animated:YES];
           
            //PFInstallation *currentInstallation = [PFInstallation currentInstallation];
        NSMutableArray *subscribedChannels = (NSMutableArray*)[PFInstallation currentInstallation].channels;
            
            [subscribedChannels removeObject:[@"group_" stringByAppendingString:[currentGroup objectId]]];
            [PFInstallation currentInstallation].channels=subscribedChannels;
            
            
            [[PFInstallation currentInstallation] saveInBackground];
            
        }
        else
        {
            
            [[[UIAlertView alloc] initWithTitle:@"Network Issue"
                                        message:@"Please try again in few seconds"
                                       delegate:nil
                              cancelButtonTitle:@"ok"
                              otherButtonTitles:nil] show];
            
        }
        
        
    }];

}
- (IBAction)takephoto:(id)sender {
    
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
    NSData *imageUser=UIImageJPEGRepresentation(smallImage, 0.05f);
    
    
    
    
    
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
            
            
            
            
            
            
            
            
            
            [self.group setObject:imageFile forKey:@"imageFile"];
            
            
            
            
            
            [self.group saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
                if (!error) {
                    
                    
                    
                    self.adminlogo.image=smallImage;
                }
                
                else{
                    
                    [[[UIAlertView alloc] initWithTitle:@"Network Issue"
                      
                                                message:@"Please try again in few seconds"
                      
                                               delegate:nil
                      
                                      cancelButtonTitle:@"ok"
                      
                                      otherButtonTitles:nil] show];
                    
                    //[self presentViewController:self animated:NO completion:nil];
                    
                    
                    
                 self.adminlogo.image=smallImage;
                    
                    
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
            
            
            
            self.adminlogo.image=smallImage;
            
            
            
        }
        
    }progressBlock:^(int percentDone) {
        
        // Update your progress spinner here. percentDone will be between 0 and 100.
        
        HUD.progress = (float)percentDone/100;
        
    }];
    
}







@end
