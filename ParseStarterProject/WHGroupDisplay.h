//
//  WHGroupDisplay.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 2/28/14.
//
//

#import <UIKit/UIKit.h>
#import "FUIButton.h"

@interface WHGroupDisplay : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView* groupLogo;

@property (weak, nonatomic) IBOutlet UILabel *groupName;
@property (weak, nonatomic) IBOutlet UILabel *admin;
@property (weak, nonatomic) IBOutlet FUIButton *removeUser;

@property (weak, nonatomic) IBOutlet UILabel *members;
@property (weak, nonatomic) IBOutlet UIButton *post;
@property (weak, nonatomic) IBOutlet UIButton *join;
@property (weak, nonatomic) IBOutlet UILabel *closed;
@property (weak, nonatomic) IBOutlet UITextField *comment;

@end
