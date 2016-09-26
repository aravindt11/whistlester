//
//  WHPostContoller.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 3/12/14.
//
//

#import "WHPostContoller.h"
#import <Parse/Parse.h>
#import "GTScrollNavigationBar.h"
#import "MZFormSheetController.h"
#import "WHMainTabController.h"
#import "WHNewsFeedController.h"
#import "WHGroupController.h"
@interface WHPostContoller ()

@end

@implementation WHPostContoller
@synthesize group,identifier;

- (IBAction)storePost:(id)sender
{
    
            PFObject *postInfo;
   
    
    
    postInfo = [PFObject objectWithClassName:@"post"];
    
        
    
   postInfo[@"userinfopointer"]= [PFUser currentUser];
   
    PFObject *groupObject= [PFObject objectWithClassName:@"group"];
    [groupObject setObjectId:[[group objectAtIndex:0]objectId]];
    postInfo[@"group"]=groupObject;
    //PFRelation *groupRelation = [postInfo relationforKey:@"group"];
    //[groupRelation addObject:[group objectAtIndex:0]];
    postInfo[@"postcontent"]=self.post.text;
    self.postButton.enabled=false;
    [postInfo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (succeeded) {
            
            if(self.identifier==nil)
            {
                
              
                
                
                 UITabBarController *tabBarControllerMain = (UITabBarController *)[[[UIApplication sharedApplication] delegate] window].rootViewController;
                
                if (tabBarControllerMain.selectedIndex==0) {
                    
                    [tabBarControllerMain.viewControllers[0] popViewControllerAnimated:YES];
                    
                    
                    UINavigationController *navi = tabBarControllerMain.viewControllers[0] ;
                    
                    WHNewsFeedController *feed=(WHNewsFeedController *)navi.topViewController;
                    
                    [feed loadObjects];
                    
                    feed.tableView.contentOffset = CGPointMake(0, 0 - feed.tableView.contentInset.top);
                    
                }
                else
                {
                    
                    [tabBarControllerMain.viewControllers[tabBarControllerMain.selectedIndex] popViewControllerAnimated:YES];
                    
                    UINavigationController *navi = tabBarControllerMain.viewControllers[tabBarControllerMain.selectedIndex] ;
                    
                    WHGroupController *feed=(WHGroupController *)navi.topViewController;
                    
                    
                    
                    [feed loadObjects];
                   
                    feed.tableView.contentOffset = CGPointMake(0, 0 - feed.tableView.contentInset.top);
                    
                    
                    
                    
                    
                    
                    
                    
                    
                }
               
                NSString *groupName=[@"group_" stringByAppendingString:[[group objectAtIndex:0] objectId]];
                PFQuery *pushQuery = [PFInstallation query];
                [pushQuery whereKey:@"user" notEqualTo:[PFUser currentUser]];
                [pushQuery whereKey:@"channels" equalTo:groupName];
                
                
                
                PFPush *push = [[PFPush alloc] init];
                [push setQuery:pushQuery]; // Set our Installation query
                
                //[push setChannel:[@"group_" stringByAppendingString:[[group objectAtIndex:0] objectId
                //                                                    ]]];
                
                NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [[[[PFUser currentUser] objectForKey:@"nickname"] stringByAppendingString:[@" Posted In " stringByAppendingString:[[group objectAtIndex:0] objectForKey:@"name"]]]capitalizedString], @"alert",
                                      @"Increment", @"badge",
                                      [[group objectAtIndex:0] objectId] ,@"post",
                                      nil];
                
                [push setData:data];
                [push sendPushInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    NSLog(@"%@",error.description);
                }];
                
                PFObject *notification=[PFObject objectWithClassName:@"notification"];
                
                notification[@"data"]=[[[PFUser currentUser] objectForKey:@"nickname"] stringByAppendingString:[@" post posted in " stringByAppendingString:[[group objectAtIndex:0] objectForKey:@"name"]]];
                
                
                notification[@"image"]=[[PFUser currentUser] objectForKey:@"imageFile"];
                notification[@"usernew"]=[PFUser currentUser];
                
                notification[@"group"]=groupObject;
                [notification saveInBackground];
                

              
            
            }
            else
            {
               

                
                [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController *formSheetController) {
                    // do sth
                    NSString *groupName=[@"group_" stringByAppendingString:[[group objectAtIndex:0] objectId]];
                    PFQuery *pushQuery = [PFInstallation query];
                    [pushQuery whereKey:@"user" notEqualTo:[PFUser currentUser]];
                    [pushQuery whereKey:@"channels" equalTo:groupName];
                     
                  
                    
                    PFPush *push = [[PFPush alloc] init];
                    [push setQuery:pushQuery];
                    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [[[[PFUser currentUser] objectForKey:@"nickname"] stringByAppendingString:[@" Posted In " stringByAppendingString:[[group objectAtIndex:0] objectForKey:@"name"]]]capitalizedString], @"alert",
                                          @"Increment", @"badge",
                                          [[group objectAtIndex:0] objectId] ,@"post",
                                          nil];
                    
                    [push setData:data];
                    [push sendPushInBackground];
                    
                    PFObject *notification=[PFObject objectWithClassName:@"notification"];
                    
                    notification[@"data"]=[[[PFUser currentUser] objectForKey:@"nickname"] stringByAppendingString:[@" post posted in " stringByAppendingString:[[group objectAtIndex:0] objectForKey:@"name"]]];
                    
                    
                    notification[@"image"]=[[PFUser currentUser] objectForKey:@"imageFile"];
                    notification[@"usernew"]=[PFUser currentUser];
                    
                    notification[@"group"]=groupObject;
                    [notification saveInBackground];
                    
                    UITabBarController *tabBarControllerMain = (UITabBarController *)[[[UIApplication sharedApplication] delegate] window].rootViewController;
                  
                    if (tabBarControllerMain.selectedIndex==0) {
                        
                        [tabBarControllerMain.viewControllers[0] popToRootViewControllerAnimated:NO];

                     
                        UINavigationController *navi = tabBarControllerMain.viewControllers[0] ;
                        
                        WHNewsFeedController *feed=(WHNewsFeedController *)navi.topViewController;
                      
                            [feed loadObjects];
              
                        
                          feed.tableView.contentOffset = CGPointMake(0, 0 - feed.tableView.contentInset.top);
                        
                    }
                    else
                    {
                        
                  [tabBarControllerMain.viewControllers[0] popToRootViewControllerAnimated:NO];
                        tabBarControllerMain.selectedViewController=tabBarControllerMain.viewControllers[0];
                        
                        UINavigationController *navi = tabBarControllerMain.viewControllers[0] ;
                        
                        WHNewsFeedController *feed=(WHNewsFeedController *)navi.topViewController;
                        
                        [ feed.segment setSelectedSegmentIndex:1];

                        [feed loadObjects];
                        
                        feed.tableView.contentOffset = CGPointMake(0, 0 - feed.tableView.contentInset.top);


                        
                       

                        
                        
                        
                    
                    }
                    
                }];
                
              
                
               
                

            }
            
            
                  }
        else{
            [[[UIAlertView alloc] initWithTitle:@"Network Issue"
                                        message:@"Please try again in few seconds"
                                       delegate:nil
                              cancelButtonTitle:@"ok"
                              otherButtonTitles:nil] show];
        }
    }];
    
    
    
}




- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    self.post.contentInset = UIEdgeInsetsMake(0,0,0,0);
     return self;
}

- (void)textViewDidChange:(UITextView *)textView
{
    
   
    
    if ([textView.text  isEqual: @""  ]  ) {
        
        self.post.text=@"Enter your opnion...";
        textView.selectedRange = NSMakeRange(0, 0);
        self.post.textColor=[UIColor lightGrayColor];
        self.postButton.enabled=FALSE;
        count=0;
          self.number.text=[NSString stringWithFormat:@"%u",154 ];
        return;
    }
        if(count==0 )
        {
            self.postButton.enabled=TRUE;
            textView.text = firstLeeter;
        textView.textColor = [UIColor blackColor]; //optional
            count=1;
        }
    
     self.number.text=[NSString stringWithFormat:@"%lu",154-textView.text.length ];
    
    //[textView becomeFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.length==0) {
        firstLeeter=text;
        
    }
            return textView.text.length + (text.length - range.length) <= 154;
  
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
       // textView.text = @"Enter your opnion...";
       // textView.textColor = [UIColor lightGrayColor]; //optional
        
    }
    
    
   
    [textView resignFirstResponder];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
   
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
        WHGroupController *WHGroupFeed = segue.destinationViewController;
        WHGroupFeed.group=self.group;
   
    
    
        
}






-(void)viewDidAppear:(BOOL)animated
{
     [super viewDidAppear:animated];
    
     NSString *title=[[[group objectAtIndex:0] objectForKey:@"name"]capitalizedString];
     self.title=title;
    
   
    
    [self.post becomeFirstResponder];
    self.post.text=@"Enter your opnion...";
    self.post.selectedRange = NSMakeRange(0, 0);
    self.post.textColor=[UIColor lightGrayColor];
    self.postButton.enabled=FALSE;
    
   
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
