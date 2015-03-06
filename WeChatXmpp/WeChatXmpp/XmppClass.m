//
//  XmppClass.m
//  MyTaxi-V1.0.1
//
//  Created by Charles Leo  on 14-5-12.
//  Copyright (c) 2014年 YaHuiLiu. All rights reserved.
//

#import "XmppClass.h"
#import "LYHAppDelegate.h"

Class object_getClass(id object);
@implementation XmppClass

@synthesize xmppUserObject;
@synthesize xmppStream;
@synthesize xmppRoster;
@synthesize xmppRosterStorage;
@synthesize mDelegate;                           //聊天代理
@synthesize xmppReconnect;
@synthesize xmppMessageArchivingCoreDataStorage;
@synthesize xmppMessageArchivingModule;
@synthesize myNewMessage;                           //是否是新消息

- (id)initWithDelegate:(id)delegate
{
    if (self = [super init])
    {   orginClass = object_getClass(delegate);
        self.mDelegate = delegate;
        [self setupStream];
    }
    return self;
}
-(LYHAppDelegate *)appDelegate
{
    LYHAppDelegate * appDelegate =(LYHAppDelegate *)[UIApplication sharedApplication].delegate;
    return appDelegate;
}
#pragma mark - 发送本地通知的方法

-(void)sendLocalNotification:(NSString *)messageBody
{
    UIApplication * app = [UIApplication sharedApplication];
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.alertAction = @"Ok";
    localNotification.soundName = @"crunch.wav";
    app.applicationIconBadgeNumber += 1;
    localNotification.alertBody = messageBody;
    [app scheduleLocalNotification:localNotification];
   
}
#pragma mark - XMPP的一系列方法
//初始化XMPP
- (void)setupStream
{
    xmppStream = [[XMPPStream alloc]init];
    //允许后台运行
    xmppStream.enableBackgroundingOnSocket = YES;
    [xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    xmppReconnect = [[XMPPReconnect alloc]init];
    [xmppReconnect activate:self.xmppStream];
    xmppRosterStorage = [[XMPPRosterCoreDataStorage alloc]init];
    xmppRoster = [[XMPPRoster alloc]initWithRosterStorage:xmppRosterStorage];
    [xmppRoster activate:self.xmppStream];
    [xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];
    xmppMessageArchivingCoreDataStorage = [XMPPMessageArchivingCoreDataStorage sharedInstance];
    xmppMessageArchivingModule = [[XMPPMessageArchiving alloc]initWithMessageArchivingStorage:xmppMessageArchivingCoreDataStorage];
    [xmppMessageArchivingModule setClientSideMessageArchivingOnly:YES];
    [xmppMessageArchivingModule activate:xmppStream];
    [xmppMessageArchivingModule addDelegate:self delegateQueue:dispatch_get_main_queue()];
}
//XMPP连接的方法
- (BOOL)myConnect
{
    if (xmppStream.isConnected)
    {
        NSLog(@"已经连接了XMPP");
        return NO;
    }
    NSString *jid = [[NSUserDefaults standardUserDefaults]objectForKey:kMyJID];
    NSString *ps = [[NSUserDefaults standardUserDefaults]objectForKey:kPS];
    NSLog(@"用户XMPPJID is %@ 密码 is %@",jid ,ps);
    if (jid == nil || ps == nil) {
        return NO;
    }
    XMPPJID *myjid = [XMPPJID jidWithString:[[NSUserDefaults standardUserDefaults]objectForKey:kMyJID]];
    NSLog(@"my jid is %@",myjid);
    NSError *error ;
    [xmppStream setMyJID:myjid];
    [xmppStream setHostName:XMPPHOST];
    [xmppStream setHostPort:[XMPPPORT integerValue]];
    if (![xmppStream connectWithTimeout:30 error:&error]) {
        NSLog(@"连接错误 : %@",error.description);
        return NO;
    }
    return YES;
}

#pragma mark - XMPPStreamDelegate
#pragma mark - XMPP开始连接
- (void)xmppStreamWillConnect:(XMPPStream *)sender
{
    NSLog(@"xmppStreamWillConnect");
}
#pragma mark - XMPP已经连接
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    if ([[NSUserDefaults standardUserDefaults]objectForKey:kPS])
    {
        NSError *error ;
        if (![xmppStream authenticateWithPassword:[[NSUserDefaults standardUserDefaults]objectForKey:kPS] error:&error])
        {
            NSLog(@"error authenticate : %@",error.description);
        }
        NSLog(@"xmppStreamDidConnect");
    }
}
#pragma mark - 注册成功
- (void)xmppStreamDidRegister:(XMPPStream *)sender
{
    NSLog(@"xmppStreamDidRegister");
    if ([[NSUserDefaults standardUserDefaults]objectForKey:kPS]) {
        NSError *error ;
        if (![xmppStream authenticateWithPassword:[[NSUserDefaults standardUserDefaults]objectForKey:kPS] error:&error]) {
            NSLog(@"error authenticate : %@",error.description);
        }
    }
}
#pragma mark - 注册失败
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(NSXMLElement *)error
{
   // [[iToast makeText:@"当前用户已存在"]show];
}
#pragma mark - XMPP验证成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"xmppStreamDidAuthenticate");
    XMPPPresence *presence = [XMPPPresence presence];
	[[self xmppStream] sendElement:presence];
    //[[iToast makeText:@"您已上线"]show];
}
#pragma mark - XMPP验证失败
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(NSXMLElement *)error
{
   // [[iToast makeText:@"连接中"]show];
//    [self.mDelegate connectOpenFireAgain:self];
    NSLog(@"didNotAuthenticate:%@",error.description);
}
#pragma mark - 交换冲突资源
- (NSString *)xmppStream:(XMPPStream *)sender alternativeResourceForConflictingResource:(NSString *)conflictingResource
{
    NSLog(@"alternativeResourceForConflictingResource: %@",conflictingResource);
    return @"XMPPIOS";
}
#pragma mark收到IQ包
- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
    NSLog(@"didReceiveIQ: %@",iq.description);
    return NO;
}
- (NSManagedObjectContext *)managedObjectContext_roster
{
	return [xmppRosterStorage mainThreadManagedObjectContext];
}
#pragma mark - 收到新消息
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    XMPPUserCoreDataStorageObject *user = [xmppRosterStorage userForJID:[message from]
                                                             xmppStream:xmppStream
                                                   managedObjectContext:[self managedObjectContext_roster]];
    NSLog(@"user is %@",user);
    //每次收到新消息第一时间赋给self的myNewMessage对象,便于其与后面界面进行数据交互
    self.myNewMessage = message;
    //紧接着,将新消息赋给AppDelegate的newMessage对象,便于AppDelegate里面收到本地通知的时候进行消息处理(此处似乎有些多余待商榷).
    //[self appDelegate].myNewMessage = self.myNewMessage;
    NSLog(@"message is %@",message);
    /*
     *收到新消息,进行消息回执
    */
    NSXMLElement *request = [message elementForName:@"request"];
    NSLog(@"request is %@",request);
    if (request)
    {
        if ([request.xmlns isEqualToString:@"urn:xmpp:receipts"])//消息回执
        {
            //组装消息回执
            XMPPMessage *msg = [XMPPMessage messageWithType:[message attributeStringValueForName:@"type"] to:message.from elementID:@""];
            NSXMLElement *recieved = [NSXMLElement elementWithName:@"received" xmlns:@"urn:xmpp:receipts"];
            //添加一个叫做id的属性
            [recieved addAttributeWithName:@"id" stringValue:[message attributeStringValueForName:@"id"]];
            [msg addChild:recieved];
            //发送回执
            [self.xmppStream sendElement:msg];
             NSLog(@"msg is %@",msg);
        }
    }
    else
    {
        NSXMLElement *received = [message elementForName:@"received"];
        NSLog(@"received is %@",received);
        if (received)
        {
            if ([received.xmlns isEqualToString:@"urn:xmpp:receipts"])//消息回执
            {
                //发送成功
                NSLog(@"message send success!");
            }
        }
    }
    dict = [message.body JSONValue];
    if (nil == dict)
    {
        return;
    }
    NSString *msgid = [dict objectForKey:@"msgid"];
    NSLog(@"msgid is %@",msgid);

    if([msgid intValue] == 1)//订单抢单成功
    {
        NSDictionary * resultDict = [dict objectForKey:@"result"];
        NSString * info  = @"招车成功";
        /*
         招车成功后更新存在本地的当前订单编号
         */
        NSUserDefaults * userDef = [NSUserDefaults standardUserDefaults];
        [userDef setObject:[NSString stringWithFormat:@"%@",[resultDict objectForKey:@"orderid"]] forKey:@"currentorder"];
        [userDef synchronize];
        //抢单成功,上传用户位置
        
        if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive)
        {
            /*
             由于等待上车的界面是不允许返回的,故此处不需要弹出消息框.如果用户将程序切换到后台,
             那么通过本地通知,通知到AppDelegate接收本地通知,接收到本地通知后,程序处于活跃状态,
             通过AppDelegate的代理方法将招车成功的消息传递给等待上车界面
             */
            if ([self.mDelegate respondsToSelector:@selector(xmppClassOrderInfo:Message:)])
            {
                [self.mDelegate xmppClassOrderInfo:self Message:message];
            }
        }
        else
        {
            [self sendLocalNotification:info];
        }
    }
    if([msgid intValue] == 2)   //招车失败
    {
        if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive)
        {
            if ([self.mDelegate respondsToSelector:@selector(xmppClassOrderInfo:Message:)])
            {
                [self.mDelegate xmppClassOrderInfo:self Message:message];
            }
        }
        else
        {
            [self sendLocalNotification:@"招车失败"];
        }
    }
    if([msgid intValue] == 3)   //司机取消订单
    {
        if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive)
        {
           // [self showMessageWithTitle:SYSTEMTIP andMessage:@"司机取消订单" andCancelTitle:nil andOtherButton:@"知道了" andTag:802];
        }
        else
        {
            [self sendLocalNotification:@"司机取消订单"];
        }
    }
}

#pragma mark - 发送消息成功
- (void)xmppStream:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message
{
    if ([self.mDelegate respondsToSelector:@selector(didFinishedSend:)])
    {
        [self.mDelegate didFinishedSend:self];
    }
}

#pragma mark - 收到错误消息
- (void)xmppStream:(XMPPStream *)sender didReceiveError:(NSXMLElement *)error
{
    NSLog(@"didReceiveError: %@",error.description);
    DDXMLNode *errorNode = (DDXMLNode *)error;
    //遍历错误节点
    for(DDXMLNode *node in [errorNode children])
    {
        //若错误节点有【冲突】
        if([[node name] isEqualToString:@"conflict"])
        {
            //弹出登陆冲突,点击OK后logout
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"系统提示" message:@"您已在另一台设备上登录," delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 9999;
            alert.delegate = self;
            [alert show];
        }
    }
    //[xmppStream disconnect];
}

#pragma mark - 发送消息失败
- (void)xmppStream:(XMPPStream *)sender didFailToSendMessage:(XMPPMessage *)message error:(NSError *)error
{
    NSLog(@"didFailToSendMessage:%@",error.description);
    if ([self.mDelegate respondsToSelector:@selector(didFailedSend:)])
    {
        [self.mDelegate didFailedSend:self];
    }
}

#pragma mark - 发送IQ包成功
- (void)xmppStream:(XMPPStream *)sender didSendIQ:(XMPPIQ *)iq
{
    NSLog(@"didSendIQ:%@",iq.description);
}
#pragma mark - 发送IQ包失败
- (void)xmppStream:(XMPPStream *)sender didFailToSendIQ:(XMPPIQ *)iq error:(NSError *)error
{
    NSLog(@"didFailToSendIQ:%@",error.description);
}
#pragma mark - 收到Presence
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
    NSLog(@"didReceivePresence: %@",presence.description);
    if (presence.status) {
        if ([self.mDelegate respondsToSelector:@selector(friendStatusChange:Presence:)]) {
            [self.mDelegate friendStatusChange:self Presence:presence];
        }
    }
}
#pragma mark - 发送Presence成功
- (void)xmppStream:(XMPPStream *)sender didSendPresence:(XMPPPresence *)presence
{
    NSLog(@"didSendPresence:%@",presence.description);
}
#pragma mark - 发送Presence失败
- (void)xmppStream:(XMPPStream *)sender didFailToSendPresence:(XMPPPresence *)presence error:(NSError *)error
{
    NSLog(@"didFailToSendPresence:%@",error.description);
}
#pragma mark - 被通知要下线
- (void)xmppStreamWasToldToDisconnect:(XMPPStream *)sender
{
    NSLog(@"xmppStreamWasToldToDisconnect");
}
#pragma mark - 连接超时
- (void)xmppStreamConnectDidTimeout:(XMPPStream *)sender
{
    NSLog(@"xmppStreamConnectDidTimeout");
    //[[iToast makeText:@"连接超时"]show];
    //连接超时,继续重连
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self myConnect];
    });
}
#pragma mark - 下线成功
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    NSLog(@"xmppStreamDidDisconnect: %@",error.description);
    if (error.description != nil)
    {
        //[self myConnect];
    }
    else
    {
//        [[iToast makeText:@"连接已经断开"]show];
    }
}
#pragma mark - XMPPRosterDelegate
- (void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence
{
    NSLog(@"didReceivePresenceSubscriptionRequest: %@",presence.description);
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:presence.fromStr message:@"add" delegate:self cancelButtonTitle:@"cancle" otherButtonTitles:@"yes", nil];
    alertView.tag = tag_subcribe_alertView;
    [alertView show];
}
#pragma mark - XMPPReconnectDelegate
- (void)xmppReconnect:(XMPPReconnect *)sender didDetectAccidentalDisconnect:(SCNetworkReachabilityFlags)connectionFlags
{
    NSLog(@"didDetectAccidentalDisconnect:%u",connectionFlags);
}
- (BOOL)xmppReconnect:(XMPPReconnect *)sender shouldAttemptAutoReconnect:(SCNetworkReachabilityFlags)reachabilityFlags
{
    NSLog(@"shouldAttemptAutoReconnect:%u",reachabilityFlags);
    return YES;
}

-(void)showMessageWithTitle:(NSString *)title andMessage:(NSString *)message andCancelTitle:(NSString *)cancelTitle andOtherButton:(NSString *)otherTitle andTag:(NSInteger)tag
{
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:otherTitle, nil];
    alertView.tag = tag;
    [alertView show];
}
#pragma mark - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{   //有人加好友的消息
    if (alertView.tag == tag_subcribe_alertView && buttonIndex == 1) {
        XMPPJID *jid = [XMPPJID jidWithString:alertView.title];
        [[self xmppRoster] acceptPresenceSubscriptionRequestFrom:jid andAddToRoster:YES];
    }
    else if(alertView.tag == 802)
    {
       
    }
    else if (alertView.tag == 900)//预约订单执行,的处理
    {
    }
    else if (alertView.tag == 9999)
    {
        NSLog(@"点击了确定,%d",[xmppStream isConnected]);
        if ([xmppStream isConnected])
        {
            NSLog(@"XMPP已经连接");
            [xmppStream disconnect];
            if ([xmppStream isDisconnected])
            {
                NSLog(@"XMPP已经断开");
                NSUserDefaults * userData = [NSUserDefaults standardUserDefaults];
                [userData setObject:@"" forKey:@"telnum"];
                [userData setObject:@"" forKey:@"token"];
                [userData setObject:@"" forKey:@"username"];
                [userData setObject:@"" forKey:@"userpasd"];
                //[userData setObject:@"" forKey:@""];
                [userData synchronize];
                [self.navigationController popToRootViewControllerAnimated:YES];
                
            }
        }
//        NSUserDefaults * userData = [NSUserDefaults standardUserDefaults];
//        [userData setObject:@"" forKey:@"telnum"];
//        [userData setObject:@"" forKey:@"token"];
//        [userData setObject:@"" forKey:@"username"];
//        [userData setObject:@"" forKey:@"userpasd"];
//        //[userData setObject:@"" forKey:@""];
//        [userData synchronize];
//        [self.navigationController popToRootViewControllerAnimated:YES];
//
        /*
         这段代码测试用
         */
        
    }
}

@end
