//
//  MessageLIstViewController.m
//  WeChatXmpp
//
//  Created by Charles Leo on 14-8-15.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import "MessageLIstViewController.h"

@interface MessageLIstViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) NSMutableArray * mMessageData;
@end

@implementation MessageLIstViewController

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
    [self getData];
	// Do any additional setup after loading the view.
}

- (void)getData
{
    if (self.mMessageData.count > 0)
    {
        [self initTableView];
    }
}
- (void)initTableView
{
    UITableView * tableView =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mMessageData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * strID = @"ID";
    UITableViewCell * cell= [tableView dequeueReusableCellWithIdentifier:strID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strID];
    }
    return cell;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
