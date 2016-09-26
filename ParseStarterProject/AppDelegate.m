#import <Parse/Parse.h>
#import "AppDelegate.h"

#import "WHCommentViewController.h"
#import "WHNotificationTableViewController.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "WHMainTabController.h"


@implementation AppDelegate


#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    // ****************************************************************************
    // Uncomment and fill in with your Parse credentials:
     [Parse setApplicationId:@"rFfJ9dEGhdLNOgN1U3W2vgNNCgP9p4ezk5KW6LTY" clientKey:@"l3ElDJu9UWVqvKuPJImfyxA0DcREttklRLIq2b4w"];
    //
    // If you are using Facebook, uncomment and add your FacebookAppID to your bundle's plist as
    // described here: https://developers.facebook.com/docs/getting-started/facebook-sdk-for-ios/
    // [PFFacebookUtils initializeFacebook];
    // ****************************************************************************

   // [PFUser enableAutomaticUser];
    
    PFACL *defaultACL = [PFACL ACL];

    // If you would like all objects to be private by default, remove this line.
    [defaultACL setPublicReadAccess:YES];
    [defaultACL setPublicWriteAccess:YES];
    
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    [application setStatusBarHidden:NO];
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
   
       NSString *currentVersion=[NSString stringWithFormat:@"Version %@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    
    __block bool isOldVersion=true;
    
    PFQuery *query=[PFQuery queryWithClassName:@"version"];
    NSArray *objects=[query findObjects];
    for (PFObject *object in objects ) {
       NSString *version
        = [object objectForKey:@"latestersion"];
       
        if ([currentVersion isEqualToString:version] || [@"free" isEqualToString:version])
        {
            isOldVersion=false;
            
        }
    }
    if (isOldVersion) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        UIViewController *mainViewContoller = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"version"];
        
        
        self.window.backgroundColor=[UIColor clearColor];
        self.window.rootViewController = mainViewContoller;
        [self.window makeKeyAndVisible];


        
        [[[UIAlertView alloc] initWithTitle:@"New version Avaliable"
                                    message:@"We have a new version in app store. please update to use new cool features."
                                   delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"Update", nil] show];
        
        
        return YES;
    
    }
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont boldFlatFontOfSize:15]
       }forState:UIControlStateNormal];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor asbestosColor],
       NSFontAttributeName:[UIFont boldFlatFontOfSize:15]
       }forState:UIControlStateDisabled];

    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    UIViewController *mainViewContoller = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"welcomeView"];
    self.window.backgroundColor=[UIColor clearColor];
    self.window.rootViewController = mainViewContoller;
    [self.window makeKeyAndVisible];
  
    
    
    
    
    
    if (application.applicationState != UIApplicationStateBackground) {
        // Track an app open here if we launch with a push, unless
        // "content_available" was used to trigger a background push (introduced
        // in iOS 7). In that case, we skip tracking here to avoid double
        // counting the app-open.
        BOOL preBackgroundPush = ![application respondsToSelector:@selector(backgroundRefreshStatus)];
        BOOL oldPushHandlerOnly = ![application respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)];
        BOOL noPushPayload = ![launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        
        if (preBackgroundPush || oldPushHandlerOnly || noPushPayload) {
            [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
        }
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }

  
    [self handlePush:launchOptions application:application];

    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"Update"])
    {
        
        [[[UIAlertView alloc] initWithTitle:@"New version Avaliable"
                                    message:@"We have a new version in app store. please update to use new cool features"
                                   delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"Update", nil] show];
        
          [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://whistle-ster.com/download.html"]];
        
    }
}

-(void)handlePush:(NSDictionary *)launchOptions application:(UIApplication *)application  {
    
    // If the app was launched in response to a push notification, we'll handle the payload here
    NSDictionary *remoteNotificationPayload = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (remoteNotificationPayload) {
    
        
        if (![PFUser currentUser]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Please Login" delegate:self cancelButtonTitle:@"Login" otherButtonTitles:@"Cancel", nil];
            [alert show];
            return;
        }
        
        // If the push notification payload references a photo, we will attempt to push this view controller into view
      
        NSString *photoObjectId = [remoteNotificationPayload objectForKey:@"post"];
        if (photoObjectId && photoObjectId.length > 0) {
            
            
            
            
           
            
            if (application.applicationIconBadgeNumber != 0) {
            application.applicationIconBadgeNumber = 0;
                [PFInstallation currentInstallation].badge = 0;
                [[PFInstallation currentInstallation] saveInBackground];
            }
            
            
            
            [[UIApplication sharedApplication] cancelAllLocalNotifications];
           
            
 self.tabBarController.selectedViewController = self.tabBarController.viewControllers[2];
            
                    
            

                }
        else
        {
            
            if (application.applicationIconBadgeNumber != 0) {
                application.applicationIconBadgeNumber = 0;
                [PFInstallation currentInstallation].badge = 0;
                [[PFInstallation currentInstallation] saveInBackground];
            }
            
            
            
            [[UIApplication sharedApplication] cancelAllLocalNotifications];
            
            
            self.tabBarController.selectedViewController = self.tabBarController.viewControllers[1];
        }
            

            
          
            
        
            return;
        }
        
    
        
    }



- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:newDeviceToken];
    [currentInstallation saveInBackground];

    [PFPush subscribeToChannelInBackground:@"" target:self selector:@selector(subscribeFinished:error:)];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (error.code == 3010) {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    } else {
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
	}
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
       //[PFPush handlePush:userInfo];

    if (application.applicationState == UIApplicationStateInactive) {
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
   
    
   
        
    
        
        if (![PFUser currentUser]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wait" message:@"Please Login" delegate:self cancelButtonTitle:@"Login" otherButtonTitles:@"Cancel", nil];
            [alert show];
            return;
        }
        
    
    
        NSString *photoObjectId = [userInfo objectForKey:@"post"];
   
    if (photoObjectId && photoObjectId.length > 0) {
        
        
        NSLog(@"hi");
        
      
       
         if ([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive ) {
             
             [self.tabBarController.navigationController popToRootViewControllerAnimated:NO];
       NSLog(@"hay dude antony %ld",(long)application.applicationIconBadgeNumber);
        
        if (application.applicationIconBadgeNumber != 0) {
            application.applicationIconBadgeNumber = 0;
            
            [PFInstallation currentInstallation].badge = 0;
            
            [[PFInstallation currentInstallation] saveInBackground];
        }
        
        // Clears out all notifications from Notification Center.
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
   
        [[self.tabBarController.viewControllers objectAtIndex:3] tabBarItem].badgeValue= nil;
             self.tabBarController.selectedViewController = self.tabBarController.viewControllers[3];
         }
        else
        {
            application.applicationIconBadgeNumber=application.applicationIconBadgeNumber+1;
            [PFInstallation currentInstallation].badge = application.applicationIconBadgeNumber;
            NSLog(@"%@",[PFInstallation currentInstallation].description);
            
           [ [PFInstallation currentInstallation] setBadge: application.applicationIconBadgeNumber];

            [[PFInstallation currentInstallation] saveInBackground];
            
            NSLog(@"%ld",(long)application.applicationIconBadgeNumber);
            
            [[self.tabBarController.viewControllers objectAtIndex:3] tabBarItem].badgeValue= [NSString stringWithFormat:@"%ld",(long)[UIApplication sharedApplication].applicationIconBadgeNumber];
            
        }
        
        
        
    }
    

    if (application.applicationState == UIApplicationStateInactive) {
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

    
    - (void)applicationDidBecomeActive:(UIApplication *)application {
     
        if (application.applicationIconBadgeNumber != 0) {
        [[self.tabBarController.viewControllers objectAtIndex:3] tabBarItem].badgeValue= [NSString stringWithFormat:@"%ld",(long)[UIApplication sharedApplication].applicationIconBadgeNumber];

         
        }
       
        
        
    }


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark - ()

- (void)subscribeFinished:(NSNumber *)result error:(NSError *)error {
    if ([result boolValue]) {
        NSLog(@"ParseStarterProject successfully subscribed to push notifications on the broadcast channel.");
    } else {
        NSLog(@"ParseStarterProject failed to subscribe to push notifications on the broadcast channel.");
    }
}


@end
