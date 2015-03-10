//
//  ChatModel.h
//  WeChatXmpp
//
//  Created by Charles Leo on 15/3/6.
//  Copyright (c) 2015年 Charles Leo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatModel : NSObject

@property (strong,nonatomic) NSMutableArray * dataSource;

- (void)populateRandomDataSource;

- (void) addRandomItemsToDataSource:(NSInteger)number;

- (void)addSpecifiedItem:(NSDictionary *)dic;

@end
