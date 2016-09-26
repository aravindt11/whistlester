//
//  SignUpViewController.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 9/9/14.
//
//

#import "WHSignUpViewController.h"
#import "UIColor+FlatUI.h"
#import "FUIButton.h"
#import "UIFont+FlatUI.h"
#import "WHNameAndPhotoControllerViewController.h"

@interface WHSignUpViewController ()

@end

@implementation WHSignUpViewController


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
    self.loginButton.buttonColor=[UIColor emerlandColor];
    self.loginButton.shadowColor = [UIColor nephritisColor];
    self.loginButton.shadowHeight = 3.0f;
    self.loginButton.cornerRadius = 6.0f;
    self.loginButton.titleLabel.font = [UIFont boldFlatFontOfSize:15];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    
    
    self.headerLable.font=[UIFont boldFlatFontOfSize:20];
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

- (IBAction)dismiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
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

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
}



- (IBAction)login:(id)sender {
    
    NSString *username=[self.email.text lowercaseString];
    BOOL flag=true;
    
    NSString *password=self.password.text;
    
    if (username && password && username.length != 0 && password.length != 0) {
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
        
        PFUser *newUser=[PFUser user];
      
        newUser.username=[self.email.text lowercaseString];
        newUser.password=self.password.text;
        newUser.email=[self.email.text lowercaseString];
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            
      
            if(!error)
            {
                PFInstallation *installation = [PFInstallation currentInstallation];
                installation[@"user"] = [PFUser currentUser];
                installation[@"user"] = [PFUser currentUser];
                NSArray *channel=[[NSArray alloc]init];
                 installation.channels=channel;
                [installation saveInBackground];

                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
                WHNameAndPhotoControllerViewController *myVC = (WHNameAndPhotoControllerViewController *)[storyboard instantiateViewControllerWithIdentifier:@"nameAndPhoto"];
                myVC.backGround=self.backGround;
                myVC.modalPresentationStyle=UIModalPresentationFullScreen;
                
                [self presentViewController:myVC animated:YES completion:nil];
                
                
                
            }
            else
            {
                NSLog(@"%@",error.description);
                [[[UIAlertView alloc] initWithTitle:@"Email already Taken"
                                            message:@"Please enter different Email ID"
                                           delegate:nil
                                  cancelButtonTitle:@"ok"
                                  otherButtonTitles:nil] show];
                
                
            }
            
        }];
    }
    
}



@end
