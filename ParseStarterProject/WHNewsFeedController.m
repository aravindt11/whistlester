//
//  WHNewsFeedController.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 7/2/14.
//
//

#import "WHNewsFeedController.h"
#import "WHCommentViewController.h"
#import "GTScrollNavigationBar.h"
#import "UIFont+FlatUI.h"
#import "WHService.h"
#import "UIViewController+MJPopupViewController.h"
#import "WHMainTabController.h"
#import "WHGroupContoller.h"
#import "WHSearchViewContoller.h"
#import "WHPostContoller.h"
#import "WHGroupController.h"





@interface WHNewsFeedController ()

@end

@implementation WHNewsFeedController
@synthesize cells,pointerCell,tab,segment;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //[self.navigationController setNavigationBarHidden:no animated:NO];
    //self.navigationController.scrollNavigationBar.scrollView = self.tableView;
    self.segment.selectedFontColor=[UIColor whiteColor ];
    self.segment.deselectedFontColor=[UIColor asbestosColor];
    self.segment.selectedColor=[UIColor clearColor];
    self.segment.deselectedColor=[UIColor clearColor];
    // self.segment.borderColor=[UIColor clearColor];
    self.segment.selectedFont=[UIFont boldFlatFontOfSize:20];
    self.segment.deselectedFont=[UIFont boldFlatFontOfSize:15];
    self.segment.borderWidth=0;

    
    [self.segment addTarget:self
                         action:@selector(segmentChanged:)
               forControlEvents:UIControlEventValueChanged];
}

-(IBAction)segmentChanged:(id)sender
{
    [self viewDidAppear:YES];
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    
    [self.view addSubview:_HUD];
    
    
    
    // Set determinate mode
    
   // HUD.mode = MBProgressHUDModeIndeterminate;
    
    //HUD.delegate = self;
    
    //HUD.labelText = @"Uploading";
    
    [_HUD show:YES];

    
    [self loadObjects];
    
  
    
    
   
    
    
}

- (void)objectsDidLoad:(NSError *)error;

{
    [super objectsDidLoad:error];
    
    [_HUD hide:YES];
    
}







- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
    self.navigationController.scrollNavigationBar.scrollView = self.tableView;

    [self.navigationController setNavigationBarHidden:NO animated:NO];

    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeSystem];
    UISegmentedControl *segmentedControl = (UISegmentedControl *)self.segment;
    NSString *info = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
    
    
    [btn setFrame:CGRectMake(window.frame.size.width/2-35, window.frame.size.height-70,70, 70)];
    btn.backgroundColor=[UIColor peterRiverColor];
    
    
    
  
     WHMainTabController *mainTab=(WHMainTabController *)self.tabBarController;
    
    if (self.objects.count == 0) {
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"No Post is currently available. Please Join or create group to refresh.";
        messageLabel.textColor = [UIColor darkGrayColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont flatFontOfSize:15];
        [messageLabel sizeToFit];
        
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
               
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

        
        [mainTab.centerButton addTarget:self action:@selector(worldPost:)  forControlEvents:UIControlEventTouchUpInside];
        
        
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
        if([info isEqualToString:@"Explore"])
        {
            [mainTab.centerButton removeTarget:nil
                               action:NULL
                     forControlEvents:UIControlEventAllEvents];
            

                [mainTab.centerButton addTarget:self action:@selector(worldPost:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            [mainTab.centerButton removeTarget:nil
                                        action:NULL
                              forControlEvents:UIControlEventAllEvents];

        
            [mainTab.centerButton addTarget:self.tabBarController action:@selector(post1:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    

   
    
}

-(IBAction)worldPost:(id)sender
{
    PFQuery *adminGroup=[PFQuery queryWithClassName:@"group"];
    [adminGroup whereKey:@"name" equalTo:@"Whistlester"];
    NSMutableArray *admin=[[NSMutableArray alloc]initWithArray:[adminGroup findObjects]];
         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    WHPostContoller *myVC = (WHPostContoller *)[storyboard instantiateViewControllerWithIdentifier:@"postContoller"];
    
    myVC.group=admin;
    
    [self.navigationController pushViewController:myVC animated:YES];
    
    
}







- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     WHMainTabController *mainTab=(WHMainTabController *)self.tabBarController;
    [mainTab.centerButton removeTarget:nil
                                action:NULL
                      forControlEvents:UIControlEventAllEvents];
    
    
    [mainTab.centerButton addTarget:self.tabBarController action:@selector(post1:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationController.scrollNavigationBar.scrollView = nil;
  
    self.navigationController.scrollNavigationBar.scrollView = nil;
    
    

}


- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    [self.navigationController.scrollNavigationBar resetToDefaultPosition:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.contentSize.height - scrollView.contentOffset.y < (self.view.bounds.size.height)) {
        if(![self isLoading] && self.objects.count >= self.objectsPerPage-1)
        {
            [self loadNextPage];
        }
    } }



- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.
    if ([self.objects count] == 0) {
        // query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    UISegmentedControl *segmentedControl = (UISegmentedControl *)self.segment;
    NSString *info = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
 
    if([info isEqualToString:@"Explore"])
    {
    
        PFQuery *adminGroup=[PFQuery queryWithClassName:@"group"];
        [adminGroup whereKey:@"name" equalTo:@"Whistlester"];
       
        PFObject *admin;
        
        admin=[[adminGroup findObjects] objectAtIndex:0];
        
       
        if (admin!=nil) {
           
               [query whereKey:@"group" equalTo:admin];
            [query whereKey:@"ban" notEqualTo:[[PFUser currentUser]objectId]];


        }
        else{
            
            [query whereKey:@"group" equalTo:@"cool"];
            
        }
        
        [query includeKey:@"userinfopointer"];
        [query includeKey:@"group"];
        [query orderByAscending:@"bancount"];
        [query addDescendingOrder:@"updatedAt"];
        
    }
    else
    {
    PFRelation *userRelation=[[PFUser currentUser] relationForKey:@"group"];
    PFQuery *innerQuery = [userRelation query];
    [innerQuery includeKey:@"admin"];
    NSArray *groupObjects=[innerQuery findObjects];
    self.groupInfo=groupObjects;
    [query whereKey:@"group" containedIn:groupObjects];
    [query whereKey:@"ban" notEqualTo:[[PFUser currentUser]objectId]];
    [query includeKey:@"userinfopointer"];
    [query includeKey:@"group"];
    [query orderByAscending:@"bancount"];
    [query addDescendingOrder:@"updatedAt"];
    }
    
    return query;
}



-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
                       object:(PFObject *)object {
    static NSString *CellIdentifier = @"FeedCell3";
    
    

    
    FeedCell3 *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell=[[FeedCell3 alloc] init];
    }
    WHService *service=[[WHService alloc]init];
    UISegmentedControl *segmentedControl = (UISegmentedControl *)self.segment;
    NSString *info = [segmentedControl titleForSegmentAtIndex: [segmentedControl selectedSegmentIndex]];
    
    if([info isEqualToString:@"Explore"])
    {
        return [service setData:cell forObject:object for:@"newsfeedExplore"];

    }
    else
    {
        
        return [service setData:cell forObject:object for:@"newsfeed"];

    }

    
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
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"No Post is currently available. Please Join or create group to refresh.";
        messageLabel.textColor = [UIColor darkGrayColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.font = [UIFont flatFontOfSize:15];
        [messageLabel sizeToFit];
        
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
       
        return 0;
    }

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
    [service likeService:cell forObject:post in:self.tableView for:@"newsfeed"];
    
    
       
    
}

- (IBAction)unlike:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
    FeedCell3 *cell = (FeedCell3*)[self.tableView cellForRowAtIndexPath:indexPath ];
    
    PFObject *post =  [self.objects objectAtIndex:indexPath.row];
    
    WHService   *service=[[WHService alloc]init];
    [service DislikeService:cell forObject:post in:self.tableView for:@"newsfeed"];
    

    
       
    
}



- (IBAction)delete1:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Are you sure you want to delete this.  This action cannot be undone" delegate:self cancelButtonTitle:@"Delete" otherButtonTitles:@"Cancel", nil];
    [alert show];
    self.pointerCell=sender;
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
   
        
        NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    
        if([title isEqualToString:@"Delete"])
        {

        CGPoint buttonPosition = [self.pointerCell convertPoint:CGPointZero toView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
        
        
        
        
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
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"commentNewsFeed"])
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
    if ([[segue identifier] isEqualToString:@"buttonGroupFeed"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        WHGroupController *WHGroupFeed = segue.destinationViewController;
      
        __block PFObject *groupObject;
        for(int i=0;i<self.groupInfo.count;i++)
        {
            if ([[[[self.objects objectAtIndex:indexPath.row]objectForKey:@"group"]objectId]isEqualToString:[[self.groupInfo objectAtIndex:i]objectId]]) {
                groupObject=[self.groupInfo objectAtIndex:i];
                
         
         
                break;

            }
        }
        NSMutableArray *groupSearch = [NSMutableArray array];
        if (groupObject!=nil) {
             [groupSearch addObject:groupObject ];
        }
             WHGroupFeed.group=groupSearch;
        

    }
    
    
}







- (IBAction)flag:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Are you sure you want to flag this.  This action cannot be undone" delegate:self cancelButtonTitle:@"Flag" otherButtonTitles:@"No", nil];
    [alert show];
    self.pointerCell=sender;

}
@end
