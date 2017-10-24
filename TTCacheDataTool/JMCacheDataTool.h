//
//  JMCacheData.h
//  MiPay
//
//  Created by 低调&爱 on 16/7/22.
//  Copyright © 2016年 TTCindy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDateCommon.h"
#import "JMLogPM.h"

@interface JMCacheDataTool : NSObject

#pragma mark ************UserDefaults************

/**
 *  存储数据Userdefaults
 *
 *  @param data data
 *  @param key  key
 */
+ (void)saveDataToUserDefaultsWithData:(id)data withKey:(NSString *)key;

/**
 *  读取数据Userdefaults
 *
 *  @param key  key
 */
+ (id)readDataForUserDefaultsWithKey:(NSString *)key;

/**
 *  删除数据Userdefaults
 *
 *  @param key key
 */
+ (void)deleteDataForUserDefaultsWithKey:(NSString *)key;

#pragma mark************SandBox沙盒************

/**
 *  获取沙盒Document的文件目录
 *
 *  @return 文件目录
 */
+ (NSString *)getDocumentDirectory;

/**
 *  获取沙盒Library的文件目录
 *
 *  @return 文件目录
 */
+ (NSString *)getLibraryDirectory;

/**
 *  获取沙盒Library/Caches的文件目录
 *
 *  @return 文件目录
 */
+ (NSString *)getCachesDirectory;

/**
 *  获取沙盒Preference的文件目录
 *
 *  @return 文件目录
 */
+ (NSString *)getPreferencePanesDirectory;

/**
 *  获取沙盒tmp的文件目录
 *
 *  @return 文件目录
 */
+ (NSString *)getTmpDirectory;

#pragma mark**************清理缓存**************
/**
 *  根据路径返回目录或文件的大小
 *
 *  @param path 路径
 *
 *  @return 文件大小
 */
+ (double)sizeWithFilePath:(NSString *)path;

/**
 *  得到指定目录下的所有文件
 *
 *  @param dirPath 目录
 *
 *  @return 所有文件
 */
+ (NSArray *)getAllFileNames:(NSString *)dirPath;

/**
 *  删除指定目录或文件
 *
 *  @param path 路径
 *
 *  @return BOOL 是否删除
 */
+ (BOOL)clearCachesWithFilePath:(NSString *)path;

/**
 *  清空指定目录下文件
 *
 *  @param dirPath 路径
 *
 *  @return BOOL 是否清空目录文件
 */
+ (BOOL)clearCachesFromDirectoryPath:(NSString *)dirPath;

/**
 *  清空所有缓存
 */
+ (void)clearTheAllCache;

/**
 *  保存网络请求日志到本地
 */
+ (void)saveLogDataUrl:(NSString *)url body:(id)body reValue:(id)reValue;

/**
 *  获取本地的日志日期记录
 */
+ (NSArray *)readLogData;

/**
 *  获取本地每天的日志记录
 */
+ (NSArray *)readLogDataEveryDayDateStr:(NSString *)dateStr;
/**
 *  发送message到email
 */
+ (void)sendLogToEmailLog:(id)logStr;
@end
