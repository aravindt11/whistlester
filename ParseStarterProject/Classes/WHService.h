//
//  WHService.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 8/20/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "FeedCell3.h"
#import "UIColor+FlatUI.h"


@interface WHService : NSObject

-(FeedCell3 *)setData:(UITableViewCell *) cell forObject:(PFObject *)object for:(NSString *)view;
-(void)likeService:(UITableViewCell *) cell forObject:(PFObject *)post in:(UITableView *)tableview for:(NSString *)view;
-(void)DislikeService:(UITableViewCell *) cell forObject:(PFObject *)post in:(UITableView *)tableview for:(NSString *)view; 


@end
