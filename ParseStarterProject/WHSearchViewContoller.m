//
//  WHSearchViewContoller.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 3/5/14.
//
//

#import "WHSearchViewContoller.h"
#import "WHGroupDisplay.h"
#import "WHGroupController.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"

@interface WHSearchViewContoller ()

@end

@implementation WHSearchViewContoller

@synthesize searchResults;

- (id)initWithCoder:(NSCoder *)decoder
{
    
    self = [super initWithCoder:decoder];
    
    if (self) {
        // UINib *nib = [UINib nibWithNibName:@"WHGroupDisplay" bundle:[NSBundle mainBundle]];
        // UINib *nib =[[NSBundle mainBundle] loadNibNamed:@"WHGroupDisplay" owner:self options:nil];
        // Register this NIB which contains the cell
        //[[self tableView] registerNib:nib
        //   forCellReuseIdentifier:@"WHGroupDisplay"];
[self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.searchBars setBarTintColor:[UIColor peterRiverColor]];
        self.parseClassName = @"group";
        self.paginationEnabled = YES;
        self.objectsPerPage = 25;
        self.searchResults = [NSMutableArray array];

        
        
        
    }
    return self;
}



- (PFQuery *)queryForTable {
       // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.
    if ([self.objects count] == 0) {
        // query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    PFQuery *query3;
    PFQuery *query2;
   
    if ([self.searchText compare:@""]!=NSOrderedSame ) {
        
    
        PFQuery *query1 = [PFQuery queryWithClassName:self.parseClassName];
        [query1 whereKey:@"name" containsString:[self.searchText capitalizedString]];
        
         query2 = [PFQuery queryWithClassName:self.parseClassName];
        [query2 whereKey:@"groupdescription" containsString:[self.searchText capitalizedString]];
       
        
        
        
        
        
         query3 = [PFQuery orQueryWithSubqueries:@[query1,query2]];
        [query3 includeKey:@"admin"];
         [query3 orderByDescending:@"membercount"];
           return query3;
    
    }
    else
    {
        query3 = [PFQuery queryWithClassName:self.parseClassName];
        [query3 whereKey:@"name" equalTo:@"zzzzzzxxcvxzdfsaskfasdfkndndskfasdfew"];
        [query3 orderByAscending:@"membercount"];
        return query3;
    }

    
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

    [[UIApplication sharedApplication]  setStatusBarHidden:YES];
   
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    

      [[UIApplication sharedApplication]  setStatusBarHidden:NO];
}

- (void)viewDidLoad
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewDidLoad];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil]
     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]
     forState:UIControlStateNormal];
   
   
   
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
        if (cell == nil) {
            cell=[[WHGroupDisplay alloc] init];
    }
    
    
    
  
    
    // Configure the cell to show todo item with a priority at the bottom
    
    cell.groupName.text =[object
                           objectForKey:@"name"];
        if([[object objectForKey:@"closed"] isEqualToString:@"true"])
    {
        
    }
    else
    {
        cell.closed.hidden=TRUE;
    }

    
    //NSLog(@"hi %lu",(unsigned long)[[object objectForKey:@"users"] count]);
    
    cell.members.text = [NSString stringWithFormat:@"Members %@",
                         [object
                          objectForKey:@"membercount"]];
   
    PFFile *theImage = [object
                        objectForKey:@"imageFile"];;
    //PFFile *imageFile = [object objectForKey:@"imageFile"];
    //cell.imageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    NSData *imageData = [theImage getData];
    UIImage *image = [UIImage imageWithData:imageData];
    
    
    UIGraphicsBeginImageContext(CGSizeMake(112, 100));
    [image drawInRect: CGRectMake(0, 0, 112, 100)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    cell.groupLogo.image=smallImage;
    
    
    cell.groupName.textColor =  [UIColor blackColor];
    cell.groupName.font =  [UIFont boldFlatFontOfSize:12.0];
    
    
    UIColor* neutralColor = [UIColor colorWithWhite:0.4 alpha:1.0];
    
    cell.members.textColor = neutralColor;
    cell.members.font =  [UIFont italicFlatFontOfSize:10.0f];
    
    cell.groupLogo.clipsToBounds = YES;
    cell.groupLogo.layer.cornerRadius =  cell.groupLogo.frame.size.height/2;
    cell.groupLogo.layer.borderWidth = 1.0f;
    cell.groupLogo.layer.borderColor = [[UIColor peterRiverColor]CGColor];
    
    

    return cell;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    
    
    for (UIView *view in _searchBars.subviews)
    {
        for (id subview in view.subviews)
        {
            if ( [subview isKindOfClass:[UIButton class]] )
            {
                [subview setEnabled:YES];
               
                return;
            }
        }
    }
}
- (void)enableCancelButton:(UISearchBar *)searchBar
{
    for (UIView *view in searchBar.subviews)
    {
        for (id subview in view.subviews)
        {
            if ( [subview isKindOfClass:[UIButton class]] )
            {
                [subview setEnabled:YES];
                
                return;
            }
        }
    }
}





-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searchText=searchText;
    
    if (_HUD==nil) {
        _HUD = [[MBProgressHUD alloc] initWithView:self.view];
        
        [self.view addSubview:_HUD];
        
        
        
      

    }
      [_HUD show:YES];
    

    [self loadObjects];
    
   
    
    //[self filterContentForSearchText:searchText];
}

- (void)objectsDidLoad:(NSError *)error;

{
    [super objectsDidLoad:error];
    
    [_HUD hide:YES];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.contentSize.height - scrollView.contentOffset.y < (self.view.bounds.size.height)) {
        if(![self isLoading] && self.objects.count >= self.objectsPerPage-1)
        {
            [self loadNextPage];
        }
    } }


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.searchText=searchBar.text;
        //[self filterContentForSearchText:searchBar.text];
     [searchBar resignFirstResponder];
    [self enableCancelButton:self.searchBars];
}
    




-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
    }

-(void)filterContentForSearchText:(NSString*)searchText  {
    
        if ([searchText caseInsensitiveCompare:@""]==NSOrderedSame) {
        [self.searchResults removeAllObjects];

        [self.tableView reloadData];
    }
    else
    {
    PFQuery *query1 = [PFQuery queryWithClassName:self.parseClassName];
    [query1 whereKey:@"name" containsString:searchText];
    
    PFQuery *query2 = [PFQuery queryWithClassName:self.parseClassName];
    [query2 whereKey:@"groupdescription"  containsString:searchText];
    

    
    
PFQuery *query3 = [PFQuery orQueryWithSubqueries:[NSArray arrayWithObjects:query1,query2, nil]];
    [query3 includeKey:@"admin"];
    [query3 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error)
        {
            [self.searchResults removeAllObjects];
            [self.searchResults addObjectsFromArray:objects];
            [self.tableView reloadData];
            
        }
        
    }];
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
        
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        
        messageLabel.text = @"No Search result is  available.";
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
    
    if ([segue.identifier isEqualToString:@"fromSearch"]) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        WHGroupController *WHGroupFeed = segue.destinationViewController;
        NSMutableArray *groupSearch = [NSMutableArray array];
        [groupSearch addObject:[self.objects objectAtIndex:indexPath.row]];
        WHGroupFeed.group=groupSearch;
        
        

    }
}



@end
