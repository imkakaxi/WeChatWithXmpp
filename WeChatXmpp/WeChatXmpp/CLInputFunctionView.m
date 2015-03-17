//
//  CLInputFunctionView.m
//  WeChatXmpp
//
//  Created by Charles Leo on 15/3/9.
//  Copyright (c) 2015年 Charles Leo. All rights reserved.
//

#import "CLInputFunctionView.h"
#import "Mp3Recorder.h"
#import "CLProgressHUD.h"


@interface CLInputFunctionView() <UITextFieldDelegate,Mp3RecorderDelegate>
{
    BOOL isbeginVoiceRecord;
    Mp3Recorder * MP3;
    NSInteger playTime;
    NSTimer * playTimer;
    UILabel * placeHold;
}

@end

@implementation CLInputFunctionView
- (id)initWithSuperVC:(UIViewController *)superVC
{
    self.superVC     = superVC;
    CGFloat VCWidth  = Main_Screen_Width;
    CGFloat VCHeight = Main_Screen_Height;
    CGRect frame     = CGRectMake(0, VCHeight - 40, VCWidth, 40);
    if (self = [super init]) {
        MP3 = [[Mp3Recorder alloc]initWithDelegate:self];
        
    }
    return self;
}

@end
