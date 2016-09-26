//
//  WHLoginViewContoller.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 8/15/14.
//
///

#import "WHLoginViewContoller.h"
#import "UIColor+FlatUI.h"
#import "FUIButton.h"
#import "UIFont+FlatUI.h"
#import "AppDelegate.h"


@interface WHLoginViewContoller ()


@end

@implementation WHLoginViewContoller
@synthesize email,password;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.loginButton.buttonColor=[UIColor darkGrayColor];
    self.loginButton.shadowColor = [UIColor darkGrayColor];
    self.loginButton.shadowHeight = 3.0f;
    self.loginButton.cornerRadius = 6.0f;
    self.loginButton.titleLabel.font = [UIFont boldFlatFontOfSize:15];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    
    
    self.headerLable.font=[UIFont boldFlatFontOfSize:20];
    self.forgotPassword.titleLabel.font=[UIFont boldFlatFontOfSize:10];
    [ self.email setTextFieldColor:[UIColor clearColor]];
    //[ self.email setBorderColor:[UIColor whiteColor]];
    [ self.email setCornerRadius:10];
    
    [ self.email setFont:[UIFont flatFontOfSize:15]];
    [ self.email setTextColor:[UIColor whiteColor]];
    
    [ self.password setTextFieldColor:[UIColor clearColor]];
    [ self.password setCornerRadius:10];
    
    [ self.password setFont:[UIFont flatFontOfSize:15]];
    [ self.password setTextColor:[UIColor whiteColor]];
    self.password .secureTextEntry = YES;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    

   
    
  
    
        // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor clearColor];
    UIImageView* backView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backView.image = self.backGround;
    backView.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0.6];
    [self.view addSubview:backView];
    [self.view sendSubviewToBack: backView];
}
-(void)dismissKeyboard {
    
    [self.email resignFirstResponder];
    [self.password resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)validateEmail:(NSString *)inputText {
    NSString *emailRegex = @"[A-Z0-9a-z][A-Z0-9a-z._%+-]*@[A-Za-z0-9][A-Za-z0-9.-]*\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    NSRange aRange;
    if([emailTest evaluateWithObject:inputText]) {
        aRange = [inputText rangeOfString:@"." options:NSBackwardsSearch range:NSMakeRange(0, [inputText length])];
        int indexOfDot = aRange.location;
        //NSLog(@"aRange.location:%d - %d",aRange.location, indexOfDot);
        if(aRange.location != NSNotFound) {
            NSString *topLevelDomain = [inputText substringFromIndex:indexOfDot];
            topLevelDomain = [topLevelDomain lowercaseString];
            //NSLog(@"topleveldomains:%@",topLevelDomain);
            NSSet *TLD;
            TLD = [NSSet setWithObjects:@".aero", @".asia", @".biz", @".cat", @".com", @".coop", @".edu", @".gov", @".info", @".int", @".jobs", @".mil", @".mobi", @".museum", @".name", @".net", @".org", @".pro", @".tel", @".travel", @".ac", @".ad", @".ae", @".af", @".ag", @".ai", @".al", @".am", @".an", @".ao", @".aq", @".ar", @".as", @".at", @".au", @".aw", @".ax", @".az", @".ba", @".bb", @".bd", @".be", @".bf", @".bg", @".bh", @".bi", @".bj", @".bm", @".bn", @".bo", @".br", @".bs", @".bt", @".bv", @".bw", @".by", @".bz", @".ca", @".cc", @".cd", @".cf", @".cg", @".ch", @".ci", @".ck", @".cl", @".cm", @".cn", @".co", @".cr", @".cu", @".cv", @".cx", @".cy", @".cz", @".de", @".dj", @".dk", @".dm", @".do", @".dz", @".ec", @".ee", @".eg", @".er", @".es", @".et", @".eu", @".fi", @".fj", @".fk", @".fm", @".fo", @".fr", @".ga", @".gb", @".gd", @".ge", @".gf", @".gg", @".gh", @".gi", @".gl", @".gm", @".gn", @".gp", @".gq", @".gr", @".gs", @".gt", @".gu", @".gw", @".gy", @".hk", @".hm", @".hn", @".hr", @".ht", @".hu", @".id", @".ie", @" No", @".il", @".im", @".in", @".io", @".iq", @".ir", @".is", @".it", @".je", @".jm", @".jo", @".jp", @".ke", @".kg", @".kh", @".ki", @".km", @".kn", @".kp", @".kr", @".kw", @".ky", @".kz", @".la", @".lb", @".lc", @".li", @".lk", @".lr", @".ls", @".lt", @".lu", @".lv", @".ly", @".ma", @".mc", @".md", @".me", @".mg", @".mh", @".mk", @".ml", @".mm", @".mn", @".mo", @".mp", @".mq", @".mr", @".ms", @".mt", @".mu", @".mv", @".mw", @".mx", @".my", @".mz", @".na", @".nc", @".ne", @".nf", @".ng", @".ni", @".nl", @".no", @".np", @".nr", @".nu", @".nz", @".om", @".pa", @".pe", @".pf", @".pg", @".ph", @".pk", @".pl", @".pm", @".pn", @".pr", @".ps", @".pt", @".pw", @".py", @".qa", @".re", @".ro", @".rs", @".ru", @".rw", @".sa", @".sb", @".sc", @".sd", @".se", @".sg", @".sh", @".si", @".sj", @".sk", @".sl", @".sm", @".sn", @".so", @".sr", @".st", @".su", @".sv", @".sy", @".sz", @".tc", @".td", @".tf", @".tg", @".th", @".tj", @".tk", @".tl", @".tm", @".tn", @".to", @".tp", @".tr", @".tt", @".tv", @".tw", @".tz", @".ua", @".ug", @".uk", @".us", @".uy", @".uz", @".va", @".vc", @".ve", @".vg", @".vi", @".vn", @".vu", @".wf", @".ws", @".ye", @".yt", @".za", @".zm", @".zw", nil];
            if(topLevelDomain != nil && ([TLD containsObject:topLevelDomain])) {
                //NSLog(@"TLD contains topLevelDomain:%@",topLevelDomain);
                return TRUE;
            }
            /*else {
             NSLog(@"TLD DOEST NOT contains topLevelDomain:%@",topLevelDomain);
             }*/
            
        }
    }
    return FALSE;
}




- (IBAction)login:(id)sender {
    
    NSString *username=[self.email.text lowercaseString];
    BOOL flag=true;
    
     NSString *passwordGot=self.password.text ;
    
    if (username && passwordGot && username.length != 0 && passwordGot.length != 0) {
        //Check email valiation
        if ([self validateEmail:username]) {
            
            
        }
        else
        {
            flag=false;
            [[[UIAlertView alloc] initWithTitle:@"Email Not Valid"
                                        message:@"Please Enter Correct Email Address!"
                                       delegate:nil
                              cancelButtonTitle:@"ok"
                              otherButtonTitles:nil] show];
                }
        
        // Begin login process
    }
    else
    {
        flag=false;
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
        // Interrupt login process
    }
    if (flag) {
        
    
    
    
    [PFUser logInWithUsernameInBackground:[self.email.text lowercaseString] password:self.password.text block:^(PFUser *user, NSError *error) {
        if(!error)
        {
            
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
            WHMainTabController *myVC = (WHMainTabController *)[storyboard instantiateViewControllerWithIdentifier:@"nickName"];
            
           
           
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
           
            appDelegate.tabBarController=myVC;
            [self dismissKeyboard];
            
          [[[[UIApplication sharedApplication] delegate] window] setRootViewController:myVC];
            [self dismissViewControllerAnimated:YES completion:nil];
            //[self presentViewController:myVC animated:YES completion:nil];
            
            
            
            PFInstallation *installation = [PFInstallation currentInstallation];
            installation[@"user"] = [PFUser currentUser];
            __block NSArray *channel=[[NSArray alloc]init];
            PFQuery *query = [PFQuery queryWithClassName:@"group"];
            [query whereKey:@"member" equalTo:[PFUser currentUser]];
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                for (PFObject *object in objects) {
                    
                   channel= [ channel arrayByAddingObject:[@"group_" stringByAppendingString:[object objectId] ]];
                    [installation addUniqueObject:[@"group_" stringByAppendingString:[object objectId] ]forKey:@"channels"];
                    
                }
                installation.channels=channel;
                [installation saveInBackground];
            } ];


        }
        else
        {
            NSLog(@"%@",error.description);
            [[[UIAlertView alloc] initWithTitle:@"Invalid User Name And Password"
                                        message:@"Make sure you fill out all of the correctly!"
                                       delegate:self
                              cancelButtonTitle:@"ok"
                              otherButtonTitles:@"Forgot Password ?",nil] show];

            
        }
        
    }];
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Forgot Password ?"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Password Reset"
                                                            message:@"Enter a email for password reset."
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Reset", nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        
        UITextField* textfield = [alertView textFieldAtIndex:0];
        textfield.placeholder = @"Email";
        
        [alertView show];
        
       
    }
     if([title isEqualToString:@"Reset"])
     {
         
         [PFUser requestPasswordResetForEmail:[[alertView textFieldAtIndex:0].text lowercaseString] ];
         
         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Password Reset"
                                                             message:@"Please check your email for password reset instruction."
                                                            delegate:self
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
         
         [alertView show];


     }
    
}

- (IBAction)dismiss:(id)sender {
    
[self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)passwordReset:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Password Reset"
                                                        message:@"Enter a email for password reset."
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Reset", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    UITextField* textfield = [alertView textFieldAtIndex:0];
    textfield.placeholder = @"Email";
    
    [alertView show];

    
}
@end
