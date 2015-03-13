//
//  CLProgressHUD.h
//  WeChatXmpp
//
//  Created by Charles Leo on 15/3/11.
//  Copyright (c) 2015年 Charles Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLProgressHUD : UIView

@property (strong,nonatomic) UILabel * titleLabel;
@property (strong,nonatomic) UILabel * subTitleLabel;
+ (void)show;

+ (void)dismissWithSucess:(NSString *)str;
+ (void)dismissWithError:(NSString *)str;
+(void)changeSubTitle:(NSString *)str;

@end
