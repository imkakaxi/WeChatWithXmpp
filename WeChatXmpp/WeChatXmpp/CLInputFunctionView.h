//
//  CLInputFunctionView.h
//  WeChatXmpp
//
//  Created by Charles Leo on 15/3/9.
//  Copyright (c) 2015年 Charles Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLInputFunctionView;
@protocol CLInputFunctionViewDelegate <NSObject>

- (void)CLInputFunctionView:(CLInputFunctionView *)funcView sendMessage:(NSString *)message;

- (void)CLInputFunctionView:(CLInputFunctionView *)funcView sendPicture:(UIImage *)image;

- (void)CLInputFunctionView:(CLInputFunctionView *)funcView sendVoice:(NSData *)voice time:(NSInteger)second;

@end

@interface CLInputFunctionView : UIView<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (retain,nonatomic) UIButton                    * btnSendMessage;
@property (retain,nonatomic) UIButton                    * btnChangeVoiceState;
@property (retain,nonatomic) UIButton                    * btnVoiceRecord;
@property (retain,nonatomic) UITextView                  * TextViewInput;
@property (assign,nonatomic) BOOL                        isAbleToSendTextMessage;
@property (retain,nonatomic) UIViewController            * superVC;
@property (assign,nonatomic) id <CLInputFunctionViewDelegate> delegate;

- (id)initWithSuperVC:(UIViewController *)superVC;

- (void)changeSendBtnWithPhoto:(BOOL)isPhoto;

@end
