//
//  CLMessage.h
//  WeChatXmpp
//
//  Created by Charles Leo on 15/3/9.
//  Copyright (c) 2015年 Charles Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
  CLMessageTypeText = 0,    //文字
  CLMessageTypePicture = 1, //图片
  CLMessageTypeVoice = 2    //语音
} MessageType;

typedef enum {
  CLMessageFromMe = 100,   //自己发的
  CLMessageFromOther = 101 //别人发的
} MessageFrom;

@interface CLMessage : NSObject

@property(copy, nonatomic) NSString *strIcon;
@property(copy, nonatomic) NSString *strId;
@property(copy, nonatomic) NSString *strTime;
@property(copy, nonatomic) NSString *strName;

@property(copy, nonatomic) NSString *strContent;
@property(copy, nonatomic) UIImage *picture;
@property(copy, nonatomic) NSData *voice;
@property(copy, nonatomic) NSString *strVoiceTime;

@property(assign, nonatomic) MessageType type;
@property(assign, nonatomic) MessageFrom from;

@property(assign, nonatomic) BOOL showDateLabel;

- (void)setWithDict:(NSDictionary *)dict;

- (void)minuteOffSetStart:(NSString *)start end:(NSString *)end;

@end
