//
//  WHCommentViewController.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 6/25/14.
//
//

#import "WHCommentViewController.h"
#import "WHcommentTableViewCell.h"
#import "WHLikeorDislike.h"
#import "WHService.h"
#import "UIColor+FlatUI.h"
#import "NSDate+Helper.h"//
#import "UIFont+FlatUI.h"
#import "WHGroupDisplay.h"

@interface WHCommentViewController ()

@end

@implementation WHCommentViewController
@synthesize cells,postGot,pointerCell,pointerCell1;


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
        
        
        
        self.parseClassName = @"comment";
        self.pullToRefreshEnabled = YES;
        self.paginationEnabled = YES;
        self.objectsPerPage = 25;
        
    }
    return self;
}

- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    //PFQuery *comment = [PFQuery queryWithClassName:@"comment"];
    // If no objects are loaded in memory, we look to the cache
    // first to fill the table and then subsequently do a query
    // against the network.
    if ([self.objects count] == 0) {
        // query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    
    [query whereKey:@"post" equalTo:postGot.objectId];
    [query includeKey:@"userinfopointer"];
    [query orderByAscending
     :@"createdAt"];
    
    return query;
    
    
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
                       object:(PFObject *)object {

    

    static NSString *CellIdentifier = @"WHcommentTableView";
    
    
    WHcommentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
       if (cell == nil) {
        cell=[[WHcommentTableViewCell alloc] init];
    }
    
   
    
   
   
    
    cell.nickname.text=[[object objectForKey:@"userinfopointer"] objectForKey:@"nickname"];
    
    
    PFFile *theImage = [[object objectForKey:@"userinfopointer"] objectForKey:@"imageFile"];
   
    NSData *imageData = [theImage getData];
    UIImage *image = [UIImage imageWithData:imageData];
    
    UIGraphicsBeginImageContext(CGSizeMake(80, 80));
    [image drawInRect: CGRectMake(0, 0, 80, 80)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    cell.image.image=smallImage;
    cell.date.text=[NSDate stringForDisplayFromDate:[object createdAt]];
    cell.comment.text=[object objectForKey:@"commentcontent"];
    
    
    NSString *admin=[[[self.postGot objectForKey:@"group"] objectForKey:@"admin"]objectId] ;
    PFUser *postUser=[object objectForKey:@"userinfopointer"] ;
    if([[postUser objectId] isEqualToString:[[PFUser currentUser] objectId]] || [admin isEqualToString:[[PFUser currentUser] objectId]])
    {
        cell.delete.hidden=false;
        
    }
    else
    {
        cell.delete.hidden=true;
    }
   

    
    
    
       return cell;
}




- (BOOL)allowsHeaderViewsToFloat{
    return NO;
}




-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 240.0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 70.0;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
  
    
    
   
    static NSString *CellIdentifier = @"footer";
    WHGroupDisplay *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
       cell=[[WHGroupDisplay alloc] init];
    }
   
    [cell setTag:100];
    
    return [cell contentView];
    
}
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    static NSString *CellIdentifier = @"FeedCell3";
    
    
    
    
    FeedCell3 *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell=[[FeedCell3 alloc] init];
    }
    WHService *service=[[WHService alloc]init];
    PFObject *object=self.postGot;
    cells=[service setData:cell forObject:object for:@"commentfeed"];
    return cells;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (pointerCell == nil) {
        static NSString *CellIdentifier = @"WHcommentTableView";
        pointerCell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
   
    
  
    
    pointerCell.nickname.text=[[[self.objects objectAtIndex:indexPath.row] objectForKey:@"userinfopointer"] objectForKey:@"nickname"];
    
    
    PFFile *theImage = [[self.objects objectAtIndex:indexPath.row] objectForKey:@"imageFile"];
    NSData *imageData = [theImage getData];
    UIImage *image = [UIImage imageWithData:imageData];
    
   
    pointerCell.image.image=image;
    
    pointerCell.comment.text=[[self.objects objectAtIndex:indexPath.row] objectForKey:@"commentcontent"];
    
    //pointerCell.nickname.textColor =  [UIColor blackColor];
   // pointerCell.nickname.font =  [UIFont boldFlatFontOfSize:12];
    

  //UIColor* neutralColor = [UIColor colorWithWhite:0.4 alpha:1.0];
    
    //pointerCell.comment.textColor = neutralColor;
    //pointerCell.comment.font =  [UIFont flatFontOfSize:10.0f ];
    
    
    
    
    pointerCell.image.clipsToBounds = YES;
    
    PFUser *postUser=[[self.objects objectAtIndex:indexPath.row] objectForKey:@"userinfopointer"] ;
    if([[postUser objectId] isEqualToString:[[PFUser currentUser] objectId]])
    {
        pointerCell.delete.hidden=false;
        
    }
    else
    {
        pointerCell.delete.hidden=true;
    }

       [pointerCell layoutIfNeeded];
    
    
    
    CGFloat height=[pointerCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    
   
    
  
    
    if (height<68) {
        height=70;
    }

    
    return height+2;

}



- (IBAction)like:(id)sender {
    
    PFObject *post = self.postGot;
    
    
    WHService   *service=[[WHService alloc]init];
    [service likeService:cells forObject:post in:self.tableView  for:@"commentfeed" ];
    
    
    
}

- (IBAction)unlike:(id)sender {
    

    
     PFObject *post = self.postGot;
    
    
    WHService   *service=[[WHService alloc]init];
    [service DislikeService:cells forObject:post in:self.tableView for:@"commentfeed"];
    

    
        
        
    }
    
    
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        
        
        CGPoint buttonPosition = [self.pointerCell convertPoint:CGPointZero toView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:buttonPosition];
        
        //NSLog(@"%ld", (long)indexPath.row);
        
        
        PFObject *comment =  [self.objects objectAtIndex:indexPath.row];
        
       [comment deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
           if (succeeded) {
               [self.postGot incrementKey:@"comment" byAmount:[NSNumber numberWithInt:-1]];
               [self.postGot saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                   if (succeeded) {
                         [self loadObjects] ;
                   }
               }];
           }
       }];
       // NSNumber *count = [NSNumber numberWithInt:-1];
        //[currentGroup incrementKey:@"membercount" byAmount:count];
        
        
        
        
        self.tableView.contentOffset = CGPointMake(0, 0 - self.tableView.contentInset.top);
        
    }
    
}


    - (IBAction)deleteComment:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Are you sure you want to delete this.  This action cannot be undone" delegate:self cancelButtonTitle:@"Delete" otherButtonTitles:@"Cancel", nil];
    [alert show];
    self.pointerCell1=sender;

}








- (IBAction)post:(id)sender {
    
    
       //UITableViewCell *cell = (UITableViewCell *)[self.tableView viewWithTag:100];
    
    UITextField *getTextView =(UITextField*)[self.tableView  viewWithTag:200];
   
   
    
    PFObject *comments=[PFObject objectWithClassName:@"comment"];
    
     comments[@"commentcontent"]=getTextView.text;
    

    
    comments[@"userinfopointer"]= [PFUser currentUser];
    comments[@"post" ]=postGot.objectId;
    
    
    [comments saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            [self loadObjects] ;
            if (self.tableView.contentSize.height > self.tableView.frame.size.height)
            {
                CGPoint offset = CGPointMake(0, self.tableView.contentSize.height -     self.tableView.frame.size.height);
                
                [self.tableView setContentOffset:offset animated:YES];
            }
            getTextView.text=nil;
            
            [postGot incrementKey:@"comment"];
            
            [postGot saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                 if (succeeded) {
                     
                     PFQuery *pushQuery = [PFInstallation query];
                     [pushQuery whereKey:@"user" equalTo:[postGot objectForKey:@"userinfopointer"]];
                    
                     
                     
                     
                     PFPush *push = [[PFPush alloc] init];
                     [push setQuery:pushQuery];
                     
                     NSString *msg=[[[PFUser currentUser] objectForKey:@"nickname"] stringByAppendingString:@" commented on your post" ];
                     [push setMessage:msg];
                     [push sendPushInBackground];
                     
                   

                     
                     
                
                 }
                else
                {
                    NSLog(@"Error: %@ %@", error, [error userInfo]);
                    
                    [comments deleteInBackground];
                    [[[UIAlertView alloc] initWithTitle:@"Network Issue"
                                                message:@"Please try again in few seconds"
                                               delegate:nil
                                      cancelButtonTitle:@"ok"
                                      otherButtonTitles:nil] show];
                }
            }];
            
                  }
        else{
            NSLog(@"Error1a: %@ %@", error, [error userInfo]);
            [[[UIAlertView alloc] initWithTitle:@"Network Issue"
                                        message:@"Please try again in few seconds"
                                       delegate:nil
                              cancelButtonTitle:@"ok"
                              otherButtonTitles:nil] show];
        }
    }];
    

    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WHLikeorDislike *WHLikeorDislike = segue.destinationViewController;
    WHLikeorDislike.postGotNew=self.postGot;
    if ([segue.identifier isEqualToString:@"like"]) {
        
        //NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
       
         //if ([self.flag caseInsensitiveCompare:@"like"]==NSOrderedSame)  {
            WHLikeorDislike.flag=@"like";
        
    }
    else
    {
        WHLikeorDislike.flag=@"unlike";
    }
    
   
    
    
        
        
        
        
    }





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)delete:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Are you sure you want to delete this.  This action cannot be undone" delegate:self cancelButtonTitle:@"Delete" otherButtonTitles:@"Cancel", nil];
    [alert show];
    self.pointerCell=sender;
}
@end
