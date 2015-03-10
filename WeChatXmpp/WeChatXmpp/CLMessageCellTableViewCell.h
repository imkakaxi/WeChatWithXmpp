//
//  CLMessageCellTableViewCell.h
//  WeChatXmpp
//
//  Created by Charles Leo on 15/3/9.
//  Copyright (c) 2015年 Charles Leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLMessageContentButton.h"
@class CLMessageFrame;
@class CLMessageCellTableViewCell;
@protocol CLMessageCellDelegate <NSObject>

- (void)headImageDidClick:(CLMessageCellTableViewCell *)cell userId:(NSString *)userId;

- (void)cellContentDidClick:(CLMessageCellTableViewCell *)cell image:(UIImage *)contentImage;
@end

@interface CLMessageCellTableViewCell : UITableViewCell

@property (retain,nonatomic) UILabel * labelTime;
@property (retain,nonatomic) UILabel * labelNum;
@property (retain,nonatomic) UIButton * btnHeadImage;
@property (retain,nonatomic) CLMessageContentButton * btnContent;
@property (retain,nonatomic) CLMessageFrame * messageFrame;
@property (assign,nonatomic) id<CLMessageCellDelegate> delegate;

@end
