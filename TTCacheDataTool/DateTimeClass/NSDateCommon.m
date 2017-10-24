//
//  NSDateCommon.m
//  we
//
//  Created by zzxcc on 15/7/9.
//  Copyright (c) 2015年 we. All rights reserved.
//

#import "NSDateCommon.h"

@implementation NSDateCommon

/*
 存放常用的日期转换类
 注意保持代码的优美性！
 */


#pragma mark -单独取日期中的年月日请在这里面找
//0==>只取年月，1==>只取年月日，2==>取小时
+ (NSString *)dateTimeConvertYearMonth:(NSDate *)date andType:(int)type
{
    NSString *styles = [[NSString alloc]init];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    
    switch (type) {
        case 0:
            styles = @"yyyy-MM";
            break;
        case 1:
            styles = @"yyyy-MM-dd";
            break;
        case 2:
            styles = @"yyyy";
            break;
        case 3:
            styles = @"MM";
            break;
        case 4:
            styles = @"dd";
            break;
        case 5:
            styles = @"HH";
            break;
        case 6:
            styles = @"HH:mm";
            break;
            
        default:
            [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
            styles  = @"mm";
            break;
    }
    [dateFormatter setDateFormat:styles];
    NSString *oneDayStr = [dateFormatter stringFromDate:date];
    return oneDayStr;
}

#pragma mark -其它待分类
//时间戳转换字符串
+ (NSString *)datetimeConversionAndDatetime:(int)datetime datePrecision:(DatePrecision)datePrecision
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:datetime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:[self datePrecision:datePrecision]]; // -----
    NSString *nowtimeStr = [formatter stringFromDate:confromTimesp];
    return nowtimeStr;
}


//字符串转为NSDate
+ (NSDate*)datetimeConversionAndDatetimeStr:(NSString *)dateStr datePrecision:(DatePrecision)datePrecision
{
    //    dateStr = @"2015-1-23 22:32:32";
    
    //将传入时间转化成需要的格式
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    //    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [format setDateFormat:[self datePrecision:datePrecision]];
    
    NSDate *fromdate=[format dateFromString:dateStr];
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    //    DLog(@"fromdate====%@",fromDate);
    return fromDate;
}

//输入日期转换周几
+ (NSString *)getWeek:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:date];
    int _weekday = (int)[weekdayComponents weekday];
    DLog(@"_weekday::%d",_weekday - 1);
    switch (_weekday - 1) {
        case 0:
            return @"星期日";
            break;
        case 1:
            return @"星期一";
            break;
        case 2:
            return @"星期二";
            break;
        case 3:
            return @"星期三";
            break;
        case 4:
            return @"星期四";
            break;
        case 5:
            return @"星期五";
            break;
        case 6:
            return @"星期六";
            break;
        default:
            break;
    }
    return 0;
    
}
+ (NSString *)datePrecision:(DatePrecision)datePrecision
{
    NSString *precisionStr;
    switch (datePrecision) {
        case DatePrecision_Year:
        {
            precisionStr = @"yyyy";

        }
            break;
        case DatePrecision_Month:
        {
            precisionStr = @"yyyy-MM";

        }
            break;
            
        case DatePrecision_Date:
        {
            precisionStr = @"yyyy-MM-dd";
        }
            break;
        case DatePrecision_Hour:
        {
            precisionStr = @"yyyy-MM-dd HH";

        }
            break;
        case DatePrecision_Minutes:
        {
            precisionStr = @"yyyy-MM-dd HH:mm";

        }
            break;
        case DatePrecision_Seconds:
        {
            precisionStr = @"yyyy-MM-dd HH:mm:ss";

        }
            break;
        case DatePrecision_Ms:
        {
            precisionStr = @"yyyy-MM-dd HH:mm:ss:SSS";

        }
            break;
            
        default:
            break;
    }
    return precisionStr;
}
+(NSDateComponents *)compareDateWithDateA:(NSDate *)dateA andDateB:(NSDate *)dateB
{
    
    //判断某时间跟现在相差多少天
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                               fromDate:dateA toDate:dateB options:0];
    //    int year = (int)[components year];//相差年数
    //    int month = (int)[components month];//相差月数
    //    int day = (int)[components day];//相差天数
    //    int h = (int)[components hour];//相差小时
    
    //[NSDate date] //当前时间
    //    if (year == 0 && month == 0 && day < 3) {
    //        if (day == 0) {
    //            title = NSLocalizedString(@"今天",nil);
    //        } else if (day == 1) {
    //            title = NSLocalizedString(@"昨天",nil);
    //        } else if (day == 2) {
    //            title = NSLocalizedString(@"前天",nil);
    //        }
    //
    //        //df.dateFormat = [NSString stringWithFormat:@"%@ HH:mm",title];
    //        dateString = [df stringFromDate: [NSDate date]];//当前时间
    //
    //    }
    //    else
    //        title = NSLocalizedString(@"曾经", nil);
    //
    return components;
}



+ (NSString *)lastOrNextMonthWith:(NSDateComponents *)cmp andSpan:(int)span andType:(int)type
{
    NSCalendar *calender = [NSCalendar currentCalendar];//获取NSCalender单例。
    //    NSDateComponents *cmp = [calender components:(NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:date]; //设置属性，因为我只需要年和月，这个属性还可以支持时，分，秒。
    DLog(@"%ld",(long)[cmp month]);
    switch (type) {
        case 0:
            [cmp setMonth:[cmp month] - span];//设置上个月，即在现有的基础上减去一个月。这个地方可以灵活的支持跨年了，免去了繁琐的计算年份的工作。
            
            break;
            
        default:
        {
            [cmp setMonth:[cmp month] + span];//设置上个月，即在现有的基础上减去一个月。这个地方可以灵活的支持跨年了，免去了繁琐的计算年份的工作。
        }
            break;
    }
    NSDate *lastMonDate = [calender dateFromComponents:cmp];//拿到上个月的NSDate，再用NSDateFormatter就可以拿到单独的年和月了。
    return [self dateTimeConvertYearMonth:lastMonDate andType:0];
}
//比较两个日期的大小,仅支持年月日
+ (NSComparisonResult)compareDateA:(NSDate *)dateA
                         WithDateB:(NSDate *)dateB datePrecision:(DatePrecision)datePrecision
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:[self datePrecision:datePrecision]];
    NSString *oneDayStr = [dateFormatter stringFromDate:dateA];
    NSString *anotherDayStr = [dateFormatter stringFromDate:dateB];
    NSDate *dateC = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateD = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult resultt = [dateC compare:dateD];
    
    
    //typedef NS_ENUM(NSInteger, NSComparisonResult)
    //{
    //   NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
    //};
    
    return resultt;
}

//判断日期在某个区间之内
+ (BOOL)isBetweenFromHour:(NSInteger)fromHour FromMinute:(NSInteger)fromMin toHour:(NSInteger)toHour toMinute:(NSInteger)toMin{
    NSDate *date8 = [self getCustomDateWithHour:fromHour andMinute:fromMin];
    NSDate *date23 = [self getCustomDateWithHour:toHour andMinute:toMin];
    NSDate *currentDate = [NSDate date];
    if ([currentDate compare:date8]==NSOrderedDescending && [currentDate compare:date23]==NSOrderedAscending)
    {
        DLog(@"该时间在 %ld:%ld-%ld:%ld 之间！", fromHour, fromMin, toHour, toMin);
        return YES;
    }
    else
        
        return NO;
    
}


//- (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour
//{
//    NSDate *date8 = [self getCustomDateWithHour:8];
//    NSDate *date23 = [self getCustomDateWithHour:23];
//
//    NSDate *currentDate = [NSDate date];
//
//    if ([currentDate compare:date8]==NSOrderedDescending && [currentDate compare:date23]==NSOrderedAscending)
//    {
//        DLog(@"该时间在 %ld:00-%ld:00 之间！", (long)fromHour, (long)toHour);
//        return YES;
//    }
//    return NO;
//}


//传入的小时和分钟，转成nsdate类型
+ (NSDate *)getCustomDateWithHour:(NSInteger)hour andMinute:(NSInteger)minute{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    [resultComps setMinute:minute];
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [resultCalendar dateFromComponents:resultComps];
}
+ (NSString *)getMonthBeginAndEndWith:(NSString *)dateStr
{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY.MM.dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    NSString *s = [NSString stringWithFormat:@"%@到%@",beginString,endString];
    return s;
}
+ (NSString *)datetimeConversionAndDatetimeWithDate:(NSDate *)date datePrecision:(DatePrecision)datePrecision
{
    
    NSDate *  senddate = date;
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:[self datePrecision:datePrecision]];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    NSLog(@"日期：%@",locationString);
    return locationString;
}





@end
