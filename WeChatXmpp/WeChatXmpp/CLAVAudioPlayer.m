//
//  CLAVAudioPlayer.m
//  WeChatXmpp
//
//  Created by Charles Leo on 15/3/10.
//  Copyright (c) 2015年 Charles Leo. All rights reserved.
//

#import "CLAVAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface CLAVAudioPlayer()<AVAudioPlayerDelegate>
{
    AVAudioPlayer * player;
}
@end


@implementation CLAVAudioPlayer


+ (CLAVAudioPlayer *)sharedInstance
{
    static CLAVAudioPlayer * sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc]init];
    });
    return sharedInstance;
}

- (void)playSongWithUrl:(NSString *)songUrl
{
    dispatch_async(dispatch_queue_create("dfsfe", NULL), ^{
        [self.delegate CLAVAudioPlayerBeginLoadVoice];
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:songUrl]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (player) {
                [self.delegate CLAVAudioPlayerDidFinishPlay];
                [player stop];
                player.delegate = nil;
                player = nil;
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"VoicePlayHasInterrupt" object:nil];
            NSError * playerError;
            player = [[AVAudioPlayer alloc]initWithData:data error:&playerError];
            player.volume = 1.0f;
            if (player == nil) {
                NSLog(@"Error creating player:%@",[playerError description]);
            }
            [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryAmbient error:nil];
            player.delegate = self;
            [player play];
            [self.delegate CLAVAudioPlayerBeginPlay];
        });
    });
}


-(void)playSongWithData:(NSData *)songData
{
    [self.delegate CLAVAudioPlayerDidFinishPlay];
    if (player) {
        [player stop];
        player.delegate = nil;
        player = nil;
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"VoicePlayHasInterrupt" object:nil];
    NSError * playerError;
    player = [[AVAudioPlayer alloc]initWithData:songData error:&playerError];
    player.volume = 1.0f;
    [[AVAudioSession sharedInstance]setCategory:AVAudioSessionCategoryAmbient error:nil];
    player.delegate = self;
    [player play];
    [self.delegate CLAVAudioPlayerBeginPlay];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.delegate CLAVAudioPlayerDidFinishPlay];
}
- (void)stopSound
{
    if (player && player.isPlaying) {
        [player stop];
    }
}
@end
