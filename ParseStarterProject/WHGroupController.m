//
//  FeedController3.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 5/21/14.
//
//

#import "WHGroupController.h"
#import "FeedCell3.h"
#import "WHGroupDisplay.h"
#import "WHCommentViewController.h"
#import "WHPostContoller.h"
#import "GTScrollNavigationBar.h"
#import "WHGroupInformation.h"
#import "WHService.h"
#import "UIImage+ResizeAdditions.h"
#import "UIColor+FlatUI.h"
#import "UIImage+Text.h"
#import "UIFont+FlatUI.h"
#import "UIImage+Text.h"
#import "AppDelegate.h"
#import "WHMainTabController.h"
#import "UIImage+ImageEffects.h"
#import "JBWhatsAppActivity.h"
#import "AppDelegate.h"


@interface WHGroupController ()



@end

@implementation WHGroupController
@synthesize group,searchResults,userInfo,cells,pointerCell,cellGroupDisplay,forthirstString;

- (id)initWithCoder:(NSCoder *)decoder
{
    
    self = [super initWithCoder:decoder];
    if (self) {
        
        self.parseClassName = @"post";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 25;
        
        
        
       
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    self.navigationController.scrollNavigationBar.scrollView = nil;
    
    WHMainTabController *mainTab=(WHMainTabController *)self.tabBarController;
    
    
    NSMutableAttributedString *attString =    [[NSMutableAttributedString alloc]
                                               initWithString: @"Post"];
    [attString addAttribute: NSFontAttributeName
                      value:  [UIFont flatFontOfSize:15.0f]
                      range: NSMakeRange(0,attString.length)];
    
    [attString addAttribute: NSForegroundColorAttributeName
                      value:  [UIColor whiteColor]
                      range: NSMakeRange(0,attString.length)];
  
    
    [mainTab.centerButton  setAttributedTitle:attString forState:UIControlStateNormal];
    
    [mainTab.centerButton removeTarget:nil
                                action:NULL
                      forControlEvents:UIControlEventAllEvents];
    
 
    [mainTab.centerButton removeTarget:nil
                                action:NULL
                      forControlEvents:UIControlEventAllEvents];
    
    [mainTab.centerButton addTarget:mainTab action:@selector(post1:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Cancel"])
    {
        [self.navigationController popViewControllerAnimated:YES];
        

        
    }
    if ([title isEqualToString:@"Flag"]) {
        CGPoint buttonPosition = [self.pointerCell convertPoint:CGPointZero toView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
        
        
        
        
        PFObject *post =  [self.objects objectAtIndex:indexPath.row];
        NSArray *ban=[post objectForKey:@"ban" ];
        NSMutableArray *allMyObjectsBan = [NSMutableArray arrayWithArray: ban];
        [allMyObjectsBan addObject:[[PFUser currentUser]objectId]];
        [post  setObject:allMyObjectsBan forKey:@"ban"];
        [post incrementKey:@"bancount"];
        [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded)
            {
                [self loadObjects] ;
                self.tableView.contentOffset = CGPointMake(0, 0 - self.tableView.contentInset.top);
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
    
    
    
    if([title isEqualToString:@"Join"])
    {
        
        PFQuery *query=[PFQuery queryWithClassName:@"password"];
        [query whereKey:@"group" equalTo:[[group objectAtIndex:0]objectId]];
        NSDate *currentDate = [NSDate date];
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        [dateComponents setDay:-1];
        NSDate *yesterday = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:currentDate options:0];
         [query whereKey:@"updatedAt" greaterThan:yesterday];
            [query whereKey:@"key" equalTo:[alertView textFieldAtIndex:0].text];

       
         flag=false;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            if (objects.count>0) {
                
        
                    
                    [self join:[alertView buttonTitleAtIndex:buttonIndex]];
                self.tableView.alpha=1;
                }
                
            else
            {
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Password Wrong"
                                                                    message:@"Please recheck and enter correct password to join the group"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Join"
                                                          otherButtonTitles:@"Cancel", nil];
                alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
                
                UITextField* textfield = [alertView textFieldAtIndex:0];
                textfield.placeholder = @"Password";
                
                [alertView show];
                
            }
            
        }
    }];
       
        
        
    }
    if([title isEqualToString:@"Delete"])
    {
        
        
            
            CGPoint buttonPosition = [self.pointerCell convertPoint:CGPointZero toView:self.tableView];
            NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
            
            //NSLog(@"%ld", (long)indexPath.row);
            
            
            PFObject *post =  [self.objects objectAtIndex:indexPath.row];
            PFQuery *query = [PFQuery queryWithClassName:@"comment"];
            [query whereKey:@"post" equalTo:post.objectId];
            [ query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if(!error)
                {
                    for (PFObject *object in objects) {
                        [object deleteEventually];
                    }
                }
                
            }];
            
            [post delete];
            [self loadObjects] ;
            self.tableView.contentOffset = CGPointMake(0, 0 - self.tableView.contentInset.top);
            
        
        
        
        
    }
    
}




-(IBAction)postFromGroup:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    WHPostContoller *myVC = (WHPostContoller *)[storyboard instantiateViewControllerWithIdentifier:@"postContoller"];
    
    myVC.group=group;
    
    [self.navigationController pushViewController:myVC animated:YES];
   
    
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
  
    [self.navigationController.scrollNavigationBar resetToDefaultPosition:YES];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
	
   
  
    
   
    
    self.title = @"Group Feed";
    
    
    self.feedTableView.dataSource = self;
    self.feedTableView.delegate = self;
    
    self.feedTableView.backgroundColor = [UIColor whiteColor];
    self.feedTableView.separatorColor = [UIColor colorWithWhite:0.9 alpha:0.6];
    
   
   
    
    
            
   
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (self.objects.count>0) {
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.backgroundView =nil;
        return 1;
        
    }
    else {
        
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"Create first post on this group.";;
        messageLabel.textColor = [UIColor darkGrayColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont flatFontOfSize:15];
        [messageLabel sizeToFit];
        
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return 1;
    }
    
    
}




- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.
    if ([self.objects count] == 0) {
        // query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
   
    [query whereKey:@"group" equalTo:[group objectAtIndex:0]];
    [query includeKey:@"userinfopointer"];
    [query includeKey:@"group"];
    [query whereKey:@"ban" notEqualTo:[[PFUser currentUser]objectId]];
    [query orderByAscending:@"bancount"];
    [query addDescendingOrder:@"updatedAt"];
   
    
    return query;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"comment"])
    {
        
      
        

        WHCommentViewController *CommentViewController =
        [segue destinationViewController];
        
        NSIndexPath *myIndexPath = [self.tableView
                                    indexPathForSelectedRow];
        
        long row = [myIndexPath row];
        
         PFObject *passObj = [self.objects objectAtIndex:row];
        
        CommentViewController.postGot =passObj;
        // [self.navigationController setNavigationBarHidden:NO];
       // static NSString *CellIdentifier = @"FeedCell3";
        
    }
    
    if ([segue.identifier isEqualToString:@"fromGroupFeed"]) {
        
        WHPostContoller *WHPostContoller = segue.destinationViewController;
        
        WHPostContoller.group=group;
     
        
        
        
    }
}


-(PFTableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath

{
    
    PFTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"LoadMore"];
    
    
    return cell;

}





-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
    if(scrollView.contentSize.height - scrollView.contentOffset.y < (self.view.bounds.size.height)) {
    if(![self isLoading] && self.objects.count >= self.objectsPerPage-1)
    {
        [self loadNextPage];
    }
} }

-(UITableViewCell *)tableView:(UITableView *)tableView
cellForRowAtIndexPath:(NSIndexPath *)indexPath
object:(PFObject *)object {
    static NSString *CellIdentifier = @"FeedCell3";
    
    
    FeedCell3 *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
           if (cell == nil) {
      cell=[[FeedCell3 alloc] init];
    }
    
    WHService *service=[[WHService alloc]init];
    
    return [service setData:cell forObject:object for:@"groupfeed"];
    
    
    
    
    
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)like:(id)sender {
    
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    
    FeedCell3 *cell = (FeedCell3*)[self.tableView cellForRowAtIndexPath:indexPath ];
    PFObject *post =  [self.objects objectAtIndex:indexPath.row];
    
    WHService   *service=[[WHService alloc]init];
    [service likeService:cell forObject:post in:self.tableView for:@"groupfeed"];
    
    
    
    
    
    
}

- (IBAction)unlike:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    FeedCell3 *cell = (FeedCell3*)[self.tableView cellForRowAtIndexPath:indexPath ];
    
    PFObject *post =  [self.objects objectAtIndex:indexPath.row];
    
    WHService   *service=[[WHService alloc]init];
    [service DislikeService:cell forObject:post in:self.tableView for:@"groupfeed"];
    
    
    
}

- (IBAction)back:(id)sender {
    
    self.tabBarController.selectedViewController=self.tabBarController.viewControllers[1];
    

    
    [self.navigationController popToRootViewControllerAnimated:NO];
    
       
}



- (IBAction)deleteGroupfeed:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Are you sure you want to delete this.  This action cannot be undone" delegate:self cancelButtonTitle:@"Delete" otherButtonTitles:@"No", nil];
    [alert show];
    self.pointerCell=sender;
    
    
    
}







- (IBAction)join:(id)sender {
    
    PFObject *currentGroup=[group objectAtIndex:0];
    //PFRelation *users=[[group objectAtIndex:0] objectForKey:@"member"];
    PFRelation *relation = [currentGroup relationForKey:@"member"];
    [relation addObject:[PFUser currentUser]];
    [currentGroup incrementKey:@"membercount"];
    PFRelation *userRelation=[[PFUser currentUser] relationForKey:@"group"];
     [[PFUser currentUser] incrementKey:@"groupcount"];
    [userRelation addObject:currentGroup];
    NSArray *allObjects=[[NSArray alloc] initWithObjects:currentGroup,[PFUser currentUser], nil];
   
    [PFObject saveAllInBackground:allObjects block:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            
            
            WHMainTabController *mainTab=(WHMainTabController *)self.tabBarController;
            
                
                NSMutableAttributedString *attString =    [[NSMutableAttributedString alloc]
                                                           initWithString: @"Post"];
                [attString addAttribute: NSFontAttributeName
                                  value:  [UIFont flatFontOfSize:15.0f]
                                  range: NSMakeRange(0,attString.length)];
                
                [attString addAttribute: NSForegroundColorAttributeName
                                  value:  [UIColor whiteColor]
                                  range: NSMakeRange(0,attString.length)];
                
                
                [mainTab.centerButton  setAttributedTitle:attString forState:UIControlStateNormal];
                [mainTab.centerButton removeTarget:nil
                                            action:NULL
                                  forControlEvents:UIControlEventAllEvents];
                
                [mainTab.centerButton addTarget:self action:@selector(postFromGroup:) forControlEvents:UIControlEventTouchUpInside];
                
                
                
            NSString *countString = [NSString stringWithFormat:@"%@",
                                     [[group objectAtIndex:0]
                                      objectForKey:@"membercount"]];
            cellGroupDisplay.members.text = [NSString stringWithFormat:@"Members %d",[countString intValue]];
            PFInstallation *currentInstallation = [PFInstallation currentInstallation];
            [currentInstallation addUniqueObject:[@"group_" stringByAppendingString:[currentGroup objectId]] forKey:@"channels"];
            [currentInstallation saveInBackground];
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


- (BOOL)allowsHeaderViewsToFloat{
    return NO;
}




-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 162.0;
}
-(void)tap {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    
     WHGroupInformation *contoller =(WHGroupInformation*) [storyboard instantiateViewControllerWithIdentifier:@"groupinfo"];
    contoller.group= [group objectAtIndex:0];
    
    [self.navigationController pushViewController:contoller animated:YES];
   
    
    
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
   
    static NSString *CellIdentifier = @"WHGroupDisplay";
    WHGroupDisplay *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        [NSException raise:@"headerView == nil.." format:@"No cells with matching CellIdentifier loaded from your storyboard"];
    }
   
    cell.groupName.text =[[[group objectAtIndex:0]
                          objectForKey:@"name"]capitalizedString];
    
    
    
    cell.members.text = [NSString stringWithFormat:@"Members %@",
                              [[group objectAtIndex:0]
                               objectForKey:@"membercount"]];
        
    PFFile *theImage = [[group objectAtIndex:0]
                        objectForKey:@"imageFile"];;
    
    NSData *imageData = [theImage getData];
    UIImage *images = [UIImage imageWithData:imageData];
    
    
   
    
    cell.groupLogo.image=images;
    
   
    
    
    self.cellGroupDisplay=cell;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(tap)];
    
    [cell  addGestureRecognizer:tap];
   

    
    
    return cell;
}


     
-(void)viewDidAppear:(BOOL)animated
{
     [super viewDidAppear:animated];
        [self.tableView reloadData];
   
     [[UIApplication sharedApplication]  setStatusBarHidden:NO];
     [[UIApplication sharedApplication]   setStatusBarStyle:UIStatusBarStyleLightContent];
       self.navigationController.scrollNavigationBar.scrollView = self.tableView;
    WHMainTabController *mainTab=(WHMainTabController *)self.tabBarController;
    
    [[UIApplication sharedApplication]  setStatusBarHidden:NO];

    
    PFRelation *users=[[group objectAtIndex:0] objectForKey:@"member"];
    PFQuery *query = [users query];
    [query whereKey:@"objectId" equalTo:[[PFUser currentUser] objectId]];
    self->count = [query countObjects];

    
    
    NSString *closed=[[self.group objectAtIndex:0]objectForKey:@"closed"];
    if ([closed caseInsensitiveCompare:@"true" ]==NSOrderedSame && closed!=nil && count==0) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Password"
                                                            message:@"Enter password to join the group"
                                                           delegate:self
                                                  cancelButtonTitle:@"Join"
                                                  otherButtonTitles:@"Cancel", nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        
        UITextField* textfield = [alertView textFieldAtIndex:0];
        textfield.placeholder = @"Password";
        
        self.tableView.alpha=0.2;
        
        [alertView show];
    }
    if (count == 0) {
        
        NSMutableAttributedString *attString =    [[NSMutableAttributedString alloc]
                                                   initWithString: @"Join"];
        [attString addAttribute: NSFontAttributeName
                          value:  [UIFont flatFontOfSize:15.0f]
                          range: NSMakeRange(0,attString.length)];
        
        [attString addAttribute: NSForegroundColorAttributeName
                          value:  [UIColor whiteColor]
                          range: NSMakeRange(0,attString.length)];
        
        [mainTab.centerButton  setAttributedTitle:attString forState:UIControlStateNormal];
        
        
              [mainTab.centerButton removeTarget:nil
                                    action:NULL
                          forControlEvents:UIControlEventAllEvents];
        
        [mainTab.centerButton addTarget:self action:@selector(join:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
           } else {
        NSMutableAttributedString *attString =    [[NSMutableAttributedString alloc]
                                                   initWithString: @"Post"];
        [attString addAttribute: NSFontAttributeName
                          value:  [UIFont flatFontOfSize:15.0f]
                          range: NSMakeRange(0,attString.length)];
        
        [attString addAttribute: NSForegroundColorAttributeName
                          value:  [UIColor whiteColor]
                          range: NSMakeRange(0,attString.length)];
        
        [mainTab.centerButton  setAttributedTitle:attString forState:UIControlStateNormal];
        [mainTab.centerButton removeTarget:nil
                                    action:NULL
                          forControlEvents:UIControlEventAllEvents];
        
        [mainTab.centerButton addTarget:self action:@selector(postFromGroup:) forControlEvents:UIControlEventTouchUpInside];

        
    }
    


    
   
    
   
    
}

- (IBAction)share:(id)sender {
    
    
    
    NSString *closed=[[self.group objectAtIndex:0]objectForKey:@"closed"];
    if([closed isEqualToString:@"true"] && closed!=nil)
    {
      NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
    self.forthirstString = [NSMutableString stringWithCapacity:6];
    for (NSUInteger i = 0U; i < 6; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [self.forthirstString appendFormat:@"%C", c];
        }

    
    flag=false;
    
    
    NSString *firstString=@"Join anonymous group ";
    
    NSString *secondirstString=[[[group objectAtIndex:0]
                                 objectForKey:@"name"]capitalizedString];
    
    NSString *thirdirstString=@". Please use the password ";
    
    
    
    NSString *fifthString=@" to join. The password expires in 24 hrs.";
    
   
    
    PFFile *theImage = [[group objectAtIndex:0]
                        objectForKey:@"imageFile"];;

    
    NSData *imageData = [theImage getData];
    UIImage *images = [UIImage imageWithData:imageData];
    UIGraphicsBeginImageContext(CGSizeMake(200 , 200));
    [images drawInRect: CGRectMake(0, 0, 200, 200)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSURL *url = [NSURL URLWithString:@"http://whistle-ster.com/download.html"];
    NSString *whatsAppString=[NSString stringWithFormat:@"%@%@%@%@%@%@", firstString, secondirstString, thirdirstString,self.forthirstString,fifthString,url];
       // Resize image
       
    
    
   
                PFObject *password=[PFObject objectWithClassName:@"password"];
                
                password[@"group"]=[[group objectAtIndex:0]objectId];
                
                
                password[@"key"]=self.forthirstString;
                [password saveInBackground];
                
                NSString *finialString=[NSString stringWithFormat:@"%@%@%@%@%@", firstString, secondirstString, thirdirstString,self.forthirstString,fifthString];
                WhatsAppMessage *whatsappMsg = [[WhatsAppMessage alloc] initWithMessage:whatsAppString forABID:nil];
                NSArray *applicationActivities = @[[[JBWhatsAppActivity alloc] init]];
                NSMutableArray *sharingItems = [NSMutableArray new];
                
                
                [sharingItems addObject:finialString];
                [sharingItems addObject:smallImage];
                [sharingItems addObject:whatsappMsg];
                [sharingItems addObject:url];
        
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:applicationActivities];
        
        activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint,UIActivityTypeAddToReadingList,UIActivityTypeCopyToPasteboard,UIActivityTypeSaveToCameraRoll];

        if ([activityVC respondsToSelector:@selector(popoverPresentationController)])
        {
            // iOS 8+
            UIPopoverPresentationController *presentationController = [activityVC popoverPresentationController];
            
            presentationController.sourceView = self.view;
        }
       
            
                              [self presentViewController:activityVC animated:YES completion:nil];

        
        
    
        

    
    }
    else
    {
        NSString *firstString1=@"Join anonymous group ";
        
        NSString *secondirstString1=[[[group objectAtIndex:0]
                                     objectForKey:@"name"]capitalizedString];
        NSString *thirdString1=@" on Whistlester";
        
        
        PFFile *theImage1 = [[group objectAtIndex:0]
                            objectForKey:@"imageFile"];
        
        NSURL *url = [NSURL URLWithString:@"http://whistle-ster.com/download.html"];
        
        NSString *whatsAppString1=[NSString stringWithFormat:@"%@%@%@%@", firstString1, secondirstString1, thirdString1,url];
        NSString *finialString=[NSString stringWithFormat:@"%@%@%@", firstString1, secondirstString1, thirdString1];
        WhatsAppMessage *whatsappMsg = [[WhatsAppMessage alloc] initWithMessage:whatsAppString1 forABID:nil];
        NSArray *applicationActivities = @[[[JBWhatsAppActivity alloc] init]];
        
        NSMutableArray *sharingItems = [NSMutableArray new];
        NSData *imageData = [theImage1 getData];
        UIImage *images = [UIImage imageWithData:imageData];
        UIGraphicsBeginImageContext(CGSizeMake(200 , 200));
        [images drawInRect: CGRectMake(0, 0, 200, 200)];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [sharingItems addObject:finialString];
        [sharingItems addObject:smallImage];
        [sharingItems addObject:whatsappMsg];
        [sharingItems addObject:url];
        
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:applicationActivities];
        
        activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint,UIActivityTypeAddToReadingList,UIActivityTypeCopyToPasteboard,UIActivityTypeSaveToCameraRoll];
        
        if ([activityVC respondsToSelector:@selector(popoverPresentationController)])
        {
            // iOS 8+
            UIPopoverPresentationController *presentationController = [activityVC popoverPresentationController];
            
            presentationController.sourceView = self.view;
        }
        
        
        [self presentViewController:activityVC animated:YES completion:nil];
        
        
        
        
        
        
        
    }

        
    

        
    
    
    
}

- (IBAction)flag:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Are you sure you want to flag this.  This action cannot be undone" delegate:self cancelButtonTitle:@"Flag" otherButtonTitles:@"No", nil];
    [alert show];
    self.pointerCell=sender;
}
@end
