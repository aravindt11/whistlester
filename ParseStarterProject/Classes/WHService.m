//
//  WHService.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 8/20/14.
//
//

#import "WHService.h"
#import "UIFont+FlatUI.h"
#import "NSDate+Helper.h"
#import "UIImage+ResizeAdditions.h"


@implementation WHService

-(FeedCell3 *)setData:(FeedCell3 *)cell forObject:(PFObject *)object for:(NSString *)view;
{
    
    NSArray *like=[object objectForKey:@"like" ];
    NSArray *unlike=[object objectForKey:@"unlike" ];
    NSMutableArray *allMyObjectsLike = [NSMutableArray arrayWithArray: like];
    NSMutableArray *allMyObjectsUnlike = [NSMutableArray arrayWithArray: unlike];
    
    // Configure the cell to show todo item with a priority at the bottom
    NSString *userName=[[[object objectForKey:@"userinfopointer"] objectForKey:@"nickname"] capitalizedString];
    
    NSString *admin=[[[object objectForKey:@"group"] objectForKey:@"admin"]objectId] ;
    

    
   
    
    
    if([view compare:@"newsfeed"]==NSOrderedSame)
    {
        NSString *postedInString=@" posted in ";
        NSString *postGroup=[[[object objectForKey:@"group"] objectForKey:@"name"]capitalizedString];
    NSString *nameLable=[userName stringByAppendingString:[postedInString stringByAppendingString:postGroup ] ];
   // NSString *nameLable=[userName stringByAppendingString:postedInString  ];
        
    NSMutableAttributedString *attString =    [[NSMutableAttributedString alloc]
                                               initWithString: nameLable];
        
        NSMutableAttributedString *postGroupAttString =    [[NSMutableAttributedString alloc]
                                                   initWithString: postGroup];
  
        
    [attString addAttribute: NSFontAttributeName
                      value:  [UIFont flatFontOfSize:12.0f]
                      range: NSMakeRange(userName.length,postedInString.length)];
        
        [postGroupAttString addAttribute: NSFontAttributeName
                          value:  [UIFont flatFontOfSize:12.0f]
                          range: NSMakeRange(0,postGroupAttString.length)];
        
        cell.nameLabel.attributedText=attString;
        cell.button.enabled=true;

       
    }
    else
    {
        cell.button.enabled=false;
        cell.nameLabel.text=userName;
        
    }
    cell.date.text=[NSDate stringForDisplayFromDate:[object createdAt]];
    
    
    PFFile *theImage = [[object objectForKey:@"userinfopointer"] objectForKey:@"imageFile"];
    
    UIImage *image = [UIImage imageWithData:[theImage getData]];
    UIImage *smallImage = [image resizedImage:CGSizeMake(126, 122) interpolationQuality:4];
    cell.profileImageView.image=smallImage;

    
      /*UIGraphicsBeginImageContext(CGSizeMake(63, 61));
    [image drawInRect: CGRectMake(0, 0, 63, 61)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();*/

    
    // PFFile *file=[object objectForKey:@"imageFile"];
    //cell.profileImageView.image=smallImage;
    
    //for(int i=0;i<count.accessibilityElementCount)
    
    cell.dateLabel.text=[object objectForKey:@"postcontent"] ;
    
    
    
    int postcount=[[object objectForKey:@"postcount"] intValue];
    if(postcount==0)
    {
        cell.likeCountLabel.text=@"";
    }
    else
    {
        NSString *postLike=[NSString stringWithFormat:@"%@",[object objectForKey:@"postcount"]];
        cell.likeCountLabel.text=[postLike stringByAppendingString:@" Truth" ];
    }
    int unpostcount=[[object objectForKey:@"unpostcount"] intValue];
    if(unpostcount==0)
    {
        cell.unlikeCountLable.text=@"";
    }
    else
    {
        NSString *unpostLike=[NSString stringWithFormat:@"%@",[object objectForKey:@"unpostcount"]];
        cell.unlikeCountLable.text=[unpostLike stringByAppendingString:@" False" ];
    }
    // NSString *comment=[NSString stringWithFormat:@"%@",[object objectForKey:@"comment"]];
    if([[object objectForKey:@"comment"]intValue]==0){
        cell.commentCountLabel.text=@"";
    }
    else
    {
        NSString *comment=[NSString stringWithFormat:@"%@",[object objectForKey:@"comment"]];
        cell.commentCountLabel.text=[comment stringByAppendingString:@" comment" ];
    }
    
    NSString *postUser=[[object objectForKey:@"userinfopointer"]objectId] ;
    NSString *currentUser=[[PFUser currentUser] objectId];
    //NSLog(@"%@",[postUser objectId]);
    if([postUser isEqualToString:currentUser] || [admin isEqualToString:currentUser])
    {
        cell.flag.hidden=true;
        cell.recycle.hidden=false;
        
    }
    else
    {
        cell.flag.hidden=FALSE;
        cell.recycle.hidden=true;

    }
    
    
    if ([allMyObjectsLike containsObject:[[PFUser currentUser] objectId]]) {
        [cell.likeButton setTitleColor:[UIColor emerlandColor] forState:UIControlStateNormal];
        
    }
    else{
        // cell.likeButton.enabled=true;
        [cell.likeButton setTitleColor:[UIColor asbestosColor] forState:UIControlStateNormal];
        
    }
    
    if ([allMyObjectsUnlike containsObject:[[PFUser currentUser] objectId]]) {
        // cell.unlikeButton.enabled=false;
        
        [cell.unlikeButton setTitleColor:[UIColor alizarinColor] forState:UIControlStateNormal];
        
    }
    else{
        //cell.unlikeButton.enabled=true;
        [cell.unlikeButton setTitleColor:[UIColor asbestosColor] forState:UIControlStateNormal];
        
    }
    
    //[cell. addTarget:self action:@selector(btnCommentClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    return cell;
}

-(void)DislikeService:(FeedCell3 *)cell forObject:(PFObject *)post in:(UITableView *)PfTableview for:(NSString *)view;
{
    NSArray *like=[post objectForKey:@"like" ];
    NSArray *unlike=[post objectForKey:@"unlike" ];
    NSMutableArray *allMyObjectsLike = [NSMutableArray arrayWithArray: like];
    NSMutableArray *allMyObjectsUnlike = [NSMutableArray arrayWithArray: unlike];
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.duration = 0.2;
    anim.repeatCount = 1;
    anim.autoreverses = YES;
    anim.removedOnCompletion = YES;
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)];
    [cell.unlikeButton.layer addAnimation:anim forKey:nil];
    
    
    
    if ([allMyObjectsUnlike containsObject:[[PFUser currentUser] objectId]]) {
        [allMyObjectsUnlike removeObject:[[PFUser currentUser] objectId]];
        
        [cell.unlikeButton setTitleColor:[UIColor asbestosColor] forState:UIControlStateNormal];
        
        int unlikePostCount=[[NSString stringWithFormat:@"%@",[post objectForKey:@"unpostcount"]] intValue]-1;
        if (unlikePostCount!=0) {
            cell.unlikeCountLable.text=[[NSString stringWithFormat:@"%d",unlikePostCount] stringByAppendingString:@" Flase" ];
        }
        else
        {
            cell.unlikeCountLable.text=@"";
        }
        
        [post setObject:[NSNumber numberWithInt:unlikePostCount] forKey:@"unpostcount"];
        [post  setObject:allMyObjectsUnlike forKey:@"unlike"];
    }
    else
    {
        if ([allMyObjectsLike containsObject:[[PFUser currentUser] objectId]]) {
            [allMyObjectsLike removeObject:[[PFUser currentUser] objectId]];
            [cell.likeButton setTitleColor:[UIColor asbestosColor] forState:UIControlStateNormal];
            int likePostCount=[[NSString stringWithFormat:@"%@",[post objectForKey:@"postcount"]] intValue]-1;
            if (likePostCount!=0) {
                cell.likeCountLabel.text=[[NSString stringWithFormat:@"%d",likePostCount] stringByAppendingString:@" Truth" ];
            }
            else
            {
                cell.likeCountLabel.text=@"";
            }
            
            [post setObject:[NSNumber numberWithInt:likePostCount] forKey:@"postcount"];
        }
        [cell.unlikeButton setTitleColor:[UIColor alizarinColor] forState:UIControlStateNormal];
        [allMyObjectsUnlike addObject:[[PFUser currentUser] objectId]];
        [post  setObject:allMyObjectsUnlike forKey:@"unlike"];
        [post  setObject:allMyObjectsLike forKey:@"like"];
        [post incrementKey:@"unpostcount"];
        
        
        int totalLike=[[NSString stringWithFormat:@"%@",[post objectForKey:@"unpostcount"]] intValue];
        if (totalLike!=0) {
            cell.unlikeCountLable.text=[[NSString stringWithFormat:@"%d",totalLike] stringByAppendingString:@" False" ];
            
        }
        else
        {
            cell.unlikeCountLable.text=@"";
        }
        
        
    }
    [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            //cell.unlikeButton.enabled=false;
            
            //cell.likeButton.enabled=true;
            //[self.tableView reloadData];
            
            
        }
        else{
            if (error.code==101) {
                [[[UIAlertView alloc] initWithTitle:@"Post Delted"
                                            message:@"Post Has Been Delted By the User"
                                           delegate:nil
                                  cancelButtonTitle:@"ok"
                                  otherButtonTitles:nil] show];
                
                 
               [PfTableview reloadData];
            }
            else
            {
                
                [[[UIAlertView alloc] initWithTitle:@"Network Issue"
                                            message:@"Please try again in few seconds"
                                           delegate:nil
                                  cancelButtonTitle:@"ok"
                                  otherButtonTitles:nil] show];
                [PfTableview reloadData];
            }
        }
        
    }];
    

}
-(void)likeService:(FeedCell3 *)cell forObject:(PFObject *)post in:(UITableView *)PfTableview for:(NSString *)view;
{
    
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.duration = 0.2;
    anim.repeatCount = 1;
    anim.autoreverses = YES;
    anim.removedOnCompletion = YES;
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)];
    [cell.likeButton.layer addAnimation:anim forKey:nil];
    
    NSArray *like=[post objectForKey:@"like" ];
    NSArray *unlike=[post objectForKey:@"unlike" ];
    NSMutableArray *allMyObjectsLike = [NSMutableArray arrayWithArray: like];
    NSMutableArray *allMyObjectsUnlike = [NSMutableArray arrayWithArray: unlike];
    
    if ([allMyObjectsLike containsObject:[[PFUser currentUser] objectId]]) {
        [allMyObjectsLike removeObject:[[PFUser currentUser] objectId]];
        [cell.likeButton setTitleColor:[UIColor asbestosColor] forState:UIControlStateNormal];
        
        
        int likePostCount=[[NSString stringWithFormat:@"%@",[post objectForKey:@"postcount"]] intValue]-1;
        if (likePostCount!=0) {
            cell.likeCountLabel.text=[[NSString stringWithFormat:@"%d",likePostCount] stringByAppendingString:@" Truth" ];
        }
        else
        {
            cell.likeCountLabel.text=@"";
        }
        
        [post setObject:[NSNumber numberWithInt:likePostCount] forKey:@"postcount"];
        [post  setObject:allMyObjectsLike forKey:@"like"];
    }
    else
    {
        
        if ([allMyObjectsUnlike containsObject:[[PFUser currentUser] objectId]]) {
            [allMyObjectsUnlike removeObject:[[PFUser currentUser] objectId]];
            [cell.unlikeButton setTitleColor:[UIColor asbestosColor] forState:UIControlStateNormal];
            
            int unlikePostCount=[[NSString stringWithFormat:@"%@",[post objectForKey:@"unpostcount"]] intValue]-1;
            if (unlikePostCount!=0) {
                cell.unlikeCountLable.text=[[NSString stringWithFormat:@"%d",unlikePostCount] stringByAppendingString:@" Flase" ];
            }
            else
            {
                cell.unlikeCountLable.text=@"";
            }
            
            [post setObject:[NSNumber numberWithInt:unlikePostCount] forKey:@"unpostcount"];
        }
        [cell.likeButton setTitleColor:[UIColor emerlandColor] forState:UIControlStateNormal];
        [allMyObjectsLike addObject:[[PFUser currentUser] objectId]];
        [post  setObject:allMyObjectsLike forKey:@"like"];
        [post  setObject:allMyObjectsUnlike forKey:@"unlike"];
        [post incrementKey:@"postcount"];
        
        
        int totalLike=[[NSString stringWithFormat:@"%@",[post objectForKey:@"postcount"]] intValue];
        if (totalLike!=0) {
            cell.likeCountLabel.text=[[NSString stringWithFormat:@"%d",totalLike] stringByAppendingString:@" Truth" ];
        }
        else
        {
            cell.likeCountLabel.text=@"";
        }
        
    }
    [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            // cell.likeButton.enabled=false;
            //cell.unlikeButton.enabled=true;
            //[self.tableView reloadData];
            
        }
        else{
            
            NSLog(@"%@",error.description);
            if (error.code==101) {
                [[[UIAlertView alloc] initWithTitle:@"Post Delted"
                                            message:@"Post Has Been Delted By the User"
                                           delegate:nil
                                  cancelButtonTitle:@"ok"
                                  otherButtonTitles:nil] show];
                //[self loadObjects];
                [PfTableview reloadData];
            }
            else
            {
                [[[UIAlertView alloc] initWithTitle:@"Network Issue"
                                            message:@"Please try again in few seconds"
                                           delegate:nil
                                  cancelButtonTitle:@"ok"
                                  otherButtonTitles:nil] show];
                
            }
        }
    }];

}


@end
