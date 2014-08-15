//
//  LYHBarButtonItem.m
//  WeChatXmpp
//
//  Created by Charles Leo on 14-8-15.
//  Copyright (c) 2014年 Charles Leo. All rights reserved.
//

#import "LYHBarButtonItem.h"

@implementation LYHBarButtonItem
-(id)initWithTitle:(NSString *)title image:(UIImage *)image tag:(NSInteger)tag
{
    if (self = [super init])
    {
        self.title = title;
        self.image = image;
        self.tag = tag;
        [self setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                      [UIFont systemFontOfSize:13.0f], UITextAttributeFont,
                                      nil] forState:UIControlStateNormal];
        /*[UIColor colorWithRed:1 green:1 blue:1 alpha:1], NSForegroundColorAttributeName,
         [UIColor colorWithRed:1 green:1 blue:1 alpha:1], UITextAttributeTextShadowColor,
         [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
         */
        
    }
    return self;
}
@end
