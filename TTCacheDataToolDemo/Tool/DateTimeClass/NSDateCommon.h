//
//  NSDateCommon.h
//  we
//
//  Created by zzxcc on 15/7/9.
//  Copyright (c) 2015年 we. All rights reserved.
//

#import <Foundation/Foundation.h>
//---------------------打印日志--------------------------
//Debug模式下打印日志,当前行,函数名
#if DEBUG
#define DLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else
#define DLog(FORMAT, ...) nil
#endif

static NSString *KeyChain_TimeInterval  = @"ukc4uQavWsq1z4rLhCrcXl4GTW9KQBoT";

@interface NSDateCommon : NSObject
typedef NS_ENUM(NSInteger, DatePrecision) {
    //以下是枚举成员
    DatePrecision_Year = 0,//精确到年
    DatePrecision_Month = 1,//精确到月
    DatePrecision_Date = 2,//精确到日
    DatePrecision_Hour = 3,//精确到时
    DatePrecision_Minutes= 4,//精确到分
    DatePrecision_Seconds= 5,//精确到秒
    DatePrecision_Ms= 6,//精确到秒
    
};

typedef NS_ENUM(NSInteger, DateStyle) {
    //以下是枚举成员
    DATESTYLE_Year = 0,//精确到年
    DATESTYLE_Month = 1,//精确到月
    DATESTYLE_Date = 2,//精确到日
    DATESTYLE_Hour = 3,//精确到时
    DATESTYLE_Minutes= 4,//精确到分
    DATESTYLE_Seconds= 5,//精确到秒
    DATESTYLE_Ms= 5,//精确到秒
    
};


/**
 *  比较两个日期的大小,仅支持年月日
 *
 *  @param dateA  第一个日期
 *  @param dateB  第二个日期
 *  @param datePrecision 精度
 *
 *  @return 大小
 */
+ (NSComparisonResult)compareDateA:(NSDate *)dateA
                         WithDateB:(NSDate *)dateB datePrecision:(DatePrecision)datePrecision;

/**
 *  当前日期的上月或下月
 *
 *  @param cmp  当前日期
 *  @param span 时间戳
 *  @param type 精度
 *  @return 大小
 */
//上月或下月
+ (NSString *)lastOrNextMonthWith:(NSDateComponents *)cmp andSpan:(int)span andType:(int)type;

/**
 *  单独取日期中的年月日
 *
 *  @param date 日期
 *  @param type 精度
 *  @return 大小
 */
+ (NSString *)dateTimeConvertYearMonth:(NSDate *)date andType:(int)type;

/**
 *  字符串转为NSDate
 *
 *  @param dateStr 日期字符串
 *  @param datePrecision 精度
 *  @return 日期date
 */
+ (NSDate*)datetimeConversionAndDatetimeStr:(NSString *)dateStr datePrecision:(DatePrecision)datePrecision;


+ (NSString *)getMonthBeginAndEndWith:(NSString *)dateStr;


/**
 *  时间戳转换字符串
 *
 *  @param datetime 时间戳
 *  @param datePrecision 精度
 *  @return 日期Str
 */
+ (NSString *)datetimeConversionAndDatetime:(int)datetime datePrecision:(DatePrecision)datePrecision;

/**
 *  日期Date转换字符串
 *
 *  @param date 日期
 *  @param datePrecision 精度
 *  @return 日期Str
 */
+ (NSString *)datetimeConversionAndDatetimeWithDate:(NSDate *)date datePrecision:(DatePrecision)datePrecision;


/**
 *  获取时间戳
 *
 *  @param date 日期
 *  @return 时间戳str
 */
//+ (NSString *)getTimeStamp:(NSDate *)date;
@end
