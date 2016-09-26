@class WHStartViewController;
#import "WHMainTabController.h"
#import "WHNewsFeedController.h"

@interface AppDelegate : NSObject <UIApplicationDelegate ,UITabBarControllerDelegate> {

}

@property (nonatomic, strong) IBOutlet UIWindow *window;

@property (nonatomic, strong) IBOutlet WHStartViewController *viewController;

@property (nonatomic, strong) WHMainTabController *tabBarController;
@property (nonatomic, strong) WHNewsFeedController *navController;

@end
