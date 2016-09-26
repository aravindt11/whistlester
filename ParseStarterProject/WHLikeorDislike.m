//
//  WHLikeorDislike.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 6/28/14.
//
//

#import "WHLikeorDislike.h"
#import "WHGroupDisplay.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"


@interface WHLikeorDislike ()

@end

@implementation WHLikeorDislike
@synthesize flag;
- (void)awakeFromNib
{
    // Initialization code
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
        
        messageLabel.text = @"No user avaliable.";;
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

-(void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.flag caseInsensitiveCompare:@"like"]==NSOrderedSame)  {
       self.title = @"True";
    }
    else
    {
        self.title = @"False";
    }
}


- (PFQuery *)queryForTable {
    NSArray *relation;
    if ([self.flag caseInsensitiveCompare:@"like"]==NSOrderedSame)  {
         relation=[self.postGotNew objectForKey:@"like" ];
        
           }
    else
    {
        relation=[self.postGotNew objectForKey:@"unlike" ];
        
        
    }
    
    
    // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"objectId" containedIn:relation];

    
    //[query includeKey:@"userinfopointer"];
    
    
    return query;
}

-(void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
        [[UIApplication sharedApplication]  setStatusBarHidden:NO];
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
                       object:(PFObject *)object {
    static NSString *CellIdentifier = @"WHGroupDisplay";
    
    
    WHGroupDisplay *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[WHGroupDisplay alloc] init];
    }
    
    
    // Configure the cell to show todo item with a priority at the bottom
    
        cell.groupName.text=[object objectForKey:@"nickname"];
    
    
    PFFile *theImage = [object objectForKey:@"imageFile"];
    //PFFile *imageFile = [object objectForKey:@"imageFile"];
    //cell.imageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    NSData *imageData = [theImage getData];
    UIImage *image = [UIImage imageWithData:imageData];
    UIGraphicsBeginImageContext(CGSizeMake(112, 100));
    [image drawInRect: CGRectMake(0, 0, 112, 100)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // PFFile *file=[object objectForKey:@"imageFile"];
    cell.groupLogo.image=smallImage;
    cell.groupName.textColor=[UIColor blackColor];
  
    cell.groupName.font=[UIFont flatFontOfSize:12];
    cell.groupLogo.clipsToBounds = YES;
    cell.groupLogo.layer.cornerRadius =  cell.groupLogo.frame.size.height/2;
    cell.groupLogo.layer.borderWidth = 1.0f;
    cell.groupLogo.layer.borderColor = [[UIColor peterRiverColor]CGColor];
    
    
    return cell;
}



@end
