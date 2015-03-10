//
//  CLMessageFrame.h
//  WeChatXmpp
//
//  Created by Charles Leo on 15/3/9.
//  Copyright (c) 2015年 Charles Leo. All rights reserved.
//


#define ChatMargin 10           //间隔
#define ChatIconWH 44           //头像宽 高
#define ChatPicWH 200           //图片宽高
#define ChatContentW 180        //内容宽度

#define ChatTimeMarginW 15      //时间文本与边框间隔宽度方向
#define ChatTimeMarginH 10      //时间文本与边框间隔高度方向

#define ChatContentTop 15       //文本内容与按钮上边缘间隔
#define ChatContentLeft 25      //文本内容与按钮左边缘间隔
#define ChatContentBottom 15    //文本内容与按钮下边缘间隔
#define ChatContentRight 15     //文本内容与按钮右边缘间隔

#define ChatTimeFont [UIFont systemFontOfSize:11]   //时间字体
#define ChatContentFont [UIFont systemFontOfSize:14]//内容字体
#import <Foundation/Foundation.h>

@class CLMessage;

@interface CLMessageFrame : NSObject

@property (assign,readonly,nonatomic) CGRect nameF;
@property (assign,readonly,nonatomic) CGRect iconF;
@property (assign,readonly,nonatomic) CGRect timeF;
@property (assign,readonly,nonatomic) CGRect contentF;

@property (assign,readonly,nonatomic) CGFloat cellHeight;
@property (strong,nonatomic) CLMessage * message;
@property (assign,nonatomic) BOOL showTime;


@end
