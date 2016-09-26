//
//  WHWelcomeViewController.h
//  whistlester
//
//  Created by Aravind Thiyagarajan on 9/7/14.
//
//

#import <UIKit/UIKit.h>
#import "FUIButton.h"

@interface WHWelcomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet FUIButton *login;
@property (weak, nonatomic) IBOutlet FUIButton *signup;
@property (weak, nonatomic) IBOutlet UIImageView *BackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *logoName;
@property (weak, nonatomic) IBOutlet UILabel *compInfo;


@end
