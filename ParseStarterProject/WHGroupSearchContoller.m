//
//  WHGroupSearchContollerViewController.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 3/3/14.
//
//

#import "WHGroupSearchContoller.h"
#import "WHGroupDisplay.h"

@interface WHGroupSearchContoller ()

@end

@implementation WHGroupSearchContoller

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        // UINib *nib = [UINib nibWithNibName:@"WHGroupDisplay" bundle:[NSBundle mainBundle]];
        // UINib *nib =[[NSBundle mainBundle] loadNibNamed:@"WHGroupDisplay" owner:self options:nil];
        // Register this NIB which contains the cell
        //[[self tableView] registerNib:nib
        //   forCellReuseIdentifier:@"WHGroupDisplay"];
        
        self.parseClassName = @"group";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 25;
    }
    return self;
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.
    if ([self.objects count] == 0) {
        // query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    [query whereKey:@"member" equalTo:[PFUser currentUser]];
    [query orderByDescending:@"createdAt"];
    
    return query;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
        WHGroupDisplay *cell=[[WHGroupDisplay alloc] initWithStyle:UITableViewCellAccessoryDetailButton reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell to show todo item with a priority at the bottom
    
    cell.gropuName.text = [object objectForKey:@"name"];
    //NSLog(@"hi %lu",(unsigned long)[[object objectForKey:@"users"] count]);
    
    cell.members.text = [NSString stringWithFormat:@"Members %@",
                         [object objectForKey:@"membercount"] ];
    
    PFFile *theImage = [object objectForKey:@"imageFile"];
    //PFFile *imageFile = [object objectForKey:@"imageFile"];
    //cell.imageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    NSData *imageData = [theImage getData];
    UIImage *image = [UIImage imageWithData:imageData];
    
    // PFFile *file=[object objectForKey:@"imageFile"];
    cell.groupLogo.image=image;
    
    
    
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

@end
