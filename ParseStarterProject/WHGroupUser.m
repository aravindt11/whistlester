//
//  WHGroupUser.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 8/12/14.
//
//

#import "WHGroupUser.h"
#import "WHGroupDisplay.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"

@interface WHGroupUser ()

@end

@implementation WHGroupUser

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
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        [[UIApplication sharedApplication]  setStatusBarHidden:NO];
    
    PFObject *currentGroup=self.group;
    PFRelation *relation = [currentGroup relationForKey:@"member"];
    
    self.objects=[[relation query] findObjects];
     
     }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.objects count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WHGroupDisplay";
    WHGroupDisplay *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[WHGroupDisplay alloc] init];
    }
    
    
        
        
        
        // Configure the cell to show todo item with a priority at the bottom
        
        cell.groupName.text =[[[self.objects objectAtIndex:indexPath.row]
                              objectForKey:@"nickname"]capitalizedString];
        
        //NSLog(@"hi %lu",(unsigned long)[[object objectForKey:@"users"] count]);
        
                PFFile *theImage = [[self.objects objectAtIndex:indexPath.row]
                            objectForKey:@"imageFile"];;
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
        
  
    
    cell.groupName.textColor = [UIColor blackColor];
    cell.groupName.font =  [UIFont boldFlatFontOfSize:12.0];
    
    cell.groupLogo.clipsToBounds = YES;
    cell.groupLogo.layer.cornerRadius =  cell.groupLogo.frame.size.height/2;
    cell.groupLogo.layer.borderWidth = 1.0f;
    cell.groupLogo.layer.borderColor = [[UIColor peterRiverColor]CGColor];
    if([[[self.group  objectForKey:@"admin"]objectForKey:@"nickname"] compare:[[self.objects objectAtIndex:indexPath.row] objectForKey:@"nickname"]]!=NSOrderedSame)
    {
        cell.admin.hidden=true;
        
    }
    else
    {
        cell.admin.hidden=false;
        cell.removeUser.hidden=true;
    }
    NSString *admin=[[self.group  objectForKey:@"admin"]objectForKey:@"nickname"];
    NSString *user=[[PFUser currentUser]objectForKey:@"nickname"];
    if([admin compare:user]!=NSOrderedSame)
    {
      cell.removeUser.hidden=true;
        
    }
    
   
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
