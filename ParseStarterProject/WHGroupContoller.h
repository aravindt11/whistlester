//
//  groupContoller.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 2/26/14.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface WHGroupContoller : PFQueryTableViewController<UITextFieldDelegate,UINavigationControllerDelegate,UISearchDisplayDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIView *GroupLogo;



@end
