//
//  JMCacheData.m
//  MiPay
//
//  Created by 低调&爱 on 16/7/22.
//  Copyright © 2016年 TTCindy. All rights reserved.
//

#import "JMCacheDataTool.h"
#import <UIKit/UIKit.h>


@implementation JMCacheDataTool


#pragma mark ************UserDefaults************
+ (void)saveDataToUserDefaultsWithData:(id)data withKey:(NSString *)key
{
    //1.获取NSUserDefaults对象
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    //2保存数据(如果设置数据之后没有同步, 会在将来某一时间点自动将数据保存到Preferences文件夹下面)
    [defaults setObject:data forKey:key];
    //3.强制让数据立刻保存
    [defaults synchronize];
}

+ (id)readDataForUserDefaultsWithKey:(NSString *)key
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

+ (void)deleteDataForUserDefaultsWithKey:(NSString *)key
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    
}



#pragma mark - 存储Log到本地  JMSaveLogDataTool
+ (void)saveLogDataUrl:(NSString *)url body:(id)body reValue:(id)reValue
{
    //将crash日志保存到Document目录下的Log文件夹下
    NSString *paths = [self getDocumentDirectory];
    NSString *logDirectory = [paths stringByAppendingPathComponent:@"Log"];
    [self createFileOrDirectory:logDirectory];//在 Document 目录下创建一个  目录
    
    NSString *logFilePath = [self logFielPath:[NSDate date]];//找到我们的file文件
    NSMutableDictionary *dic  = [[NSMutableDictionary alloc]init];
    [dic setObject:[NSDateCommon datetimeConversionAndDatetimeWithDate:[NSDate date] datePrecision:DatePrecision_Ms] forKey:@"time"];
    [dic setObject:body forKey:@"body"];
    if (reValue) {
        [dic setObject:[reValue yy_modelToJSONString] forKey:@"return_value"];
        
    }
    [dic setObject:url forKey:@"url"];
    NSString *dataStr = [dic yy_modelToJSONString];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把错误日志写到文件中
    if (![fileManager fileExistsAtPath:logFilePath]) {
        [dataStr writeToFile:logFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }else{
        NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
        [outFile seekToEndOfFile];
        [outFile writeData:[@"\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [outFile writeData:[dataStr dataUsingEncoding:NSUTF8StringEncoding]];
        [outFile closeFile];
    }
    DLog(@"--------\n%@",dataStr);
    
}
+ (NSString *)logFielPath:(NSDate *)date
{
    //将crash日志保存到Document目录下的Log文件夹下
    NSString *paths = [self getDocumentDirectory];
    NSString *logDirectory = [paths stringByAppendingPathComponent:@"Log"];
    //文件读取  nsdata
    NSString *dateStr = [NSDateCommon datetimeConversionAndDatetimeWithDate:date datePrecision:DatePrecision_Date];
    
    NSString *logFilePath = [logDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"NetWorking:%@.log",dateStr]];//找到我们的file文件
    
    return logFilePath;
}
+ (NSArray *)readLogData
{
    //将crash日志保存到Document目录下的Log文件夹下
    NSString *paths = [self getDocumentDirectory];
    NSString *logDirectory = [paths stringByAppendingPathComponent:@"Log"];
    NSArray *arr = [self getAllFileNames:logDirectory];
    NSMutableArray *logArr = [[NSMutableArray alloc]init];
    for (NSString *file in arr) {
        NSArray *arr = [file componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@":."]];
        NSString *name = arr[1];
        [logArr insertObject:name atIndex:0];
        //        [self clearCachesWithFilePath:logFilePath];
    }
    if (arr.count > 3) {
        [self clearCachesFromDirectoryPath:logDirectory];
    }
    DLog(@"日志:%@",logArr);
    
    return logArr;
}
+ (NSArray *)readLogDataEveryDayDateStr:(NSString *)dateStr
{
    NSString *logFilePath = [self logFielPath:[NSDateCommon datetimeConversionAndDatetimeStr:dateStr datePrecision:DatePrecision_Date]];//找到我们的file文件
    //    // 读取某个文件
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *data = [fileManager contentsAtPath:logFilePath];
    NSString *logStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //        DLog(@"fffffffff%@",[logStr yy]);
    
    NSArray *everyDayArr = [logStr componentsSeparatedByString:@"\n"];
    //        DLog(@"--------%@",everyDayArr);
    NSMutableArray *everyDayLogArr = [[NSMutableArray alloc]init];
    for (NSString *str in everyDayArr) {
        JMLogPM *pm = [JMLogPM yy_modelWithJSON:str];
        DLog(@"%@",pm.time);
        if(pm)
            [everyDayLogArr insertObject:pm atIndex:0];
        
    }
    return everyDayLogArr;
}
+ (void)createFileOrDirectory:(NSString *)logFilePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDir = NO;
    // fileExistsAtPath 判断一个文件或目录是否有效，isDirectory判断是否一个目录
    BOOL existed = [fileManager fileExistsAtPath:logFilePath isDirectory:&isDir];
    
    if ( !(isDir == YES && existed == YES) ) {
        
        // 在 Document 目录下创建一个 head 目录
        [fileManager createDirectoryAtPath:logFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
}

+ (void)sendLogToEmailLog:(id)logStr
{
    NSDictionary *dic = (NSDictionary *)logStr;
    /**
     *  把异常崩溃信息发送至开发者邮件
     */
    NSMutableString *mailUrl = [NSMutableString string];
    [mailUrl appendString:@"mailto:493761458@qq.com"];
    [mailUrl appendString:@"?subject=程序异常崩溃，请配合发送异常报告，谢谢合作！"];
    [mailUrl appendFormat:@"&body=%@", dic];
    // 打开地址
    NSString *mailPath = [mailUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailPath]];
    
}


#pragma mark - 获取沙盒Document的文件目录
+ (NSString *)getDocumentDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - 获取沙盒Library的文件目录
+ (NSString *)getLibraryDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - 获取沙盒Library/Caches的文件目录
+ (NSString *)getCachesDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - 获取沙盒Preference的文件目录
+ (NSString *)getPreferencePanesDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - 获取沙盒tmp的文件目录
+ (NSString *)getTmpDirectory{
    return
    NSTemporaryDirectory();
}

#pragma mark - 根据路径返回目录或文件的大小
#pragma mark ***********文件夹大小************
+ (double)sizeWithFilePath:(NSString *)path{
    // 1.获得文件夹管理者
    NSFileManager *manger = [NSFileManager defaultManager];
    
    // 2.检测路径的合理性
    BOOL dir = NO;
    BOOL exits = [manger fileExistsAtPath:path isDirectory:&dir];
    if (!exits) return 0;
    
    // 3.判断是否为文件夹
    if (dir) { // 文件夹, 遍历文件夹里面的所有文件
        // 这个方法能获得这个文件夹下面的所有子路径(直接\间接子路径)
        NSArray *subpaths = [manger subpathsAtPath:path];
        int totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullsubpath = [path stringByAppendingPathComponent:subpath];
            
            BOOL dir = NO;
            [manger fileExistsAtPath:fullsubpath isDirectory:&dir];
            if (!dir) { // 子路径是个文件
                NSDictionary *attrs = [manger attributesOfItemAtPath:fullsubpath error:nil];
                totalSize += [attrs[NSFileSize] intValue];
            }
        }
        return totalSize / (1024 * 1024.0);
    } else { // 文件
        NSDictionary *attrs = [manger attributesOfItemAtPath:path error:nil];
        return [attrs[NSFileSize] intValue] / (1024.0 * 1024.0);
    }
}

#pragma mark - 得到指定目录下的所有文件
+ (NSArray *)getAllFileNames:(NSString *)dirPath{
    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:dirPath error:nil];
    return files;
}

#pragma mark - 删除指定目录或文件
+ (BOOL)clearCachesWithFilePath:(NSString *)path{
    NSFileManager *mgr = [NSFileManager defaultManager];
    return [mgr removeItemAtPath:path error:nil];
}

#pragma mark - 清空指定目录下文件
+ (BOOL)clearCachesFromDirectoryPath:(NSString *)dirPath{
    
    //获得全部文件数组
    NSArray *fileAry =  [JMCacheDataTool getAllFileNames:dirPath];
    //遍历数组
    BOOL flag = NO;
    for (NSString *fileName in fileAry) {
        NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
        flag = [JMCacheDataTool clearCachesWithFilePath:filePath];
        
        if (!flag)
            break;
    }
    
    return flag;
}

#pragma mark - 清空所有缓存文件
+ (void)clearTheAllCache
{
    //彻底清除缓存第一种方法
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths lastObject];
    
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:path];
    //    NSArray *subpathArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString *p in files) {
        NSError *error;
        NSString *Path = [path stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:Path]) {
            [[NSFileManager defaultManager] removeItemAtPath:Path error:&error];
        }
    }
    
    
}



@end
