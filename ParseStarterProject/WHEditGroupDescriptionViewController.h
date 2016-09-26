//
//  WHEditGroupDescriptionViewController.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 9/7/14.
//
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

@interface WHEditGroupDescriptionViewController : UIViewController <UITextViewDelegate>
- (IBAction)edit:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *edit;
@property (weak, nonatomic) IBOutlet UITextView *GroupDescription;
@property (nonatomic, strong) PFObject *group;
@end
