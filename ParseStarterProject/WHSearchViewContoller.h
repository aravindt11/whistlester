//
//  WHSearchViewContoller.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 3/5/14.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "MBProgressHUD.h"

@interface WHSearchViewContoller : PFQueryTableViewController<UITextFieldDelegate,UINavigationControllerDelegate,MBProgressHUDDelegate,UISearchBarDelegate>

 @property (nonatomic, strong) NSMutableArray *searchResults;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBars;
@property (strong, nonatomic) IBOutlet NSString *searchText;
@property (nonatomic, strong) MBProgressHUD *HUD;

@end
