//
//  WHLikeorDislike.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 6/28/14.
//
//




#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "FeedCell3.h"

@interface WHLikeorDislike : PFQueryTableViewController <UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) PFObject *postGotNew;
@property (nonatomic,strong) NSString  *flag;

@end
