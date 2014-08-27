//
//  XmppClass.h
//  MyTaxi-V1.0.1
//
//  Created by Charles Leo  on 14-5-12.
//  Copyright (c) 2014年 YaHuiLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"
#define tag_subcribe_alertView 100
@class XmppClass;
@protocol XmppClassDelegate <NSObject>
@optional
-(void)friendStatusChange:(XmppClass *)xmppClass Presence:(XMPPPresence *)presence;
-(void)xmppClassOrderInfo:(XmppClass *)xmppClass Message:(XMPPMessage *)message;
-(void)xmppClassPresentNotificationView:(XmppClass *)xmppClass Message:(XMPPMessage *)message;
-(void)connectOpenFireAgain:(XmppClass *)xmppClass;
-(void)didFinishedSend:(XmppClass *)xmppClass;
-(void)didFailedSend:(XmppClass *)xmppClass;
@end
@interface XmppClass : UIViewController <XMPPRosterDelegate,UIAlertViewDelegate>
{
    Class orginClass;
    XMPPStream *xmppStream;
    XMPPRoster *xmppRoster;
    XMPPRosterCoreDataStorage *xmppRosterStorage;
    XMPPReconnect *xmppReconnect;
    XMPPMessageArchivingCoreDataStorage *xmppMessageArchivingCoreDataStorage;
    XMPPMessageArchiving *xmppMessageArchivingModule;
    NSDictionary *dict;
}
@property (nonatomic, strong) XMPPStream *xmppStream;
@property (nonatomic, strong) XMPPRosterCoreDataStorage *xmppRosterStorage;
@property (nonatomic, strong) XMPPRoster *xmppRoster;
@property (nonatomic, strong) XMPPReconnect *xmppReconnect;
@property (nonatomic, strong) XMPPMessageArchivingCoreDataStorage *xmppMessageArchivingCoreDataStorage;
@property (nonatomic, strong) XMPPMessageArchiving *xmppMessageArchivingModule;
@property (nonatomic,strong) XMPPUserCoreDataStorageObject *xmppUserObject;
@property (strong,nonatomic) XMPPMessage * myNewMessage;

- (BOOL)myConnect;
- (id)initWithDelegate:(id)delegate;
@property (nonatomic,assign) id<XmppClassDelegate> mDelegate;
@end


