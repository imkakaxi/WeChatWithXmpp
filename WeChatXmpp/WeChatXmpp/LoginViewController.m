//
//  LoginViewController.m
//  WeChatXmpp
//
//  Created by Charles Leo on 14-8-18.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import "LoginViewController.h"
#import "LYHAppDelegate.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize mNameLabel,mNameText,mPasdLabel,mPasdText;
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
    //Welcome_Login_LogoCH@2x
    //Welcome_Login_BG@2x
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Welcome_Login_BG.jpg"]];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(320/2 - 105/2, 30, 210/2, 220/2)];
    imageView.image = [UIImage imageNamed:@"Welcome_Login_LogoCH"];
    [self.view addSubview:imageView];
	UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 250, 50, 30)];
    nameLabel.text = @"用户名:";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:nameLabel];
    
    UITextField * nameText = [[UITextField alloc]initWithFrame:CGRectMake(120, 250, 150, 30)];
    nameText.keyboardType = UIKeyboardTypeDefault;
    nameText.font = [UIFont systemFontOfSize:14.0f];
    nameText.textAlignment = NSTextAlignmentLeft;
    nameText.borderStyle = UITextBorderStyleRoundedRect;
    nameText.placeholder = @"请输入账号";
    self.mNameText = nameText;
    [self.view addSubview:self.mNameText];
    
    UILabel * pasdLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 300, 50, 30)];
    pasdLabel.text = @"密  码:";
    pasdLabel.textColor = [UIColor whiteColor];
    pasdLabel.textAlignment = NSTextAlignmentLeft;
    pasdLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.view addSubview:pasdLabel];
    
    UITextField * pasdText = [[UITextField alloc]initWithFrame:CGRectMake(120, 300, 150, 30)];
    pasdText.keyboardType = UIKeyboardTypeDefault;
    pasdText.font = [UIFont systemFontOfSize:14.0f];
    pasdText.textAlignment = NSTextAlignmentLeft;
    pasdText.borderStyle = UITextBorderStyleRoundedRect;
    pasdText.placeholder = @"请输入密码";
    self.mPasdText = pasdText;
    [self.view addSubview:self.mPasdText];
    /*
     如果码错误添加抖动动画提示错误
     */
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[@0,@10,@-10,@10,@0];
    animation.keyTimes = @[@0,@(1/6.0),@(3/6.0),@(5/6.0),@1];
    animation.duration  = 0.4;
    animation.additive = YES;
    [self.mPasdText.layer addAnimation:animation forKey:@"shake"];
    
    
    UIButton * btnLogin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnLogin.frame =CGRectMake(100, 360, 120, 40);
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    btnLogin.backgroundColor = [UIColor greenColor];
    //[btnLogin setBackgroundImage:[UIImage imageNamed:@"LoginGreenBigBtn"] forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
}



- (void)buttonClick:(UIButton *)sender
{
    if ([self allInformationReady]) {
        [self connectToOpenFire];
    }
    LYHAppDelegate * appDelegate = (LYHAppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController = appDelegate.mTabbarCtrl;
}

#pragma mark - XMPP相关方法
//判断用户信息是否齐全
-(BOOL)allInformationReady
{
   // NSUserDefaults * userDef = [NSUserDefaults standardUserDefaults];
    //[userDef objectForKey:@"loginName"]
    //[userDef objectForKey:@"userPasd"]
    NSString * userName = @"hdsx";
    NSString * userPasd = @"123";
    NSString * myName = [[NSString alloc]initWithFormat:@"%@",userName];
    NSString *myPasd = [[NSString alloc]initWithFormat:@"%@",userPasd];
    NSString *myPort =[[NSString alloc]initWithFormat:@"%@",XMPPPORT];
    NSString *myHost = [[NSString alloc]initWithFormat:@"%@",XMPPHOST];
    NSLog(@"host is %@ pasd is %@ port is %@ name is %@",myHost,myPasd,myPort,myName);
    if (myHost&&myPasd&&myPort&&myName)
    {
        [[[[self appDelegate] mXmppClass] xmppStream] setHostName:myHost];
        [[[[self appDelegate] mXmppClass] xmppStream] setHostPort:[myPort integerValue]];
        [[NSUserDefaults standardUserDefaults]setObject:myHost forKey:kHost];
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@@%@/Smack",myName,@"taxiservier2"] forKey:kMyJID];
        [[NSUserDefaults standardUserDefaults]setObject:myPasd forKey:kPS];
        return YES;
    }
    return NO;
}
//如果连接XMPP失败,那么就接着连接直到练级成功
-(void)connectOpenFireAgain:(LYHAppDelegate *)appD
{
    [self connectToOpenFire];
}
//连接XMPP
-(void)connectToOpenFire
{
    NSLog(@"连接到OpenFire");
    if (![self allInformationReady])
    {
        return;
    }
    [[[self appDelegate]mXmppClass] myConnect];
}
- (LYHAppDelegate *)appDelegate
{
    LYHAppDelegate *appDel =  (LYHAppDelegate *)[[UIApplication sharedApplication] delegate];
	return appDel;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.mNameText resignFirstResponder];
    [self.mPasdText resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
