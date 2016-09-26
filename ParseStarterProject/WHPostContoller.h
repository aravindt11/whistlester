//
//  WHPostContoller.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 3/12/14.
//
//

#import <UIKit/UIKit.h>
#import "WHMainTabController.h"

@interface WHPostContoller : UIViewController <UITextViewDelegate>
{
    NSInteger count;
    NSString *firstLeeter;
}
- (IBAction)storePost:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *post;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *postButton;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (nonatomic, strong) NSMutableArray *group;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) WHMainTabController *main;

@end
