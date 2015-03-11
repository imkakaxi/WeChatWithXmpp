//
//  CLMessageCellTableViewCell.m
//  WeChatXmpp
//
//  Created by Charles Leo on 15/3/9.
//  Copyright (c) 2015年 Charles Leo. All rights reserved.
//

#import "CLMessageCellTableViewCell.h"
#import "CLMessage.h"
#import "CLMessageFrame.h"
#import "UIImageView+AFNetworking.h"
#import "UIButton+AFNetworking.h"
#import "CLImageAvatarBrowser.h"
#import "CLAVAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface CLMessageCellTableViewCell()<CLAVAudioPlayerDelegate>
{
    AVAudioPlayer * player;
    NSString * voiceURL;
    NSData * songData;
    
    CLAVAudioPlayer * audio;
    UIView * headImageBackView;
}
@end

@implementation CLMessageCellTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //1.创建时间
        self.labelTime = [[UILabel alloc]init];
        self.labelTime.textAlignment = NSTextAlignmentCenter;
        self.labelTime.textColor = [UIColor grayColor];
        self.labelTime.font = ChatTimeFont;
        [self.contentView addSubview:self.labelTime];
        
        //2.创建头像
        headImageBackView = [[UIView alloc]init];
        headImageBackView.layer.cornerRadius = 22;
        headImageBackView.layer.masksToBounds = YES;
        headImageBackView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.4];
        [self.contentView addSubview:headImageBackView];
        self.btnHeadImage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btnHeadImage.layer.cornerRadius = 20;
        self.btnHeadImage.layer.masksToBounds = YES;
        [self.btnHeadImage addTarget:self action:@selector(btnHeadImageClick:) forControlEvents:UIControlEventTouchUpInside];
        [headImageBackView addSubview:self.btnHeadImage];
        //3.创建头像下标
        self.labelNum = [[UILabel alloc]init];
        self.labelNum.textColor = [UIColor grayColor];
        self.labelNum.textAlignment = NSTextAlignmentCenter;
        self.labelNum.font = ChatTimeFont;
        [self.contentView addSubview:self.labelNum];
        
        //4.创建内容
        self.btnContent = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.btnContent setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.btnContent.titleLabel.font = ChatContentFont;
        self.btnContent.titleLabel.numberOfLines = 0;
        [self.btnContent addTarget:self action:@selector(btnContentClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.btnContent];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(CLAVAudioPlayerDidFinishPlay) name:@"VoicePlayHasInterrupt" object:nil];
    }
    return self;
}
//点击头像
- (void)btnHeadImageClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(headImageDidClick:userId:)]) {
        [self.delegate headImageDidClick:self userId:self.messageFrame.message.strId];
    }
}
//点击内容
- (void)btnContentClick
{
    if (self.messageFrame.message.type == CLMessageTypeVoice) {
        audio = [CLAVAudioPlayer sharedInstance];
        audio.delegate = self;
        [audio playSongWithData:songData];
    }
    else if (self.messageFrame.message.type == CLMessageTypePicture)
    {
        if (self.btnContent.backImageView) {
//            CLImageAvatarBrowser 
        }
        if ([self.delegate isKindOfClass:[UIViewController class]]) {
            [[(UIViewController *)self.delegate view] endEditing:YES];
        }
    }
    else if (self.messageFrame.message.type == CLMessageTypeText)
    {
        [self.btnContent becomeFirstResponder];
        UIMenuController * menu = [UIMenuController sharedMenuController];
        [menu setTargetRect:self.btnContent.frame inView:self.btnContent.superview];
        [menu setMenuVisible:YES animated:YES];
    }
}


- (void)CLAVAudioPlayerBeginLoadVoice
{
    [self.btnContent beginLoadVoice];
}

- (void)CLAVAudioPlayerBeginPlay
{
    [self.btnContent didLoadVoice];
}

- (void)CLAVAudioPlayerDidFinishPlay
{
    [self.btnContent stopPlay];
    [[CLAVAudioPlayer sharedInstance]stopSound];
}


- (void)setMessageFrame:(CLMessageFrame *)messageFrame
{
    _messageFrame = messageFrame;
    CLMessage * message = messageFrame.message;
    //设置时间
    self.labelTime.text = message.strTime;
    self.labelTime.frame = messageFrame.timeF;
    
    //设置头像
    headImageBackView.frame = messageFrame.iconF;
    self.btnHeadImage.frame = CGRectMake(2, 2, ChatIconWH - 4, ChatIconWH - 4);
    if (message.from == CLMessageFromMe) {
        [self.btnHeadImage setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:message.strIcon]];
    }
    else
    {
        [self.btnHeadImage setBackgroundImageForState:UIControlStateNormal withURL:[NSURL URLWithString:message.strIcon]];
    }
    //设置下标
    self.labelNum.text = message.strName;
    if (messageFrame.nameF.origin.x > 160) {
        self.labelNum.frame = CGRectMake(messageFrame.nameF.origin.x - 50, messageFrame.nameF.origin.y +3, 100, messageFrame.nameF.size.height);
        self.labelNum.textAlignment = NSTextAlignmentRight;
    }
    else
    {
        self.labelNum.frame = CGRectMake(messageFrame.nameF.origin.x, messageFrame.nameF.origin.y + 3, 80, messageFrame.nameF.size.height);
        self.labelNum.textAlignment = NSTextAlignmentLeft;
    }
    
    //设置内容
    [self.btnContent setTitle:@"" forState:UIControlStateNormal];
    self.btnContent.voiceBackView.hidden = YES;
    self.btnContent.backImageView.hidden = YES;
    
    self.btnContent.frame = messageFrame.contentF;
    if (message.from == CLMessageFromMe) {
        self.btnContent.isMyMessage =YES;
        [self.btnContent setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.btnContent.contentEdgeInsets = UIEdgeInsetsMake(ChatContentTop, ChatContentRight, ChatContentBottom, ChatContentLeft);
    }
    else
    {
        self.btnContent.isMyMessage = NO;
        [self.btnContent setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.btnContent.contentEdgeInsets = UIEdgeInsetsMake(ChatContentTop, ChatContentLeft, ChatContentBottom, ChatContentRight);
    }
    switch (message.type) {
        case CLMessageTypeText:
           [self.btnContent setTitle:message.strContent forState:UIControlStateNormal];
            break;
        case CLMessageTypePicture:
            self.btnContent.backImageView.hidden = NO;
            self.btnContent.backImageView.image = message.picture;
            break;
        case CLMessageTypeVoice:
            self.btnContent.voiceBackView.hidden = NO;
            self.btnContent.second.text = [NSString stringWithFormat:@"%@'s Voice",message.strVoiceTime];
            songData = message.voice;
            break;
        default:
            break;
    }
    //背景气泡
    UIImage * normal;
    if (message.from == CLMessageFromMe) {
        normal =[UIImage imageNamed:@"chatto_bg_normal"];
        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(35, 10, 10, 22)];
    }
    else
    {
        normal = [UIImage imageNamed:@"chatfrom_bg_normal"];
        normal = [normal resizableImageWithCapInsets:UIEdgeInsetsMake(35, 22, 10, 10)];
    }
    [self.btnContent setBackgroundImage:normal forState:UIControlStateNormal];
    [self.btnContent setBackgroundImage:normal forState:UIControlStateHighlighted];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
