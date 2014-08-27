//
//  LYHAppDelegate.h
//  WeChatXmpp
//
//  Created by Charles Leo on 14-8-15.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XmppClass.h"
@interface LYHAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController * mTabbarCtrl;
@property (strong, nonatomic) XmppClass * mXmppClass;
@end
