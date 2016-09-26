//
//  WHGroupUser.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 8/12/14.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface WHGroupUser : UITableViewController
@property (nonatomic, strong) PFObject *group;

@property (nonatomic, strong) NSArray *objects;

@end
