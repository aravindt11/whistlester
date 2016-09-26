//
//  mainTabController.m
//  whistlester
//
//  Created by Aravind Thiyagarajan on 2/26/14.
//
//

#import "WHMainTabController.h"
#import "UIColor+FlatUI.h"
#import "MZFormSheetController.h"
#import "WHPopUpController.h"
#import "WHSearchViewContoller.h"

@interface WHMainTabController ()<MZFormSheetBackgroundWindowDelegate>

@end

@implementation WHMainTabController

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    [[MZFormSheetBackgroundWindow appearance] setBackgroundBlurEffect:YES];
    [[MZFormSheetBackgroundWindow appearance] setBlurRadius:5.0];
    [[MZFormSheetBackgroundWindow appearance] setBackgroundColor:[UIColor clearColor]];
    
    UITabBarItem *tabBarItem4=[self.tabBar.items objectAtIndex:4];
    tabBarItem4.selectedImage=[[UIImage imageNamed:@"user_2f.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
     UITabBarItem *tabBarItem1=[self.tabBar.items objectAtIndex:1];
    tabBarItem1.selectedImage=[[UIImage imageNamed:@"users_three_2f.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UITabBarItem *tabBarItem3=[self.tabBar.items objectAtIndex:3];
    tabBarItem3.selectedImage=[[UIImage imageNamed:@"alarmf.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    
    UITabBarItem *tabBarItem0=[self.tabBar.items objectAtIndex:0];
    tabBarItem0.selectedImage=[[UIImage imageNamed:@"bullet_listf.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];


    self.tabBarController.tabBar.barTintColor = [UIColor cloudsColor];
    
    // Set the selected icons and text tint color
    self.tabBarController.tabBar.tintColor = [UIColor belizeHoleColor ];
    
   
    
    
           return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeSystem];
    
    [btn setFrame:CGRectMake(self.tabBar.frame.size.width/2-35,self.tabBar.frame.origin.y-22,70, 70)];
    
    
    btn.backgroundColor=[UIColor peterRiverColor];
    
    
    
    
    btn.clipsToBounds = YES;
    btn.tag=4;
    
    //btn.restorationIdentifier=@"CenterButton";
    btn.layer.cornerRadius = btn.bounds.size.width / 2.0;
    btn.layer.borderWidth = 2.0f;
    btn.layer.borderColor = [[UIColor cloudsColor]CGColor];
    
    
    btn.autoresizingMask=(UIViewAutoresizingFlexibleWidth |
                          UIViewAutoresizingFlexibleTopMargin);
    btn.alpha = 1.0;
    [self.view  addSubview:btn];
    self.centerButton=btn;
    
    
    

   
 
    
	// Do any additional setup after loading the view.
}



-(IBAction)post1:(id)sender
{
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    WHPopUpController *myVC = (WHPopUpController *)[storyboard instantiateViewControllerWithIdentifier:@"PopUpController"];
    
       
    MZFormSheetController *formSheet = [[MZFormSheetController alloc] initWithViewController:myVC];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    NSLog(@"%f",screenHeight);
    
    [formSheet setPresentedFormSheetSize:CGSizeMake(screenWidth,screenHeight-(screenHeight/3.5))];
    
    
    formSheet.shouldDismissOnBackgroundViewTap = YES;
      formSheet.movementWhenKeyboardAppears = MZFormSheetWhenKeyboardAppearsCenterVertically;
   // self.showStatusBar = YES;
    [UIView animateWithDuration:0.3 animations:^{
        [self.navigationController.formSheetController setNeedsStatusBarAppearanceUpdate];
    }];
    [formSheet presentAnimated:YES completionHandler:^(UIViewController *presentedFSViewController) {
        
    }];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
