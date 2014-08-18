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
    
    UIButton * btnLogin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnLogin.frame =CGRectMake(100, 360, 120, 50);
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    btnLogin.backgroundColor = [UIColor greenColor];
    //[btnLogin setBackgroundImage:[UIImage imageNamed:@"LoginGreenBigBtn"] forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:btnLogin];
}

- (void)buttonClick:(UIButton *)sender
{
    LYHAppDelegate * appDelegate = (LYHAppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.window.rootViewController = appDelegate.mTabbarCtrl;
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
