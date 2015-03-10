//
//  CLMessageContentButton.h
//  WeChatXmpp
//
//  Created by Charles Leo on 15/3/9.
//  Copyright (c) 2015年 Charles Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLMessageContentButton : UIButton
//汽包背景
@property (retain,nonatomic) UIImageView * backImageView;

@property (retain,nonatomic) UIView * voiceBackView;
@property (retain,nonatomic) UILabel * second;
@property (retain,nonatomic) UIImageView * voice;
@property (retain,nonatomic) UIActivityIndicatorView * indictor;

@property (nonatomic,assign) BOOL isMyMessage;

- (void)beginLoadVoice;
- (void)didLoadVoice;
- (void)stopPlay;

@end
