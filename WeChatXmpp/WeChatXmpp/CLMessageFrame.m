//
//  CLMessageFrame.m
//  WeChatXmpp
//
//  Created by Charles Leo on 15/3/9.
//  Copyright (c) 2015年 Charles Leo. All rights reserved.
//

#import "CLMessageFrame.h"
#import "CLMessage.h"
@implementation CLMessageFrame

- (void)setMessage:(CLMessage *)message
{
    _message = message;
    CGFloat screenW = [[UIScreen mainScreen]bounds].size.width;
    //计算时间的位置
    if (_showTime) {
        CGFloat timeY = ChatMargin;
        CGSize timeSize = [_message.strTime sizeWithFont:ChatTimeFont constrainedToSize:CGSizeMake(300, 100) lineBreakMode:NSLineBreakByCharWrapping];
        
        CGFloat timeX = (screenW - timeSize.width) / 2;
        _timeF = CGRectMake(timeX, timeY, timeSize.width + ChatTimeMarginW, timeSize.height + ChatTimeMarginH);
    }
    //计算头像位置
    CGFloat iconX = ChatMargin;
    if (_message.from == CLMessageFromMe) {
        iconX = screenW - ChatMargin - ChatIconWH;
    }
    CGFloat iconY = CGRectGetMaxY(_timeF) + ChatMargin;
    _iconF = CGRectMake(iconX, iconY, ChatIconWH, ChatIconWH);
    
    //计算ID位置
    _nameF = CGRectMake(iconX, iconY + ChatIconWH,ChatIconWH , 20);
    
    //计算内容位置
    CGFloat contentX = CGRectGetMaxX(_iconF) + ChatMargin;
    CGFloat contentY = iconY;
    
    //根据种类分
    CGSize contentSize;
    switch (_message.type) {
        case CLMessageTypeText:
            contentSize = [_message.strContent sizeWithFont:ChatContentFont constrainedToSize:CGSizeMake(ChatContentW, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
            break;
        case CLMessageTypePicture:
            contentSize = CGSizeMake(ChatPicWH, ChatPicWH);
            break;
        case CLMessageTypeVoice:
            contentSize = CGSizeMake(120, 120);
            break;
        default:
            break;
    }
    if (_message.from == CLMessageFromMe) {
        contentX = iconY - contentSize.width - ChatContentLeft - ChatContentRight - ChatMargin;
    }
    _contentF = CGRectMake(contentX, contentY, contentSize.width + ChatContentLeft + ChatContentRight, contentSize.height + ChatContentTop + ChatContentBottom);
    _cellHeight = MAX(CGRectGetMaxY(_contentF), CGRectGetMaxY(_nameF)) + ChatMargin;
}

@end
