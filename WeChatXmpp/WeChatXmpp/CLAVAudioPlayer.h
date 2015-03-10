//
//  CLAVAudioPlayer.h
//  WeChatXmpp
//
//  Created by Charles Leo on 15/3/10.
//  Copyright (c) 2015年 Charles Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CLAVAudioPlayerDelegate<NSObject>

- (void)CLAVAudioPlayerBeginLoadVoice;
- (void)CLAVAudioPlayerBeginPlay;
- (void)CLAVAudioPlayerDidFinishPlay;

@end

@interface CLAVAudioPlayer : NSObject

@property (assign,nonatomic) id <CLAVAudioPlayerDelegate>delegate;

+ (CLAVAudioPlayer *)sharedInstance;

- (void)playSongWithUrl:(NSString *)songUrl;

- (void)playSongWithData:(NSData *)songData;

- (void)stopSound;

@end
