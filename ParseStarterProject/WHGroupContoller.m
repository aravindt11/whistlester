//
//  groupContoller.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 2/26/14.
//
//

#import "WHGroupContoller.h"
#import "WHGroupDisplay.h"
#import "WHGroupController.h"
#import "UIFont+FlatUI.h"
#import "UIColor+FlatUI.h"
@interface WHGroupContoller ()

@end

@implementation WHGroupContoller



- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
       
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        self.parseClassName = @"group";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 25;
    }
    return self;
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
       query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    [query whereKey:@"member" equalTo:[PFUser currentUser]];
    [query includeKey:@"admin"];
    [query orderByDescending:@"createdAt"];
    
    return query;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:NO];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
        
        messageLabel.text = @"No data is currently available. Please Join or create group to refresh.";
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    cell.groupName.text = [[object objectForKey:@"name"]capitalizedString];
    //NSLog(@"hi %lu",(unsigned long)[[object objectForKey:@"users"] count]);
    
    cell.members.text = [NSString stringWithFormat:@"Members %@",
                                [object objectForKey:@"membercount"] ];
    
    PFFile *theImage = [object objectForKey:@"imageFile"];
    //PFFile *imageFile = [object objectForKey:@"imageFile"];
    //cell.imageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    NSData *imageData = [theImage getData];
    UIImage *image = [UIImage imageWithData:imageData];
    
    UIGraphicsBeginImageContext(CGSizeMake(112, 100));
    [image drawInRect: CGRectMake(0, 0, 112, 100)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

     cell.groupLogo.image=smallImage;
   // PFFile *file=[object objectForKey:@"imageFile"];
  
    cell.groupName.textColor =  [UIColor blackColor];
    cell.groupName.font =  [UIFont boldFlatFontOfSize:12.0];
    
    
    UIColor* neutralColor = [UIColor colorWithWhite:0.4 alpha:1.0];
    
    cell.members.textColor = neutralColor;
    cell.members.font =  [UIFont italicFlatFontOfSize:10.0f];
 
    
    if([[object objectForKey:@"closed"] isEqualToString:@"true"])
    {
         cell.closed.hidden=false;
    }
    else
    {
        cell.closed.hidden=TRUE;
    }
    
    cell.groupLogo.clipsToBounds = YES;
    cell.groupLogo.layer.cornerRadius =  cell.groupLogo.frame.size.height/2;
     cell.groupLogo.layer.borderWidth = 1.0f;
    cell.groupLogo.layer.borderColor = [[UIColor peterRiverColor]CGColor];


    
    return cell;
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
    if ([segue.identifier isEqualToString:@"fromGroup"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        WHGroupController *WHGroupFeed = segue.destinationViewController;
        NSMutableArray *groupSearch = [NSMutableArray array];
        [groupSearch addObject:[self.objects objectAtIndex:indexPath.row]];
        WHGroupFeed.group=groupSearch;
        
        
        
        
    }
}

@end
