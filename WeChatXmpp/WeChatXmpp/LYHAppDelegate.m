//
//  LYHAppDelegate.m
//  WeChatXmpp
//
//  Created by Charles Leo on 14-8-15.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import "LYHAppDelegate.h"
#import "LYHRootViewController.h"
#import "LYHNavigationController.h"
#import "MineViewController.h"
#import "FriendListViewController.h"
#import "DiscoverViewController.h"
#import "MessageLIstViewController.h"
#import "LYHBarButtonItem.h"
@implementation LYHAppDelegate


- (void)makeTabbarView
{
    MessageLIstViewController * messageView = [[MessageLIstViewController alloc]init];
    LYHNavigationController * messageNavCtrl = [[LYHNavigationController alloc]initWithRootViewController:messageView];
    messageView.title = @"微信";
    LYHBarButtonItem * messageBar = [[LYHBarButtonItem alloc]initWithTitle:@"更多" image:[UIImage imageNamed:@"tabbar_mainframe"] tag:4];
    messageView.tabBarItem = messageBar;
    
    
    
    FriendListViewController * friendView = [[FriendListViewController alloc]init];
    LYHNavigationController * friendNavCtrl = [[LYHNavigationController alloc]initWithRootViewController:friendView];
    friendView.title = @"通讯录";
    LYHBarButtonItem * friendBar = [[LYHBarButtonItem alloc]initWithTitle:@"通讯录" image:[UIImage imageNamed:@"tabbar_contacts"] tag:4];
    friendView.tabBarItem = friendBar;
    
    DiscoverViewController * discoverView = [[DiscoverViewController alloc]init];
    LYHNavigationController * discoverNavCtrl = [[LYHNavigationController alloc]initWithRootViewController:discoverView];
    discoverView.title = @"发现";
    LYHBarButtonItem * discoverBar = [[LYHBarButtonItem alloc]initWithTitle:@"发现" image:[UIImage imageNamed:@"tabbar_discover"] tag:4];
    discoverView.tabBarItem = discoverBar;
    
    MineViewController * mineView= [[MineViewController alloc]init];
    LYHNavigationController * mineNavCtrl = [[LYHNavigationController alloc]initWithRootViewController:mineView];
    mineView.title = @"我";
    LYHBarButtonItem * mineBar = [[LYHBarButtonItem alloc]initWithTitle:@"我" image:[UIImage imageNamed:@"tabbar_me"] tag:4];
    mineView.tabBarItem = mineBar;

    
    
    NSArray * array = [NSArray arrayWithObjects:messageNavCtrl,friendNavCtrl,discoverNavCtrl,mineNavCtrl,nil];
    UITabBarController * barCtrl = [[UITabBarController alloc]init];
    barCtrl.viewControllers = array;
    barCtrl.selectedIndex = 0;
    barCtrl.tabBar.selectedImageTintColor = [UIColor whiteColor];
    [barCtrl.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbarBkg"]];
    self.window.rootViewController = barCtrl;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self makeTabbarView];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
