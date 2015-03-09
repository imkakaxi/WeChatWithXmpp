//
//  ChatViewController.m
//  WeChatXmpp
//
//  Created by Charles Leo on 15/3/5.
//  Copyright (c) 2015年 Charles Leo. All rights reserved.
//

#import "ChatViewController.h"
#import "MJRefresh.h"
#import "ChatModel.h"

@interface ChatViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (strong,nonatomic) MJRefreshHeaderView * head;
@property (strong,nonatomic) ChatModel * chatModel;
@property (retain,nonatomic) UITableView * mTableView;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mTableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.mTableView.delegate = self;
    [self.view addSubview:self.mTableView];
    [self initBar];
    [self addRefreshView];
}

- (void)addRefreshView
{
    __weak typeof(self) weakSelf = self;
    int pageNum = 3;
    _head = [MJRefreshHeaderView header];
    
    _head.scrollView = self.mTableView;
    _head.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
//        [weakSelf.chatModel ];
    } ;
}
- (void)initBar
{
    self.title = @"好友";
}

- (void)loadBaseViewsAndData
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
