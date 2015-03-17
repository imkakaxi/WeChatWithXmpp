//
//  CLMessage.m
//  WeChatXmpp
//
//  Created by Charles Leo on 15/3/9.
//  Copyright (c) 2015年 Charles Leo. All rights reserved.
//

#import "CLMessage.h"
#import "NSDate+Utils.h"


@implementation CLMessage
- (void)setWithDict:(NSDictionary *)dict
{
    self.strIcon = dict[@"strIcon"];
    self.strName = dict [@"strName"];
    self.strId = dict [@"strId"];
    self.strTime = [self changeTheDateString:dict[@"strTime"]];
    if ([dict[@"from"] integerValue] == 1) {
        self.from = CLMessageFromMe;
    }
    else
    {
        self.from = CLMessageFromOther;
    }
    
    switch ([dict[@"type"] integerValue]) {
        case 0:
            self.type = CLMessageTypeText;
            self.strContent = dict[@"strContent"];
        break;
        case 1:
            self.type = CLMessageTypePicture;
            self.picture = dict[@"picture"];
        break;
        case 2:
            self.type = CLMessageTypeVoice;
            self.voice = dict[@"voice"];
            self.strVoiceTime = dict[@"strVoiceTime"];
        break;
        default:
            break;
    }
}

/**
 *
 *
 *  @param Str 时间字符串
 *
 *  @return 返回时间字符串
 */
- (NSString *)changeTheDateString:(NSString *)Str
{
    NSString * subString = [Str substringWithRange:NSMakeRange(0, 19)];
    NSDate * lastDate = [NSDate dateFromString:subString withFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * dateStr; //年月日
    NSString * period;  //时间段
    NSString * hour;    //时
    
    if ([lastDate year] == [[NSDate date] year]) {
        NSInteger days = [NSDate daysOffsetBetweenStartDate:lastDate endDate:[NSDate date]];
        if (days <= 2) {
            dateStr =[lastDate stringYearMonthDayCompareToday];
        }
        else
        {
            dateStr = [lastDate stringMonthDay];
        }
    }
    else
    {
        dateStr = [lastDate stringYearMonthDay];
    }
    if ([lastDate hour] > 5 && [lastDate hour] < 12) {
        period = @"AM";
        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour]];
    }
    else if ([lastDate hour] >= 12 && [lastDate hour] <= 18)
    {
        period = @"PM";
        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour] -12];
    }
    else if ([lastDate hour] >= 18 && [lastDate hour] <= 23)
    {
        period = @"Night";
        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour] -12];
    }
    else
    {
        period = @"Dawn";
        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour]];
    }
    return [NSString stringWithFormat:@"%@ %@ %@:%02d",dateStr,period,hour,(int)[lastDate minute]];
}

- (void)minuteOffSetStart:(NSString *)start end:(NSString *)end
{
    if (!start) {
        self.showDateLabel = YES;
        return;
    }
    NSString * subStart = [start substringWithRange:NSMakeRange(0, 19)];
    NSDate * startDate = [NSDate dateFromString:subStart withFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * subEnd = [end substringWithRange:NSMakeRange(0, 19)];
    NSDate * endDate = [NSDate dateFromString:subEnd withFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //这个是相隔的秒数
    NSTimeInterval timeInterval = [startDate timeIntervalSinceDate:endDate];
    //相距5分钟显示时间Label
    if (fabs(timeInterval)>5* 60) {
        self.showDateLabel = YES;
    }
    else
    {
        self.showDateLabel = NO;
    }
}





@end