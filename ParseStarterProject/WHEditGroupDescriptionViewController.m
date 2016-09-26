//
//  WHEditGroupDescriptionViewController.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 9/7/14.
//
//

#import "WHEditGroupDescriptionViewController.h"

@interface WHEditGroupDescriptionViewController ()

@end

@implementation WHEditGroupDescriptionViewController
@synthesize group;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        [[UIApplication sharedApplication]  setStatusBarHidden:NO];
    [self.GroupDescription becomeFirstResponder];
    self.GroupDescription.text=[[group  objectForKey:@"groupdescription"]capitalizedString];
    
    if([[[group  objectForKey:@"admin"]objectForKey:@"nickname"] compare:[[PFUser currentUser] objectForKey:@"nickname"]]!=NSOrderedSame)
    {
        self.edit.enabled=false;
        self.GroupDescription.editable=false;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)edit:(id)sender {
    

    group[@"groupdescription"]=[self.GroupDescription.text capitalizedString];
    self.edit.enabled=false;
    [group saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [[[UIAlertView alloc] initWithTitle:@"Network Issue"
                                        message:@"Please try again in few seconds"
                                       delegate:nil
                              cancelButtonTitle:@"ok"
                              otherButtonTitles:nil] show];
        }
    }];
    
    }
@end
