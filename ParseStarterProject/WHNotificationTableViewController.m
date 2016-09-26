//
//  groupContoller.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 2/26/14.
//
//

#import "WHNotificationTableViewController.h"
#import "WHGroupDisplay.h"
#import "WHGroupController.h"
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"

@interface WHNotificationTableViewController ()

@end

@implementation WHNotificationTableViewController



- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        
        
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        self.parseClassName = @"notification";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = NO;
        self.objectsPerPage = 20;
        
    }
    return self;
}



-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
        self.navigationController.tabBarItem.badgeValue=nil;
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
     [PFInstallation currentInstallation].badge = 0;
    [[PFInstallation currentInstallation] saveInBackground];

    //[self.tableView reloadData ];
    
    
    [self loadObjects];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
}


- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.
    if ([self.objects count] == 0) {
        // query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    [query whereKey:@"user" equalTo:[[PFUser currentUser] objectId]];
    [query whereKey:@"usernew" notEqualTo:[PFUser currentUser]];
    [query includeKey:@"group"];
    [query includeKey:@"usernew"];
    [query includeKey:@"admin"];
    [query orderByDescending:@"createdAt"];
    query.limit=20;
    return query;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.tabBarItem.badgeValue=nil;
     [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [PFInstallation currentInstallation].badge = 0;
    [[PFInstallation currentInstallation] saveInBackground];
   
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
   
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object {
    static NSString *CellIdentifier = @"WHGroupDisplay";
    
    
    WHGroupDisplay *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[WHGroupDisplay alloc] init];
    }
    
    // Configure the cell to show todo item with a priority at the bottom
      cell.groupName.font =  [UIFont boldFlatFontOfSize:12.0];
   
   NSString *data = [[object objectForKey:@"data"]capitalizedString];
    NSMutableAttributedString *attString =    [[NSMutableAttributedString alloc]
                                               initWithString: data];
   NSRange range = [data rangeOfString:@" Posted In "];
    [attString addAttribute: NSFontAttributeName
                      value:  [UIFont flatFontOfSize:12.0f]
                      range: range];
     cell.groupName.attributedText=attString;
    
  
    
    PFFile *theImage = [[object objectForKey:@"usernew"] objectForKey:@"imageFile"];
    
    
    
    NSData *imageData = [theImage getData];
    UIImage *image = [UIImage imageWithData:imageData];
    
    UIGraphicsBeginImageContext(CGSizeMake(112, 100));
    [image drawInRect: CGRectMake(0, 0, 112, 100)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    
    // PFFile *file=[object objectForKey:@"imageFile"];
    cell.groupLogo.image=smallImage;
    
    cell.groupLogo.image=image;
    cell.groupName.textColor =  [UIColor blackColor];
  
    
    
    UIColor* neutralColor = [UIColor colorWithWhite:0.4 alpha:1.0];
    
    cell.members.textColor = neutralColor;
    cell.members.font =  [UIFont italicFlatFontOfSize:10.0f];
    
    cell.groupLogo.clipsToBounds = YES;
    cell.groupLogo.layer.cornerRadius =  cell.groupLogo.frame.size.height/2;
    cell.groupLogo.layer.borderWidth = 1.0f;
    cell.groupLogo.layer.borderColor = [[UIColor peterRiverColor]CGColor];

    
    return cell;
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
        
        messageLabel.text = @"No New notification available .";
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"fromnoti"]) {
        
        
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        WHGroupController *WHGroupFeed = segue.destinationViewController;
        NSMutableArray *groupSearch = [NSMutableArray array];
        PFObject *notiGroup=[[self.objects objectAtIndex:indexPath.row] objectForKey:@"group"];
        
        PFQuery *query = [PFQuery queryWithClassName:@"group"];
        
       
       
        [query whereKey:@"objectId" equalTo:[notiGroup objectId]];
        [query includeKey:@"admin"];
       
        NSArray *foundGroup=[query findObjects];
        
        [groupSearch addObject:[foundGroup objectAtIndex:0]];
        WHGroupFeed.group=groupSearch;
        
        
        
        
    }
}

@end
